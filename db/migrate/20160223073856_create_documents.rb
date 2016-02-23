class CreateDocuments < ActiveRecord::Migration[5.0]
  def up
    create_table :documents do |t|
      t.string :title
      t.text :content
      t.string :author
      t.string :source
      t.string :url
      t.date :published_on

      t.timestamps
    end

    execute "create index document_full_text_search on documents using
      gin(to_tsvector('english', coalesce(title, ' ') || coalesce(content, ' ') || coalesce(author, ' ') || coalesce(source, ' ')))"
  end

  def down
    drop_table :documents
    drop_index :documents, :document_full_text_search
  end
end
