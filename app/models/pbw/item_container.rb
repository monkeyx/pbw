module Pbw
  class ItemContainer
    include ::Mongoid::Document
    include ::Mongoid::Timestamps

    belongs_to :item, foreign_key: 'item_id', autosave: true, class_name: "::Pbw::Item"
    field :quantity, type: Float, default: 0
    validates_numericality_of :quantity, :greater_than_or_equal_to => 0

    embedded_in :container, class_name: "::Pbw::Container"
    
    attr_accessible :container, :item, :quantity

    def add_item(quantity)
    	return remove_item!(quantity.abs) if quantity < 0
    	return false unless self.item.before_add(self,quantity)
    	self.quantity = self.quantity + quantity
    	self.item.after_add(self,quantity)
    	self
    end

    def remove_item(quantity)
    	return add_item!(quantity.abs) if quantity < 0
    	return false unless self.item.before_remove(self,quantity)
    	self.quantity = self.quantity - quantity
    	self.item.after_remove(self,quantity)
    	self
    end

    def empty?
    	self.quantity == 0
    end
  end
end
