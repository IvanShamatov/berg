ROM::SQL.migration do
  up do
    add_column :work_page_featured_items, :teaser, String
  end

  down do
    drop_column :work_page_featured_items, :teaser
  end
end
