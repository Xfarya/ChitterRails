require "test_helper"

class UserTest < ActiveSupport::TestCase
 def setup
  @user = User.new(name: "Example Chitter User", email: "chitteruser@example.com",
  password: "chitter", password_confirmation: "chitter")
end

 test "should be valid" do
  assert @user.valid?
 end

 test "name should be present" do
  @user.name = " "
  assert_not @user.valid?
 end

 test "email should be present" do
  @user.email = " "
  assert_not @user.valid?
 end

 test "name should not be too long" do
  @user.name = "a" * 51
  assert_not @user.valid?
 end

 test "email should not be too long" do
  @user.email = "a" * 244 + "@example.com"
  assert_not @user.valid?
 end

 test "email validation should accept valid email addresses" do
  valid_addresses = %w[user@example.com USER@example.COM A_US-ER@foo.bar.org first.last@foo.jp alice+pete@foo.com]
  valid_addresses.each do |valid_address|
    @user.email = valid_address
    assert @user.valid?, "#{valid_address.inspect} should be valid"
  end
 end

 test "email validation should not accept invalid email addresses" do
  invalid_addresses = %w[user@example. USER@exa_mple.COM A_US-ER@bar,org first.last@fo+o.jp alice+pete.com]
  invalid_addresses.each do |invalid_address|
    @user.email = invalid_address
    assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
  end
 end

 test "email addresses should be unique" do
  duplicate_user = @user.dup
  @user.save
  assert_not duplicate_user.valid?
 end

 test "password should be present (nonblank)" do
  @user.password = @user.password_confirmation = ""*6
  assert_not @user.valid?
 end

 test "password should have a minimum length" do
  @user.password = @user.password_confirmation = "a" * 5
  assert_not @user.valid?
 end

end
