module Doccer

  module Storage
    @@routes = []

    class << self

      def clear!
        @@routes.map! do |route|
          route.shared_parameters = []
          route.parameter_groups = {}

          route.actions.map! do |action|
            action.parameters = []

            action
          end

          route
        end
      end

      def route route, file
        controller = find_or_create_controller_from_route route, file
        find_or_create_action_from_route route, controller
      end

      def routes
        @@routes.select{ |item| item.ignore == false }
      end

      def find_controller controller_name
        index = @@routes.find_index{ |item| item.name == controller_name }

        if index.blank?
          controller = Doccer::Storage::Controller.new name: controller_name

          @@routes << controller

          controller
        else
          @@routes[index]
        end
      end

      def find_action controller, action_name
        action_name = action_name.to_sym
        index = controller.actions.find_index{ |item| item.controller_method == action_name }

        if index.blank?
          action = Doccer::Storage::Action.new controller_method: action_name.to_sym

          controller.actions << action

          action
        else
          controller.actions[index]
        end
      end

      private
        def find_or_create_controller_from_route route, file
          controller = find_controller route.controller

          controller.deep_merge!({
            file: file
          })

          controller
        end

        def find_or_create_action_from_route route, controller
          action = find_action controller, route.action

          action.verbs.push(route.verb.downcase.to_sym).uniq!
          action.deep_merge!({
            path: route.path,
            name: route.name
          })

          action
        end

    end

  end

end
