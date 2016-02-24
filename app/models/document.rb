class Document < ApplicationRecord
  validates :url, uniqueness: true

  def self.search(search_params)
    where("to_tsvector('english', coalesce(title, ' ') || coalesce(content, ' ') || coalesce(author, ' ')) @@ to_tsquery('english', ?)", search_params[:query])
  end
end
