class Admin::Application
  route "posts" do |r|
    r.authorize do
      r.is do
        r.get do
          r.view "posts.index", page: r[:page]
        end

        r.post do
          r.resolve "posts.operations.create" do |create_post|
            create_post.(r[:post]) do |m|
              m.success do
                flash[:notice] = t["admin.posts.post_created"]
                r.redirect "/admin/posts"
              end

              m.failure do |validation|
                r.view "posts.new", validation: validation
              end
            end
          end
        end
      end

      r.get "new" do
        r.view "posts.new"
      end

      r.on ":slug" do |slug|
        r.get "edit" do
          r.view "posts.edit", slug: slug
        end

        r.on "share" do
          r.post "medium" do
            r.resolve "posts.operations.share.medium" do |share|
              share.(slug) do |m|
                m.success do
                  flash[:notice] = t["admin.posts.post_shared"]
                  r.redirect "/admin/posts"
                end

                m.failure do
                  flash[:notice] = t["admin.posts.post_share_failed"]
                  r.redirect "/admin/posts"
                end
              end
            end
          end
        end

        r.put do
          r.resolve "posts.operations.update" do |update_post|
            update_post.(slug, r[:post]) do |m|
              m.success do
                flash[:notice] = t["admin.posts.post_updated"]
                r.redirect "/admin/posts"
              end

              m.failure do |validation|
                r.view "posts.edit", slug: slug, validation: validation
              end
            end
          end
        end
      end
    end
  end
end
