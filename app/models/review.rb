class Review < ActiveRecord::Base
  validates :rating, inclusion:(1..5)
  validates :user, uniqueness: { scope: :restaurant, message: "has reviewed this restaurant already" }

  belongs_to :user, required: true
  belongs_to :restaurant, required: true

  # def build_review(attributes = {}, user)
  #   review = reviews.build(attributes)
  #   review.user = user
  #   review
  # end

end
