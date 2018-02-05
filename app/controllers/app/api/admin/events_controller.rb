class App::Api::Admin::EventsController < AdminController
  before_action :get_category_and_artist ,only:[:create,:new, :edit, :update, :show]
  before_action :get_event_id ,only:[:edit, :destroy, :update ,:show]
  before_action :get_event_data ,only:[:edit, :update, :show]
  def index
  @events =  Event.all
  render :json=>{:status=>true, :events=>@events}
  end

  # def new
  #   @event = Event.new
  # end
  def create
    if params[:auth_token].present?
        user = User.find_by_auth_token(params[:auth_token])
        if user.present?
          @event = user.events.new(event_params)
             @event.category_ids = params[:category_ids]
            @event.artist_ids = params[:artist_ids]
            @event.event_location = event_location
             @event.event_dates = event_dates
            if @event.save
              if event_image_param.present?
               @event.attachments.create(event_image_param)
              end
              render :json=>{:notice=> "Event successfuly added", :status=> true}
            else
              render :json=>{:message=>@event.errors.full_messages, :status=> false}
            end
        else
          render :json=>{:notice=> "Plase provide valid token", :status=> false}
        end
      else
        render :json =>{:notice=>"Invalid toekn", :status=>false }
      end
  end

  def edit
    @event_currency = @event.currency.present? ? @event.currency: ''
    event_date_time = {:start_date=>@event_dates.start_date,:end_date=>@event_dates.end_date ,:start_time=>@event_dates.start_time,:end_time=>@event_dates.end_time}
    event_location= {:address=>@event_location.address,:latitude=>@event_location.latitude,:longitude=>@event_location.longitude,:venue=>@event_location.venue}
    response = {:event_categories=>@event_categories.map(&:id), :event_location=>event_location,
      :event_artists=>@event_artists.map(&:id),:event_date=>event_date_time,:event=>@event}

    render :json=>{:status=> true,:data=>response}
  end

  def update
      @event.category_ids = params[:category_ids]
      @event.artist_ids = params[:artist_ids]
      @event.event_location = event_location
      @event.event_dates = event_dates
        if @event.update(event_params)
          if event_image_param.present?
            if @event.attachments.present?
              @event.attachments.update(event_image_param)
            else
              @event.attachments.create(event_image_param)
            end
          end
          render :json=>{:notice=> "Event Update successfuly.", :status=> true}
        else
          render :json=>{:notice=> "something went wrong.", :status=> false, :errors=>@event.errors.full_messages}
        end
  end

  def destroy
    if @event.destroy
      render :json => {:status=> true, :messages=> "Event has been Deleted successfully.", :data => @event}
    else
      render :json => {:status=> false, :messages=> @event.errors.full_messages}
    end
  end

  def show
   # @event_categories = @event.categories.map(&:name)
   # @event_artists = @event.artists.map(&:name)
   @event_currency = @event.currency.present? ? @event.currency: ''
  end

  private

  def event_params
    params.require(:event).permit(:title,:description,:ticket_available,:email,:currency, :cost, :contact_number, :cost_offers, :event_type)
  end

  def get_category_and_artist
    @categories = Category.all
    @artists = Artist.all
  end

  def event_image_param
    params.require(:event).permit(:attachment)
  end

  def get_event_id
    @event = Event.find params[:id]
  end

  def event_location
    params.require(:location).permit!
  end

  def event_dates
    params.require(:event_date).permit!
  end
  def get_event_data
    @event_categories =  @event.categories
    @event_artists =  @event.artists
    @event_location = @event.locations.first
    @event_dates = @event.event_adver_dates.first
  end

  def check_param_valid
    if event_location[:address].present? && event_location[:latitude].present? && event_location[:longitude].present? && event_location[:venue].present? && event_dates[:start_date].present? && event_dates[:end_date].present? && event_dates[:start_time].present?&& event_dates[:end_time].present?
      return true
    else
      return false
    end
  end
end