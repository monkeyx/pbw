require 'cancan'

class Ability
    include CanCan::Ability

    MANAGED_CLASSES = [Area, Capability, Command, Constraint, Item, ItemContainer, ItemConversion, ItemTransfer, Process, Rule, Token, Trigger, User]
    
    def initialize(user)
        user ||= User.new
        if user.superadmin?
            can :manage, :all
        else
          can do |action, subject_class, subject|
            case action.to_s
            when "index", "show", "search"
              check_method = :viewable_by?
            when "create", "new"
              check_method = :creatable_by?
            when "edit", "update"
              check_method = :editable_by?
            when "delete", "destroy"
              check_method = :deletable_by?
            else 
              check_method = :viewable_by?
            end
            check_class = subject_class.respond_to?(check_method) ? subject_class : parent_of_subject_class(subject_class)
            check_class.send(check_method, user, subject)
          end
        end
    end

    def parent_of_subject_class(subject_class)
        MANAGED_CLASSES.each do |klass|
          return klass if subject_class.ancestors.include?(klass)
        end
    end
end