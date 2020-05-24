class Budget < ApplicationRecord
  belongs_to :user
  has_many :adjustments, dependent: :destroy

  validates :name, presence: true
end
