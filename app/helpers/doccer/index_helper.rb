require 'redcarpet'

module Doccer
  module IndexHelper

    def param_table params
      return unless params

      @p = []

      params.map do |param|
        if param.values.first.kind_of? Array
          _nested_param({name: param.keys.first.to_s}, param.values.first)
        else
          @p << { required: param.required, name: param.name.to_s, type: param.type.to_s, description: param.description }
        end
      end

      haml_tag :table do
        haml_tag :thead do
          haml_tag :tr do
            haml_tag :th, "Required"
            haml_tag :th, "Name"
            haml_tag :th, "Type"
            haml_tag :th, "Description"
          end
        end

        haml_tag :tbody do
          @p.each do |param|
            haml_tag :tr do
              haml_tag :td do
                haml_concat param[:required]
              end

              haml_tag :td do
                haml_tag :code, param[:name]
              end

              haml_tag :td do
                haml_tag :code, param[:type]
              end

              haml_tag :td do
                haml_concat param[:description]
              end
            end
          end
        end
      end
    end

    def _nested_param base, params
      params.map do |param|
        if param.values.first.kind_of? Array
          base[:name] += "[#{param.keys.first.to_s}]"

          _nested_param base, param.values.first
        else
          d = base.dup
          d[:required] = param.required
          d[:name] += "[#{param.name.to_s}]"
          d[:type] = param.type.to_s
          d[:description] = param.description

          @p << d
        end
      end
    end

    def markdown text
      Redcarpet::Markdown.new(
        Redcarpet::Render::HTML,
        autolink: true,
        tables: true,
        fenced_code_blocks: true,
        no_intra_emphasis: true,
        strikethrough: true,
        underline: true,
      ).render(text).html_safe
    end

  end
end
