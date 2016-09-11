require "umbrella/repository"
require "admin/entities/user"

module Admin
  module Persistence
    module Repositories
      class Users < Umbrella::Repository[:users]
        commands :create, update: [:by_id, :by_email]

        alias_method :update, :update_by_id

        def [](id)
          users.by_id(id).as(Entities::User).one!
        end

        def by_email!(email)
          users.by_email(email).as(Entities::User).one!
        end

        def by_email_for_authentication(email)
          users.active.by_email(email).as(Entities::User).one
        end

        def by_access_token(token)
          users
            .by_access_token(token) { access_token_expiration > Time.now }
            .as(Entities::User).one
        end

        def listing
          users.as(Entities::User).to_a
        end
      end
    end
  end
end
