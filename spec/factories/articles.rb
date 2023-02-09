FactoryBot.define do
  factory :article do
    sequence(:title) { |n| "Article number #{n}" }
  end
end
