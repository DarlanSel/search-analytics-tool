require 'rails_helper'

RSpec.describe 'Articles search' do
  let!(:article1) { create(:article, title: 'What is a good car?') }
  let!(:article2) { create(:article, title: 'How is Darlan Selzlein doing?') }

  context 'without search' do
    it 'returns http success' do
      visit articles_path
      expect(page).to have_content(article1.title)
                  .and have_content(article2.title)
    end
  end
end
