require "admin/import"
require "berg/form"

module Admin
  module Projects
    module Forms
      class CreateForm < Berg::Form
        include Admin::Import["persistence.repositories.projects"]

        prefix :project

        define do
          text_field :title,
            label: "Title",
            validation: {
              filled: true
            }
          group :metadata do
            text_field :client,
              label: "Client",
              validation: {
                filled: true
              }
            text_field :url,
              label: "URL"
          end
          text_area :intro,
            label: "Introduction",
            validation: {
              filled: true
            }
          text_area :summary,
            label: "Summary",
            validation: {
              filled: true
            }
          text_area :body,
            label: "Body",
            validation: {
              filled: true
            }

          upload_field :cover_image,
            label: "Cover Image",
            presign_url: "/admin/uploads/presign"

          multi_upload_field :assets,
            label: "Additional Images",
            hint: "Images to display inline",
            presign_url: "/admin/uploads/presign"

          check_box :case_study, label: "Case Study", question_text: "Mark as a Case Study?"
        end
      end
    end
  end
end
