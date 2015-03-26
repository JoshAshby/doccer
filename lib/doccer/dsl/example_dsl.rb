module Doccer
  module DSL

    class ExampleDSL
      extend Forwardable

      attr_accessor :example

      def initialize controller, action
        @controller = controller
        @action = action

        @example = Doccer::Storage::Example.new
      end

      def status symb
        code = Rack::Utils::SYMBOL_TO_STATUS_CODE[symb]
        text = Rack::Utils::HTTP_STATUS_CODES[code]
        @example.status = "#{ text } #{ code }"
      end

      def_delegator :@example, :language=, :language

      def response text
        @example.response = text.chomp
      end

      def header key, value
        @example.headers += [key, value].join(": ")+"\n"
      end

    end

  end
end
