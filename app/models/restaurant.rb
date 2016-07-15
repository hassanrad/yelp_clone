class Restaurant < ActiveRecord::Base
  has_many :reviews,
    -> { extending WithUserAssociationExtension },
    dependent: :destroy

  belongs_to :user, required: true

  validates :name, length: {minimum: 3}, uniqueness: true

end
