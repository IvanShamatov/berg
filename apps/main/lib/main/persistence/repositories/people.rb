require "umbrella/repository"
require "main/entities/person"

module Main
  module Persistence
    module Repositories
      class People < Umbrella::Repository[:people]
        relations :people

        def for_about_page
          people
            .for_about_page
            .as(Entities::Person)
        end
      end
    end
  end
end
