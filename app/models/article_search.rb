class ArticleSearch < ApplicationRecord
  validates :username, :query, presence: true

  class << self
    def previous_query_for_user(username)
      where(username:).last
    end
  end
end
