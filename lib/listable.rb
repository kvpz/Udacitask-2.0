module Listable
  def format_description(description)
    "#{description}".ljust(30)
  end

  # EventItem could have up to 2 dates
  def format_date(dates = {})

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

  def format_priority

  end

end
