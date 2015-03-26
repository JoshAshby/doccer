# Doccer
Doccer is a small, lightweight API documention tool for plain old Ruby On Rails controllers.

The actual documentation happens through a basic DSL that can be added to controllers:

```ruby
# app/controllers/application_controller.rb

require "doccer/dsl"

class ApplicationController < ActionController::Base
  extend Doccer::DSL
end

# app/controllers/index_controller.rb

class IndexController < ApplicationController
  # Controller level description
  desc "Couple of basic endpoints for things"

  # Group and Param are available directly on the controller like this for making shared parameters.
  group :signin do
    param :username, type: :string, required: true
    param :password, type: :password, required: true
  end

  param :profile, type: :string, required: true, description: "Basic user profile information"

  doc :index do
    example do
      status :ok
    end
  end
  def index
    # [...]
  end

  doc :create do
    desc "Create a user"

    param :user do
      group :signin
    end

    example do
      status :created

      language :json
      response <<-RES
        {
          "what": "created"
        }
      RES
    end
  end
  def update
    # [...]
  end

  doc :update do
    desc "Updates a user"

    param :user do
      group :signin # Includes username and password params automatically

      param :profile # Includes the profile param that was 

      param :email, type: :string, required: true
      param :password_confirmation, type: :password, description: "Should be the same as above", required: true
    end

    example do
      status :accepted

      language :json
      response <<-RES
        {
          "what": "updated"
        }
      RES
    end
  end
  def update
    # [...]
  end
end
```

# Engine
Doccer provides an engine that has the frontend for the docs:
```ruby
# config/routes.rb
Rails.application.routes.draw do
  mount Doccer::Engine => '/docs'
end

```

# Configuration
Only one parameter to configure right now: `introduction` which takes a markdown string and renders it at the top of the docs template.
```ruby
# config/initializers/doccer.rb

Doccer.configure do |config|
  config.introduction = "markdown string"

  # OR for something like dynamic reloading of the introduction:
  def config.introduction
    @introduction = File.read("docs_introduction.md")
  end
end
```

# Thanks/Contributors
 - @jmyrose for giving awesome critique on the frontend layout
 - @robacarp for being a rubber duck who also gives awesome code reviews
 - Skeleton for the css framework, normalize.css and colors.css too.
