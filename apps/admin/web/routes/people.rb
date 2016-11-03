class Admin::Application
  route "people" do |r|
    r.authorize do
      r.is do
        r.get do
          r.view "people.index", page: r[:page]
        end

        r.post do
          r.resolve "people.operations.create" do |create_person|
            create_person.(r[:person]) do |m|
              m.success do
                flash[:notice] = t["admin.people.person_created"]
                r.redirect "/admin/people"
              end

              m.failure do |validation|
                r.view "people.new", validation: validation
              end
            end
          end
        end
      end

      r.get "new" do
        r.view "people.new"
      end

      r.on ":slug" do |slug|
        r.get "edit" do
          r.view "people.edit", slug: slug
        end

        r.put do
          r.resolve "people.operations.update" do |update_person|
            update_person.(id, r[:person]) do |m|
              m.success do
                flash[:notice] = t["admin.people.person_updated"]
                r.redirect "/admin/people"
              end

              m.failure do |validation|
                r.view "people.edit", id: id, validation: validation
              end
            end
          end
        end
      end
    end
  end
end
