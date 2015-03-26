module Doccer
  module Storage
    class Example < Hashie::Dash
      property :status, default: "OK 200"
      property :headers, default: ""
      property :language, default: :json
      property :response, default: ""
    end
  end
end
