module Pbw
  class ItemConversion
    include ::Mongoid::Document
    include ::Mongoid::Timestamps
    belongs_to :item
    field :from, :type => Hash

    def set_from_item(item, quantity)
    	return false unless item && quantity
    	self.from ||= {}
    	self.from[item._id] = quantity
    	self
    end

    def from_items
    	return @items if defined?(@items) && !changed?
    	return {} unless self.from && !self.from.empty?
    	@items = {}
    	self.from.keys.each do |id| 
    		begin
    			@items[Item.find(id)] = self.from[id]
    		rescue Exception => e
    			logger.error e
    		end
    	end
    	@items
    end

    def token_from_items_containers(token)
    	containers = {}
    	from_items.keys.each do |from_item|
    		containers[from_item] = ItemContainer.find_for_token(token,from_item)
    	end
    	containers
    end

    def self.max_convert(token, item)
    	return 0 unless token && item && token.can_convert?(item)
    	conversion = where(item: item).first
    	return 0 unless conversion
    	containers = conversion.token_from_items_containers(token)
    	quantity = 0
    	containers.keys.each do |from_item|
    		unless containers[from_item]
    			quantity = 0 
    		else
    			quantity = containers[from_item].quantity / conversion.from_items[from_item]
    		end
    	end
    	quantity
    end

    def self.convert!(token, item, quantity=1)
    	return false unless token && item && quantity && token.can_convert?(item)
    	conversion = where(item: item).first
    	return false unless conversion
    	containers = conversion.token_from_items_containers(token)
    	containers.keys.each do |from_item|
    		return false unless containers[from_item] && containers[from_item].quantity >= (conversion.from_items[from_item] * quantity)
    	end
    	containers.keys.each do |from_item|
    		containers[from_item].remove_item(conversion.from_items[from_item] * quantity)
    		containers[from_item].save
    	end
    	unless token.add_item!(item,quantity)
    		containers.keys.each do |from_item|
	    		containers[from_item].add_item(conversion.from_items[from_item] * quantity)
	    		containers[from_item].save
	    	end
    	end
    end
  end
end
