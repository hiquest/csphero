class Website < ApplicationRecord
  belongs_to :company
  has_many :reports, dependent: :destroy, inverse_of: :website

  validates :domain, presence: true
  validate :valid_domain_format
  validates :domain, uniqueness: { scope: :company_id }
  validates :token, presence: true, uniqueness: true

  before_validation :generate_token

  def go_json
    {
      id: id,
      domain: domain,
      token: token,
      last24h_reports_count: last24h_reports_count,
    }
  end

  def last24h_reports_count
    since = AggregatedReport.range_to_date('24h')
    reports.where("created_at > ?", since).count
  end

  private

  def valid_domain_format
    return if domain.blank?

    unless domain =~ /\A[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,63}\z/i
      errors.add(:domain, 'is not valid')
    end
  end

  def generate_token
    # random 8 digit alphanumeric string
    self.token = SecureRandom.alphanumeric(8)
  end

end
