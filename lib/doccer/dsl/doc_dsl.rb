module Doccer
  module DSL

    class DocDSL
      extend Forwardable

      attr_reader :data

      def initialize controller, action
        @controller = controller
        @action = action
      end

      def example &block
        example_dsl = Doccer::DSL::ExampleDSL.new(@controller, @action)
        example_dsl.instance_eval &block

        @action.example = example_dsl.example
      end

      def param name, options={}, &block
        param = Doccer::DSL::ParamDSL.new(@controller).param name, options, &block
        @action.parameters.concat param
      end

      def group name
        g = @controller.parameter_groups[name]
        @action.parameters.concat g
      end

      def_delegator :@action, :description=, :desc
    end

  end
end
