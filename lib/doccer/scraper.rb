module Doccer

  class Scraper
    class << self
      def go!
        ActiveSupport::Notifications.instrument 'reload.docs' do
          reload!

          Rails.application.routes.routes.collect do |route|
            route = ActionDispatch::Routing::RouteWrapper.new route
          end.reject(&:internal?).reject(&:engine?).each do |route|
            scrape_route! route
          end
        end

        nil
      end

      def reload!
        files = []
        Doccer::Storage.routes.each do |v|
          files << v.file unless v.file.blank?
        end

        Doccer::Storage.clear!

        files.each do |file|
          load file
        end
      end

      def scrape_route! route
        controller = "#{route.controller}_controller".camelcase.constantize

        file = controller.instance_methods(false).map do |m|
          controller.instance_method(m).source_location.first
        end.uniq.first

        Doccer::Storage.route route, file
      rescue NameError => e
        Rails.logger.error "\033[1;33m!!! Doccer can't do a thing !!!\033[0m"
        Rails.logger.error " #{e.message} \n #{e.backtrace.join("\n ")}"
      end
    end
  end

end
