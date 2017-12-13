require 'test_helper'

class AdminTest < ActiveSupport::TestCase
  def setup
    @admin = Admin.new(name: "Example Admin", password: "Ha66y@Nikair", password_confirmation: "Ha66y@Nikair")
  end

  test "should be valid" do
    assert @admin.valid?
  end

  test "name should be present" do
    @admin.name = "   "
    assert_not @admin.valid?
  end

  test "name should not be too long" do
    @admin.name = "a" * 51
    assert_not @admin.valid?
  end

  test "name should not be too small" do
    @admin.name = "a" * 3 
    assert_not @admin.valid?
  end

  test "name should be unique" do
    duplicate_admin = @admin.dup
    @admin.save
    assert_not duplicate_admin.valid?
  end

  test "password should be present" do
    @admin.password = @admin.password_confirmation = " " * 8
    assert_not @admin.valid?
  end

  test "password should not be too short" do
    @admin.password = @admin.password_confirmation = "Hh@1234"
    assert_not @admin.valid?
  end

  test "password should not be too long" do
    @admin.password = @admin.password_confirmation = "Hh@1234567890123"
    assert_not @admin.valid?
  end
  
  test "password should not contain spaces" do
    invalid_passwords = [" Hh@12345678", "Hh@ 12345678"]
    invalid_passwords.each do |invalid|
      @admin.password = @admin.password_confirmation = invalid
      assert_not @admin.valid?
    end
  end

  test "password should contain uppercase letters" do
    @admin.password = @admin.password_confirmation = "abcd123$%^"
    assert_not @admin.valid?
  end

  test "password should contain lowercase letters" do
    @admin.password = @admin.password_confirmation = "ABCDEFG@123"
    assert_not @admin.valid?
  end

  test "password should contain numeric characters" do
    @admin.password = @admin.password_confirmation = "ABcd!@#$%^&*"
    assert_not @admin.valid?
  end

  test "password should contain special characters" do
    @admin.password = @admin.password_confirmation = "ABcdefgh123"
    assert_not @admin.valid?
  end

  test "password should be valid" do
    valid_passwords = ["Hh!@#4%^&*()", "@123Has123", "1/*0nJD&^%?>", "bNVCXR4$LOPI"]
    valid_passwords.each do |valid|
      @admin.password = @admin.password_confirmation = valid
      assert @admin.valid?, "#{valid.inspect} should be valid"      
    end
  end

end