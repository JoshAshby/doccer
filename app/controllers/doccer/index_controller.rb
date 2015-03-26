require_dependency "doccer/application_controller"

module Doccer
  class IndexController < ApplicationController

    def index
      Doccer::Scraper.go!
      @routes = Doccer::Storage.routes

      @introduction = Doccer.introduction
    end

  end
end
