class TodoItem
  include Listable
  include Comparable

  attr_reader :description, :due, :priority
  @@priority_pagination = {"low"=>1, "medium"=>2, "high"=>3}
  @@priority_pagination.default = 0

  def initialize(description, options={})
    @description = description
    @due = options[:due] ? Chronic.parse(options[:due]) : options[:due]
    @priority = options[:priority] ? options[:priority] : 0
  end

  def format_priority
    value = " ⇧".colorize(:red) if @priority == "high"
    value = " ⇨".colorize(:yellow) if @priority == "medium"
    value = " ⇩".colorize(:green) if @priority == "low"
    value = "" if @priority == 0 # previously !@priority
    return value
  end

  def details
    format_description(@description) + "due: ".colorize(:red) + format_date(due:@due) +  format_priority
  end

  def <=>(other)
    @@priority_pagination[self.priority] <=> @@priority_pagination[other.priority]
  end

end
