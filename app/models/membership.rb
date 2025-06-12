class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :company

  validates :user_id, presence: true
  validates :company_id, presence: true
  validates :role, inclusion: { in: %w(regular admin owner) }, presence: true
end
