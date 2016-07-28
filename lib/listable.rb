module Listable
  def format_description(description)
    "#{description}".ljust(30)
  end

  def format_date(dates={})
    if !dates.empty?
      if(dates.has_key?(:due)) # if TodoItem date
        return dates[:due] ? dates[:due].strftime('%D') : "No due date"
      else  # if EventItem date
        d = dates.reject{|k,v| v == nil}
        return d[:start_date].strftime('%D') + " -- " + d[:end_date].strftime('%D') if d.size == 2
        return d[:start_date].strftime('%D') if d[:start_date]
        return d[:end_date].strftime('%D') if d[:end_date]
        return "N/A"
      end
    end
  end

end
