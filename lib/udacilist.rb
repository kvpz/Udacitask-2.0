require 'terminal-table'

class UdaciList
  attr_reader :title, :items

  def initialize(options={})
    @title = options[:title] || "Untitled List"
    @items = []
  end

  def add(type, description, options={})
    type = type.downcase
    @@valid_event_types = "todo event link".freeze
    @@valid_priorities = "low medium high".freeze # only applies to TodoList items

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

  def delete_by_description(desc)
    desc.downcase!
    index = self.items.find_index{|item| item.description.downcase.eql?(desc)}
    if !index.nil?
      self.delete(index+1)
    end
  end

  # displays a list (sorted)
  def all(items_=@items)
    self.sort_by_type
    table = Terminal::Table.new :title => @title.colorize(:cyan)
    previous_item_type = nil
    items_.each.with_index do |item, i|
      if previous_item_type != item.class
        table << :separator
        table.add_row(["#{item.class}".colorize(:blue)])
        table << :separator
        previous_item_type = item.class
      end
      table << ["#{i+1}) "+ item.details]
    end
    puts table

  end

  # it displays items of one type and it returns
  def filter(item_type)
    types = {"todo" => TodoItem, "event" => EventItem, "link" => LinkItem}
    class_name = types[item_type.downcase]
    arr = []
    # store items of one type in arr
    if @@valid_event_types[item_type]
      arr = @items.find_all{|i| i.class.equal? class_name}
    end
    arr.empty? ? (puts "Item type #{item_type} is not on #{self.title}.") : all(arr) # display list of item type
  end

  def sort_by_type
    @items.sort_by!{|i| i.class.to_s}
  end

  def show_prioritized_todo
    todo_items = @items.find_all{|i| i.class.equal? TodoItem}
    if !todo_items.nil?
      todo_items.sort!{|a,b|  b <=> a}
      all(todo_items)
    end
  end

  def empty?
    return items.empty?
  end


end # class UdaciList