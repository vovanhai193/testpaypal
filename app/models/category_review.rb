class CategoryReview < ApplicationRecord
  has_many :reviews, dependent: :destroy
end
