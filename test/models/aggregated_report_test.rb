require "test_helper"

class AggregatedReportTest < ActiveSupport::TestCase

  EMAIL = "test@example.com"
  PWRD = "password"

  setup do
    @user = User.new(email: EMAIL, password: PWRD)
    @user.skip_confirmation!
    @user.save!
  end

  test "loads agg reports for a website" do
    c = @user.companies.first
    ws = c.websites.create!(domain: "example.com")
    data = AggregatedReport.all(ws, "1d")
    assert_equal 0, data.length
  end

end
