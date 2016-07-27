module Listable
  def format_description(description)
    "#{description}".ljust(30)
  end

  def format_date(dates={})
    if !dates.empty?
      if(dates.has_key?(:due)) # TodoItem date
        return dates[:due] ? dates[:due].strftime('%D') : "No due date"
      else
        d = dates.reject{|k,v| v == nil}
        return d[:start_date].strftime('%D') + " -- " + d[:end_date].strftime('%D') if d.size == 2
        return d[:start_date].strftime('%D') if d[:start_date]
        return d[:end_date].strftime('%D') if d[:end_date]
        return "N/A"
      end
    end
  end

end

=begin
# for TodoItem
def format_date
  @due ? @due.strftime("%D") : "No due date"
end

# For EventItem
def format_date(start_date, end_date)
  dates = @start_date.strftime("%D") if @start_date
  dates << " -- " + @end_date.strftime("%D") if @end_date
  dates = "N/A" if !dates
  return dates
end
=end