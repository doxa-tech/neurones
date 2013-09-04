module Group::BaseHelper

	def match_event(date, events)
		result = nil
		events.each do |event|
			if event.date.to_date == date
				result = event
			else
				result = nil
			end
			break if result
		end
		return result
	end

end