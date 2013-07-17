module Pbw
  class Changeset
    def initialize(changes=nil)
        @changes = changes || {}
    end

    def add_change(model,field,value)
        fields = @changes[model] || {}
        fields[field] = value
        @changes[model] = value
        self
    end

    def models_changed
        @changes.keys
    end

    def changes_for_model(model)
        @changes[model]
    end
  end
end
