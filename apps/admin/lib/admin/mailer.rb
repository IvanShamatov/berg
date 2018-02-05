require "admin/import"

module Admin
  class Mailer
    include Admin::Import["core.logger", "core.postmark"]

    def deliver(mail)
      logger.debug("[Admin::Mailer] delivering: #{mail.inspect}")
      postmark.deliver(mail.to_h.merge(from: from))
    end

    private

    def from
      Berg::Container.settings.admin_mailer_from_email
    end
  end
end
