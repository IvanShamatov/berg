require "admin/import"
require "authentication/authenticate"

module Admin
  module Authentication
    class Authenticate < ::Authentication::Authenticate
      include Admin::Import[
        "core.authentication.encrypt_password",
        "persistence.repositories.users",
      ]

      def fetch(email)
        users.by_email_for_authentication(email)
      end
    end
  end
end
