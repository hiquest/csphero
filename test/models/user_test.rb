require "test_helper"

class UserTest < ActiveSupport::TestCase

  EMAIL = "test@example.com"
  PWRD = "password"

  setup do
    @user = User.new(email: EMAIL, password: PWRD)
    @user.skip_confirmation!
    @user.save!
  end

  test "creates a default company for a new user" do
    @user.reload

    assert @user.companies.count == 1
    company = @user.companies.first

    assert company.name == "DEFAULT"
    assert company.users.count == 1

    ms = company.memberships.first
    assert ms.role == "owner"
    assert ms.user == @user
  end
end
