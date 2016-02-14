module G::EventsHelper

  def weekend?(day)
    if day.strftime('%w') == "6" || day.strftime('%w') == "0"
      return "weekend"
    end
  end

  def weekend_or_number?(day)
    weekend?(day) || "number"
  end

  def today?(day)
    return "today" if day == Date.today
  end

  def first?(index)
    return "active" if index == 0
  end

  def toggle_now_or_wrap?(index)
    if index == 0
      "toggle_now"
    else
      "toggle_wrap"
    end
  end

  def has_event?(date, events)
		events.any? { |event| event.date.to_date == date }
	end

  def remaining_time(date)
    if Time.zone.now == date
      "Aujourd'hui!"
    else
      if Time.zone.now == date - 1.day
        "Demain!"
      else
        "Dans " + time_ago_in_words(date)
      end
    end
  end

end
