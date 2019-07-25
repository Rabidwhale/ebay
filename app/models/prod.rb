class Prod < ApplicationRecord
  validates :name, :description, :cost, presence: true
end
