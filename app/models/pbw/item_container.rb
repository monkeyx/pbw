module Pbw
  class ItemContainer
    include ::Mongoid::Document
    include ::Mongoid::Timestamps
    belongs_to :item, foreign_key: 'item_id', autosave: true
    field :quantity, type: Float, default: 0
    validates_numericality_of :quantity, :greater_than_or_equal_to => 0

    belongs_to :token, foreign_key: 'token_id', autosave: true
    belongs_to :area, foreign_key: 'area_id', autosave: true
    belongs_to :user, foreign_key: 'user_id', autosave: true

    attr_accessible :item, :token, :area, :user, :quantity

    def self.viewable_by?(user, subject)
        user.admin? || subject.user == user || (subject.token && subject.token.user == user)
    end

    def self.creatable_by?(user, subject)
        true
    end

    def self.editable_by?(user, subject)
        user.admin? || subject.user == user || (subject.token && subject.token.user == user)
    end

    def self.deletable_by?(user, subject)
        user.admin?
    end

    def self.find_or_create_for_token(token, item, quantity_to_add)
    	container = where(token: token, item: item).first
    	container = create!(token: token, item: item) unless container
    	container.add_item(quantity_to_add)
        container.save!
        container
    end

    def self.find_for_token(token, item)
        where(token: token, item: item).first
    end

    def self.find_or_create_for_area(area, item, quantity_to_add)
    	container = where(area: area, item: item).first
    	container = create!(area: area, item: item) unless container
    	container.add_item(quantity_to_add)
        container.save!
        container
    end

    def self.find_for_area(area, item)
        where(area: area, item: item).first
    end

    def self.find_or_create_for_user(user, item, quantity_to_add)
    	container = where(user: user, item: item).first
    	container = create!(user: user, item: item) unless container
    	container.add_item(quantity_to_add)
        container.save!
        container
    end

    def self.find_for_user(user, item)
        where(user: user, item: item).first
    end

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

    def transfer_item!(to, quantity)
    	raise PbwArgumentError('Invalid item transfer') unless to && quantity 
        return false unless self.item.before_transfer(belongs_to, to, quantity)
    	if to.class.ancestors.include?(Area)
    		container = find_or_create_for_area(to, self.item, quantity)
    	elsif to.class.ancestors.include?(Token)
    		container = find_or_create_for_token(to, self.item, quantity)
    	elsif to.class.ancestors.include?(Pbw::Engine.user_class)
    		container = find_or_create_for_user(to, self.item, quantity)
    	else
    		raise PbwArgumentError('Invalid destination for item transfer')
    	end
        remove_item(quantity)
    	save!
        unless container
    		add_item(quantity)
            save!
    		raise PbwOperationError('Unable to add item') 
    	else
    		self.item.after_transfer(belongs_to, to, quantity)
    		container
    	end
    end

    def belongs_to
    	self.token || self.area || self.user
    end

    def empty?
    	self.quantity == 0
    end
  end
end
