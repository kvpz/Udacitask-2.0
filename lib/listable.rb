module Listable
  def format_description(description)
    "#{description}".ljust(30)
  end

  # Possible dates keys: :due, :start_date, :end_date, {:start_date, :end_date}, none
  #
  def format_date(dates={})
    if !dates.empty?
      if(dates.has_key?(:due) && dates[:due]) # TodoItem date
        return dates[:due].strftime('%D')
      else
        d = dates.reject{|k,v| v == nil}
        return "#{d[:start_date]} --> #{d[:end_date]}" if d.size == 2
        return "#{d[:start_date]}" if d[:start_date]
        return "#{d[:end_date]}" if d[:end_date]
        return ""
      end
    end
  end


=begin
  def format_priority

  end

  # For EventItem
  def format_date(start_date, end_date)
    dates = @start_date.strftime("%D") if @start_date
    dates << " -- " + @end_date.strftime("%D") if @end_date
    dates = "N/A" if !dates
    return dates
  end

  # for TodoItem
  def format_date
    @due ? @due.strftime("%D") : "No due date"
  end


=end
end
