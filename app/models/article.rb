class Article < ApplicationRecord
  validates :title, presence: true

  scope :by_title, ->(query) { where(arel_table[:title].matches("%#{query}%")) }
end
