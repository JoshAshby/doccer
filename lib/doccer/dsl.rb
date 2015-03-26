module Doccer
  module DSL

    def doc action_name, &block
      controller = get_controller_from_storage
      controller.ignore = false

      action = Doccer::Storage.find_action controller, action_name

      doc_dsl = Doccer::DSL::DocDSL.new controller, action
      doc_dsl.instance_eval &block
    end

    def param name, options={}, &block
      controller = get_controller_from_storage

      param = Doccer::DSL::ParamDSL.new(controller).param name, options, &block

      controller.shared_parameters.concat param
    end

    def group name, &block
      controller = get_controller_from_storage

      param_dsl = Doccer::DSL::ParamDSL.new(controller)
      param_dsl.instance_eval &block

      controller.parameter_groups[name] = param_dsl.params
    end

    def desc text
      controller = get_controller_from_storage

      controller.description = text
    end

    private
      def get_controller_from_storage
        @controller_name ||= self.name.gsub(/Controller$/, '').underscore
        @controller ||= Doccer::Storage.find_controller @controller_name
      end

  end
end
