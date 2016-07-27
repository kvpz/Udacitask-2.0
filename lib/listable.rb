module Listable
  def format_description(description)
    "#{description}".ljust(30)
  end

  # Possible dates keys: :due, :start_date, :end_date, {:start_date, :end_date}, none
  #
  def format_date(dates={})
    if !dates.empty?
      if(dates.has_key?(:due) && dates[:due]) # TodoItem date
        return Date.parse(dates[:due].to_s).to_s
        #return Date.parse("#{Chronic.parse(dates[:due])}").to_s
      elsif(dates)
        return
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
