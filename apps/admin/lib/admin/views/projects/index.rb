require "admin/import"
require "admin/paginator"
require "admin/view"

module Admin
  module Views
    module Projects
      class Index < Admin::View
        include Admin::Import("persistence.repositories.projects")

        configure do |config|
          config.template = "projects/index"
        end

        def locals(options = {})
          page      = options[:page] || 1
          per_page  = options[:per_page] || 20

          all_projects = projects.listing(page: page, per_page: per_page)
          admin_projects = Decorators::Project.decorate(all_projects)

          super.merge(
            projects: admin_projects,
            paginator: Paginator.new(all_projects.pager, url_template: "/admin/projects?page=%")
          )
        end
      end
    end
  end
end
