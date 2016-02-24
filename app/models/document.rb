require 'elasticsearch/model'

class Document < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  validates :url, uniqueness: true
end
