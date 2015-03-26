module Doccer
  module Storage

    class Controller < Hashie::Dash
      property :name, required: true, default: ""
      property :file, default: :string
      property :description, default: ""
      property :ignore, default: true
      property :actions, default: []
      property :parameter_groups, default: {}
      property :shared_parameters, default: []
    end

  end
end
