class Admin::Application
  route "users" do |r|
    r.authorize do
      r.is do
        r.get do
          r.view "users.index", page: r[:page] || 1
        end

        r.post do
          r.resolve "transactions.create_user" do |create_user|
            create_user.(r[:user]) do |m|
              m.success do
                flash[:notice] = t["admin.users.user_created"]
                r.redirect "/admin/users"
              end

              m.failure do |validation|
                r.view "users.new", validation: validation
              end
            end
          end
        end
      end

      r.get "new" do
        r.view "users.new"
      end

      r.on ":id" do |id|
        r.get "edit" do
          r.view "users.edit", id: id
        end

        r.is do
          r.resolve "users.operations.update" do |update_user|
            update_user.(id, r[:user]) do |m|
              m.success do
                flash[:notice] = t["admin.users.user_updated"]
                r.redirect "/admin/users/#{id}/edit"
              end

              m.failure do |validation|
                r.view "users.edit", id: id, user_validation: validation
              end
            end
          end
        end

        r.on "password" do
          r.get do
            r.view "users.password", id: id
          end
          r.put do
            r.resolve "users.operations.change_password" do |change_password|
              change_password.(id, r[:user]) do |m|
                m.success do
                  flash[:notice] = t["admin.users.password_changed"]
                  r.redirect "/admin/users/#{id}/password"
                end

                m.failure do |validation|
                  r.view "users.password", id: id, pass_validation: validation
                end
              end
            end
          end
        end
      end
    end
  end
end
