module Doccer
  module DSL

    class ParamDSL
      attr_accessor :params

      def initialize controller
        @controller = controller
        @params = []
      end

      def param name, options={}, &block
        if options.empty? && ! block_given?
          index = @controller.shared_parameters.find_index{ |item| item.name == name }

          @params << @controller.shared_parameters[index]
        else

          if block_given?
            this = self.class.new(@controller)
            this.instance_eval &block

            @params << { name => this.params }
          else
            options[:name] = name
            param = Doccer::Storage::Param.new(options)

            @params << param
          end

        end

        def group name
          g = @controller.parameter_groups[name]
          @params.concat g
        end

          @params
        end

    end

  end
end
