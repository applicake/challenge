module List
  
  def self.create_list
    LinkedList.new
  end
  
  def self.create_list_element(obj)
    LinkedListElement.new obj
  end

  class LinkedListElement

    attr_accessor :obj, :next, :prev
  
    def initialize(obj)
      @obj = obj
    end
  
  end

  class LinkedList
  
    attr_accessor :head, :tail
  
    def empty?
      @head.nil?
    end
  
    # ML Inserts element into list before the element passed as position.
    # If position is nil the new element is inserted at the end of the list.
    def insert(element, position = nil)
      return if element.nil?
      if empty?
        element.next = element
        element.prev = element
        @head = element
        @tail = element
      elsif position.nil?
        @tail.next = element
        element.prev = @tail
        element.next = @head
        @head.prev = element
        @tail = element
      else
        element.prev = position.prev
        element.prev.next = element
        position.prev = element
        element.next = position
        @head = element if @head == position
      end
    end
  
    def insert_list(list, position = nil)
      return if list.nil? or list.empty?
      if empty?
        @head = list.head
        @tail = list.tail
      elsif position.nil?
        @tail.next = list.head
        list.head.prev = @tail
        list.tail.next = @head
        @head.prev = list.tail
        @tail = list.tail
      else
        list.head.prev = position.prev
        position.prev.next = list.head
        list.tail.next = position
        position.prev = list.tail
        @head = list.head if @head == position
      end
    end
  
    # ML The method retrieves the list element at given index. Head is at index 0.
    def retrieve_at(index)
      if empty?
        nil
      else
        current_element = @head
        index.times { current_element = current_element.next }
        current_element
      end
    end
    
    def remove(element)
      if @head == @tail
        @head = nil
        @tail = nil
      else
        element.prev.next = element.next
        element.next.prev = element.prev
        @head = element.next if element == @head
        @tail = element.prev if element == @tail
      end
    end
  
    # ML Removes a list of elements starting at start_element and ending
    # at end_element (start_element and end_element are also removed). 
    # Returns the removed list.
    def remove_range(start_element, end_element)
      removed_list = LinkedList.new
      removed_list.head = start_element
      removed_list.tail = end_element
      if @head == start_element and @tail == end_element
        @head = nil
        @tail = nil
      elsif @head == start_element
        @head = end_element.next
        @head.prev = @tail
        @tail.next = @head
      elsif @tail == end_element
        @tail = start_element.prev
        @tail.next = @head
        @head.prev = @tail
      else
        start_element.prev.next = end_element.next
        end_element.next.prev = start_element.prev
      end
      start_element.prev = end_element
      end_element.next = start_element
      removed_list
    end
  
    def move_down(element, steps = 1)
      current_element = element.next
      remove(element)
      if empty?
        insert(element)
      else
        steps.times { current_element = current_element.next }
        current_element = nil if current_element == @head
        insert(element, current_element)
      end
    end
  
    def print
      if @head == nil
        puts "Empty"
      else
        current = @head
        while current != @tail
          current.obj.print
          current = current.next
        end
        @tail.obj.print
      end
    end
    
  end
  
end