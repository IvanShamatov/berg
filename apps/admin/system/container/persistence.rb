require "admin/persistence/uniqueness_check"
require "admin/persistence/post_color_picker"

Admin::Container.namespace "persistence" do |container|
  container.register "user_email_uniqueness_check" do
    Admin::Persistence::UniquenessCheck.new(
      container["core.persistence.rom"].relation(:users),
      :email,
    )
  end

  container.register "person_email_uniqueness_check" do
    Admin::Persistence::UniquenessCheck.new(
      container["core.persistence.rom"].relation(:people),
      :email,
    )
  end

  container.register "person_slug_uniqueness_check" do
    Admin::Persistence::UniquenessCheck.new(
      container["core.persistence.rom"].relation(:people),
      :slug,
    )
  end

  container.register "post_slug_uniqueness_check" do
    Admin::Persistence::UniquenessCheck.new(
      container["core.persistence.rom"].relation(:posts),
      :slug,
    )
  end

  container.register "category_slug_uniqueness_check" do
    Admin::Persistence::UniquenessCheck.new(
      container["core.persistence.rom"].relation(:categories),
      :slug,
    )
  end

  container.register "post_color_picker" do
    Admin::Persistence::PostColorPicker.new(
      Types::PostHighlightColor,
      container["persistence.repositories.posts"].method(:recent_colors),
    )
  end

  container.register "project_color_picker" do
    Admin::Persistence::PostColorPicker.new(
      Types::PostHighlightColor,
      container["persistence.repositories.projects"].method(:recent_colors),
    )
  end

  container.register "project_slug_uniqueness_check" do
    Admin::Persistence::UniquenessCheck.new(
      container["core.persistence.rom"].relation(:projects),
      :slug,
    )
  end
end
