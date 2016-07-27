class UdaciList
  attr_reader :title, :items

  def initialize(options={})
    @title = options[:title]
    @items = []
  end

  def add(type, description, options={})
    type = type.downcase
    valid_types = "todo event link"
    if !valid_types[type]
      raise UdaciListErrors::InvalidItemType, "InvalidItemType: #{type} must be 'todo', 'event' or 'link'"
    else
      @items.push TodoItem.new(description, options) if type == "todo"
      @items.push EventItem.new(description, options) if type == "event"
      @items.push LinkItem.new(description, options) if type == "link"
    end
  end

  def delete(index)
    if index > items.size
      raise UdaciListErrors::IndexExceedsListSize, "IndexExceedsListSize: #{index} exceeds array 'items' size."
    else
      @items.delete_at(index - 1)
    end
  end

  def all
    puts "-" * @title.length
    puts @title
    puts "-" * @title.length
    @items.each_with_index do |item, position|
      puts "#{position + 1}) #{item.details}"
    end
  end
end
