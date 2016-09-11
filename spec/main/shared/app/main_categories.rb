RSpec.shared_context "main categories" do
  def create_category(name, slug)
    Umbrella::Container["persistence.commands.create_category"].({
      name: name,
      slug: slug
    })
  end

  def categorise_post(category_id, post_id)
    Umbrella::Container["persistence.commands.create_categorisations"].({
      post_id: post_id,
      category_id: category_id
    })
  end
end
