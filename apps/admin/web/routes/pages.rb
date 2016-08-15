class Admin::Application
  route "pages" do |r|
    r.authorize do
      r.on "about" do
        r.is do
          r.get do
            r.view "pages.about.edit"
          end

          r.put do
            r.resolve "pages.about.operations.update" do |update_about_page|
              update_about_page.(r[:page]) do |m|
                m.success do
                  flash[:notice] = t["admin.pages.page_updated"]
                  r.redirect "/admin/posts"
                end

                m.failure do |validation|
                  r.view "pages.about.edit", validation: validation
                end
              end
            end
          end
        end
      end

      r.on "contact" do
        r.is do
          r.get do
            r.view "pages.contact.edit"
          end

          r.put do
            r.resolve "pages.contact.operations.update" do |update_contact_page|
              update_contact_page.(r[:page]) do |m|
                m.success do
                  flash[:notice] = t["admin.pages.page_updated"]
                  r.redirect "/admin/posts"
                end

                m.failure do |validation|
                  r.view "pages.contact.edit", validation: validation
                end
              end
            end
          end
        end
      end

      r.on "home" do
        r.is do
          r.get do
            r.view "pages.home.edit"
          end

          r.put do
            r.resolve "pages.home.operations.update" do |update_home_page|
              update_home_page.(r[:page]) do |m|
                m.success do
                  flash[:notice] = t["admin.pages.page_updated"]
                  r.redirect "/admin/posts"
                end

                m.failure do |validation|
                  r.view "pages.home.edit", validation: validation
                end
              end
            end
          end
        end
      end

      r.on "work" do
        r.is do
          r.get do
            r.view "pages.work.edit"
          end

          r.put do
            r.resolve "pages.work.operations.update" do |update_work_page|
              update_work_page.(r[:page]) do |m|
                m.success do
                  flash[:notice] = t["admin.pages.page_updated"]
                  r.redirect "/admin/posts"
                end

                m.failure do |validation|
                  r.view "pages.work.edit", validation: validation
                end
              end
            end
          end
        end
      end
    end
  end
end
