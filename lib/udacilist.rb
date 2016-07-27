class UdaciList
  attr_reader :title, :items

  def initialize(options={})
    @title = options[:title] || "Untitled List"
    @items = []
  end

  def add(type, description, options={})
    type = type.downcase
    @@valid_event_types = "todo event link".freeze
    @@valid_priorities = "low medium high" # only applies to TodoList items

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

  # displays the entire list
  def all(items_=@items)
    puts "-".colorize(:cyan) * @title.length
    puts @title.colorize(:cyan)
    puts "-".colorize(:cyan) * @title.length
    items_.each_with_index do |item, position|
      puts "#{position + 1}) #{item.details}"
    end
  end

  def filter(item_type)
    list_types = {"todo" => TodoItem, "event" => EventItem, "link" => LinkItem}
    class_name = list_types[item_type]

    arr = []
    if @@valid_event_types[item_type]
      arr = @items.find_all{|i| i.class.equal? class_name }
    end

    if arr.empty?
      puts "Item type #{item_type} is not on #{self.title}."
    else
      all(arr) # display list of item type
    end
  end

end # class UdaciList