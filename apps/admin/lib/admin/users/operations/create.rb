require "admin/import"
require "admin/entities/user"
require "admin/users/validation/form"
require "berg/matcher"
require "types"

module Admin
  module Users
    module Operations
      class Create
        include Admin::Import(
          "persistence.repositories.users",
          "users.access_token",
          "core.authentication.encrypt_password",
        )

        include Berg::Matcher

        def call(attributes)
          validation = Validation::Form.(attributes)

          if validation.success?
            user = Entities::User.new(users.create(prepare_attributes(validation.output)))
            Dry::Monads::Right(user)
          else
            Dry::Monads::Left(validation)
          end
        end

        private

        def prepare_attributes(attributes)
          attributes.merge(
            encrypted_password: nil,
            access_token: access_token.value,
            access_token_expiration: access_token.expires_at
          )
        end
      end
    end
  end
end
