module Api::V1::Web
	class EventsController < ApiController
	  	before_action :get_event_id ,only:[:event_details]
	  	before_action :get_event_data ,only:[:event_details]

		def today_event
			events_list = Event.fetch_event("today")	
		 	if events_list.present?
   			events = get_event_details(events_list)
  		else
   			events = 0
  		end
			response = {:status=>true,:events=>events, :total_events=> events.count}
			json_response(response)
		end

		def paid_event
			events_list = Event.fetch_event("paid")	
			if events_list.present?
   			events = get_event_details(events_list)
  		else
   			events = 0
  		end
			response = {:status=>true,:events=>events, :total_events=> events.count}
			json_response(response)
		end

		def free_event
			events_list = Event.fetch_event("free")
			if events_list.present?
   			events = get_event_details(events_list)
  		else
   			events = 0
  		end	
			response = {:status=>true,:events=>events, :total_events=> events.count}
			json_response(response)
		end

		def recent_event
			events_list = Event.fetch_event('')
			if events_list.present?
   			events = get_event_details(events_list)
  		else
   			events = 0
  		end	
			response = {:status=>true,:events=>events, :total_events=> events.count}
			json_response(response)
		end

		def event_details

			@event_image = @event.attachments.present? ? @event.attachments.first.attachment.url : '/default_image.jpg';
			@event_currency = @event.currency.present? ? @event.currency: ''
			event_type = @event.event_type=="0" ? "free" : "paid"
			artists= []
			@event_artists.each do |a|
				artists<< {:id=> a.id,:name=>a.name ,:address=>a.address,:description=> a.description, :type=> a.artist_type, :image=> a.attachments.present? ? @event.attachments.first.attachment.url : '/default_image.jpg'}
			end
	 		event_date_time = {:start_date=>@event_dates.start_date,:end_date=>@event_dates.end_date ,:start_time=>@event_dates.start_time,:end_time=>@event_dates.end_time}
			event_location= {:address=>@event_location.address,:latitude=>@event_location.latitude,:longitude=>@event_location.longitude,:venue=>@event_location.venue,:locality=> @event_location.city,:administrative_area_level_1=>@event_location.state,:country=>@event_location.country}

			event = {:id=>@event.id,:title=>@event.title, :description=> @event.description, :ticket_available=>@event.ticket_available,:cost=>@event.cost, :currency=>@event_currency, :contact_number=>@event.contact_number,:cost_offers=>@event.cost_offers, :email=>@event.email, :event_type=>event_type, :status=>@event.status, :event_categories=>@event_categories.map(&:name), :event_location=>event_location,
			  :event_artists=>artists, :event_date=>event_date_time, :image=>@event_image}
			 response ={:status=>true, :event=>event}
			    
			json_response(response)
		end


		def get_event_details(events)
      @events= []
      events.each do |event|
        @event_image = event.attachments.present? ? event.attachments.first.attachment.url : '/default_image.jpg';
        @events << {:title=>event.title, :id=>event.id, :description=>event.description, :ticket_available => event.ticket_available, :cost=> event.cost, :currency=> event.currency, :contact_number => event.contact_number, :image=> @event_image,
        :cost_offers=>event.cost_offers, :email=>event.email, :event_type => event.event_type, :status=> event.status,:approved=>event.approved, :event_categories=> event.categories.map(&:name), :event_artists=>event.artists.map(&:name), :event_added_by=>event.user.user_name,:event_location=>event.locations.first.address,:latitude=>event.locations.first.latitude,:longitude=>event.locations.first.longitude,:city=>event.locations.first.city,:state=>event.locations.first.state,:venue=>event.locations.first.venue,:country=>event.locations.first.country, :event_date=>event.event_adver_dates.map{|a| [a.start_date, a.end_date]}.flatten!}
      end
      return @events
    end

		private

		def get_event_id
	    	@event = Event.find params[:id]
	  	end

	  	def get_event_data
		    @event_categories =  @event.categories
		    @event_artists =  @event.artists
		    @event_location = @event.locations.first
		    @event_dates = @event.event_adver_dates.first
	  	end
	end
end
