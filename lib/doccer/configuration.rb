module Doccer
  module Configuration

    attr_accessor :introduction
    def introduction
      @introduction ||= ""
    end

    def configure
      yield self
    end

  end
end
