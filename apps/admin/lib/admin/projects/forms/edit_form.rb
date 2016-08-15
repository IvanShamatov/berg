require "admin/import"
require "berg/form"

module Admin
  module Projects
    module Forms
      class EditForm < Berg::Form
        include Admin::Import["persistence.repositories.projects"]

        prefix :project

        define do
          group :title do
            text_field :title,
              label: "Title",
              validation: {
                filled: true
              }
            text_field :slug,
              label: "Slug",
              validation: {
                filled: true
              }
          end
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

          group do
            select_box :status, label: "Status", options: dep(:status_list)
            date_time_field :published_at, label: "Published at"
          end

          check_box :case_study, label: "Case Study", question_text: "Mark as a Case Study?"
        end

        def status_list
          Types::ProjectStatus.values.map { |value| [value, value.capitalize] }
        end
      end
    end
  end
end
