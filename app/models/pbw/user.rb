module Pbw
  class User
    include ::Mongoid::Document
    include ::Mongoid::Timestamps

    ROLES = %W{superadmin admin moderator player}
    
    devise :database_authenticatable, :registerable, :timeoutable, 
           :recoverable, :rememberable, :trackable, :validatable, :lockable

    ## Database authenticatable
    field :email,              :type => String, :default => ""
    field :encrypted_password, :type => String, :default => ""
    
    ## Recoverable
    field :reset_password_token,   :type => String
    field :reset_password_sent_at, :type => Time

    ## Rememberable
    field :remember_created_at, :type => Time

    ## Trackable
    field :sign_in_count,      :type => Integer, :default => 0
    field :current_sign_in_at, :type => Time
    field :last_sign_in_at,    :type => Time
    field :current_sign_in_ip, :type => String
    field :last_sign_in_ip,    :type => String

    field :name,   :type => String
    validates_presence_of :name
    validates_uniqueness_of :name, :email, :case_sensitive => false
    validates_format_of :email, :with => /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/
    validates_confirmation_of :password

    field :role, :type => String, :default => 'player'

    ## Lockable
    field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
    field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
    field :locked_at,       :type => Time

    has_many :item_containers, :class_name => 'Pbw::ItemContainer'
    has_many :tokens, :class_name => 'Pbw::Token'

    def superadmin?
      self.role == "superadmin"
    end

    def make_superadmin!
        self.role = "superadmin"
        save!
    end

    def admin?
        self.role == "admin"
    end

    def make_admin!
        self.role = "admin"
        save!
    end

    def moderator?
        self.role == "moderator"
    end

    def make_moderator!
        self.role = "moderator"
        save!
    end

    def player?
        self.role == "player"
    end

    def self.viewable_by?(user, subject)
        true
    end

    def self.creatable_by?(user, subject)
        true
    end

    def self.editable_by?(user, subject)
        user.admin? || subject == user
    end

    def self.deletable_by?(user, subject)
        user.admin?
    end
  end
end
