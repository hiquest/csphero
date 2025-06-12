class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :trackable

  has_many :memberships, dependent: :destroy
  has_many :companies, through: :memberships

  has_many :websites, through: :companies

  # create default company
  after_create :create_default_company

  def create_default_company
    company = Company.create!(name: "DEFAULT")
    Membership.create!(company: company, user: self, role: "owner")
  end

  def go_json
    {
      companies: companies.map do |c|
        {
          id: c.id,
          name: c.name,
          websites: c.websites.map(&:go_json)
        }
      end
    }
  end
end
