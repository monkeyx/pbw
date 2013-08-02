module Pbw
  class User < Container
    ROLES = %W{superadmin admin moderator player}
    
    devise :database_authenticatable, :registerable, :timeoutable, 
           :recoverable, :rememberable, :trackable, :lockable

    ## Database authenticatable
    field :email,              type: String, default: ""
    field :encrypted_password, type: String, default: ""
    
    ## Recoverable
    field :reset_password_token,   type: String
    field :reset_password_sent_at, type: Time

    ## Rememberable
    field :remember_created_at, type: Time

    ## Trackable
    field :sign_in_count,      type: Integer, default: 0
    field :current_sign_in_at, type: Time
    field :last_sign_in_at,    type: Time
    field :current_sign_in_ip, type: String
    field :last_sign_in_ip,    type: String

    field :name,   type: String
    
    field :role, type: String, default: 'player'

    ## Lockable
    field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
    field :unlock_token,    type: String # Only if unlock strategy is :email or :both
    field :locked_at,       type: Time

    validates :name, presence: true
    validates :password, confirmation: true, length: {minimum: 8}
    validates :email, uniqueness: {case_sensitive: false}, format: {with: /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/}
    
    attr_accessible :email, :name, :password, :password_confirmation

    def superadmin?
      self.role == "superadmin"
    end

    def make_superadmin!
        self.role = "superadmin"
        save!
    end

    def admin?
        self.role == "admin" || superadmin?
    end

    def make_admin!
        self.role = "admin"
        save!
    end

    def moderator?
        self.role == "moderator" || admin?
    end

    def make_moderator!
        self.role = "moderator"
        save!
    end

    def player?
        self.role == "player" || moderator?
    end

    def send_registration_email
        UserMailer.registration(self).deliver
    end

    def reset_password!
        token = User.friendly_token
        self.password = token
        self.password_confirmation = token
        save!
        send_password_email(token)
    end

    def send_password_email(password)
        UserMailer.password_reset(self,password).deliver
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

    def self.friendly_token
      SecureRandom.base64(15).tr('+/=lIO0', 'pqrsxyz')
    end
  end
end
