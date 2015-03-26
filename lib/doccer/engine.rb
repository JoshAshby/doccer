module Doccer
  class Engine < ::Rails::Engine
    isolate_namespace Doccer

    initializer :haml do
      Haml::Template.options[:ugly] = true
    end

    config.paths.add 'lib', autoload_once: true
  end
end
