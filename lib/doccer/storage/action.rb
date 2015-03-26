module Doccer
  module Storage

    class Action < Hashie::Dash
      property :name
      property :verbs, default: []
      property :path
      property :example, default: nil
      property :controller_method, required: true
      property :description, default: ""
      property :parameters, default: []
    end

  end
end
