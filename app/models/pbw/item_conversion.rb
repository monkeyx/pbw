module Pbw
  class ItemConversion
    include ::Mongoid::Document
    include ::Mongoid::Timestamps

    embedded_in :item, class_name: '::Pbw::Item'
    field :from, type: Hash

    attr_accessible :item, :from

    def set_from_item(item, quantity)
    	raise PbwArgumentError('Invalid from item') unless item && quantity
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
            c = token.item_container(from_item)
    		containers[from_item] = c if c
    	end
    	containers
    end

    def self.max_convert(token, item)
        raise PbwArgumentError('Invalid token') unless token
        raise PbwArgumentError('Invalid item') unless item
    	return 0 unless token.can_convert?(item)
    	conversion = item.item_conversions.first
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
        raise PbwArgumentError('Invalid token') unless token
        raise PbwArgumentError('Invalid item') unless item
        raise PbwArgumentError('Invalid quantity') unless quantity
    	return false unless token.can_convert?(item)
    	conversion = item.item_conversions.first
    	return false unless conversion
    	containers = conversion.token_from_items_containers(token)
    	containers.keys.each do |from_item|
    		return false unless containers[from_item] && containers[from_item].quantity >= (conversion.from_items[from_item] * quantity)
    	end
    	containers.keys.each do |from_item|
    		containers[from_item].remove_item!(conversion.from_items[from_item] * quantity)
    		containers[from_item].save!
    	end
    	unless token.add_item!(item,quantity)
    		containers.keys.each do |from_item|
	    		containers[from_item].add_item!(conversion.from_items[from_item] * quantity)
	    		containers[from_item].save!
	    	end
    	end
    end
  end
end
