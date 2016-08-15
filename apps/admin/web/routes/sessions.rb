class Admin::Application
  route "sign-in" do |r|
    r.get do
      r.view "sign_in"
    end

    r.post do
      r.resolve "authentication.authenticate" do |authenticate|
        authenticate.(r[:user]) do |m|
          m.success do |user|
            flash[:notice] = t["admin.auth.signed_in"]
            session[:user_id] = user.id
            r.redirect "/admin/posts"
          end

          m.failure do |error|
            flash[:notice] = t["admin.auth.#{error}"]
            r.redirect "/admin/sign-in"
          end
        end
      end
    end
  end

  route "sign-out" do |r|
    flash[:notice] = t["admin.auth.signed_out"]
    session[:user_id] = env["admin.current_user"] = nil
    r.redirect "/admin/sign-in"
  end
end
