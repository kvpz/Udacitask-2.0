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
    class_name = String.new
    class_name = "TodoItem" if item_type == "todo"
    class_name = "EventItem" if item_type == "event"
    class_name = "LinkItem" if item_type == "link"

    arr = Array.new
    if @@valid_event_types[item_type]
      @items.each do |i|
        if i.class.to_s == class_name
          arr << i
        end
      end
    end

    if arr.empty?
      puts "There is no such type in the list."
    else
      all(arr) # display list of item type
    end
  end

end # class UdaciList