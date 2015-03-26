module Doccer
  module Storage

    class Param < Hashie::Dash
      property :name, required: true
      property :location, default: :parameters
      property :type, default: :string
      property :required, default: false
      property :description
    end

  end
end
