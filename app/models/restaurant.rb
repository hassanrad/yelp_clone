class Restaurant < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  # -> { extending WithUserAssociationExtension },

  belongs_to :user, required: true

  validates :name, length: {minimum: 3}, uniqueness: true

end
