class Prod < ApplicationRecord
  validates :name, :description, :cost, presence: true

  belongs_to :user
  has_many :comments
end
