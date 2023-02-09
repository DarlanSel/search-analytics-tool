class CreateArticleSearches < ActiveRecord::Migration[7.0]
  def change
    create_table :article_searches do |t|
      t.string :username, null: false
      t.string :query, null: false

      t.timestamps
    end
  end
end
