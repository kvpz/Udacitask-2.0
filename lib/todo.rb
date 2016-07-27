class TodoItem
  include Listable
  attr_reader :description, :due, :priority
  
  def initialize(description, options={})
    @description = description
    @due = options[:due] ? Chronic.parse(options[:due]) : options[:due]
    @priority = options[:priority]
  end

  def format_priority
    value = " ⇧".colorize(:red) if @priority == "high"
    value = " ⇨".colorize(:yellow) if @priority == "medium"
    value = " ⇩".colorize(:green) if @priority == "low"
    value = "" if !@priority
    return value
  end

  def details
    format_description(@description) + "due: ".colorize(:red) + format_date(due:@due) +  format_priority
  end
end
