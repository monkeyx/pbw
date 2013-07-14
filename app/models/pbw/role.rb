module Pbw
  class Role
    include ::Mongoid::Document
    include ::Mongoid::Timestamps
    field :name, type: String
    attr_accessible :name
    has_many :users

    validates :name, presence: true, uniqueness: true

    has_and_belongs_to_many :permissions

    def set_permission(subject_class, action)
    	p = Permission.where(subject_class: subject_class, action: action)
    	p = Permission.create(subject_class: subject_class, action: action) unless p
    	self.permissions << p
    end

    def set_permissions(permissions)
    	permissions.each do |id|
    		permission = Permission.find(id)
    		self.permissions << p
    	end
    end
  end
end
