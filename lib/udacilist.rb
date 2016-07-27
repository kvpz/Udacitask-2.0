class UdaciList
  attr_reader :title, :items

  def initialize(options={})
    @title = options[:title] || "Untitled List"
    @items = []
  end

  def add(type, description, options={})
    type = type.downcase
    @@valid_event_types = "todo event link".freeze
    @@valid_priorities = "low medium high".freeze

    if !@@valid_event_types[type]
      raise UdaciListErrors::InvalidItemType, "InvalidItemType: type must be 'todo', 'event' or 'link'"
    end
    if options[:priority] && !@@valid_priorities[options[:priority]]
      raise UdaciListErrors::InvalidPriorityValue "InvalidPriorityValue: priority values must be 'low', 'medium' or 'high'."
    end

    @items.push TodoItem.new(description, options) if type == "todo"
    @items.push EventItem.new(description, options) if type == "event"
    @items.push LinkItem.new(description, options) if type == "link"
  end

  def delete(index)
    if index > items.size
      raise UdaciListErrors::IndexExceedsListSize, "IndexExceedsListSize: '#{index}' exceeds array 'items' size."
    else
      @items.delete_at(index - 1)
    end
  end

  def all
    puts "-".colorize(:cyan) * @title.length
    puts @title.colorize(:cyan)
    puts "-".colorize(:cyan) * @title.length
    @items.each_with_index do |item, position|
      puts "#{position + 1}) #{item.details}"
    end
  end

  def filter(event)
    if @@valid_event_types[event]

    end

  end
end
