require "active_support/subscriber"

module Doccer
  class LoggerSubscriber < ActiveSupport::Subscriber
    attach_to :docs

    def reload event
      Rails.logger.info "Reloaded docs in: #{event.duration}ms"
    end
  end
end
