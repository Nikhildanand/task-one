require 'test_helper'

class EmployeeTest < ActiveSupport::TestCase

  def setup
    @employee = Employee.new(name: "Nikhil D Anand", gender: "Male", designation: "Full Stack Developer", phone: 8592817590, email: "nikhildanand@gmail.com", date_of_join: Date.parse('2017-11-23'), address: "Sajith Nivas Karumalloor P.O, Thattampady, Aluva, Ernakulam", active: "False", username: "nikhildanand@gmail.com", personal_email: "nikhildanand@hotmail.com", date_of_birth: Date.parse('1994/03/17'), password: "Ha66y@Air", password_confirmation: "Ha66y@Air")
  end

  test "Employee should be valid" do
    assert @employee.valid?
  end

  test "name should be present" do
    @employee.name = "     "
    assert_not @employee.valid?
  end

  test "name should not be empty" do
    @employee.name = ""
    assert_not @employee.valid?
  end

  test "designation should be present" do
    @employee.designation = "   "
    assert_not @employee.valid?
  end

  test "designation should not be empty" do
    @employee.designation = ""
    assert_not @employee.valid?
  end

  test "email should not be empty" do
    @employee.email = @employee.username = ""
    assert_not @employee.valid?
  end

  test "email should be present" do
    @employee.email = @employee.username = "   "
    assert_not @employee.valid?
  end

    test "email addresses should be unique" do
    duplicate_user = @employee.dup
    duplicate_user.email = @employee.email.upcase
    @employee.save
    assert_not duplicate_user.valid?
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @employee.email = mixed_case_email
    @employee.save
    assert_equal mixed_case_email.downcase, @employee.reload.email
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @employee.email = valid_address
      assert @employee.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar..com foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @employee.email = invalid_address
      assert_not @employee.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "date should be valid" do
    @employee.date_of_join = '1887-87-67'
    assert_not @employee.valid? 
  end

  test "address should be present" do
    @employee.address = "    "
    assert_not @employee.valid?
  end

  test "address should not be empty" do
    @employee.address = ""
    assert_not @employee.valid?
  end


  test "address should not be too short" do
    @employee.address = "a" * 20
    assert_not @employee.valid?
  end

  test "address should not be too long" do
    @employee.address = "a" * 256
    assert_not @employee.valid?
  end

  test "password should be present" do
    @employee.password = @employee.password_confirmation = " " * 8
    assert_not @employee.valid?
  end

  test "password should not be too short" do
    @employee.password = @employee.password_confirmation = "Hh@1234"
    assert_not @employee.valid?
  end

  test "password should not be too long" do
    @employee.password = @employee.password_confirmation = "Hh@1234567890123"
    assert_not @employee.valid?
  end
  
  test "password should not contain spaces" do
    invalid_passwords = [" Hh@12345678", "Hh@ 12345678"]
    invalid_passwords.each do |invalid|
      @employee.password = @employee.password_confirmation = invalid
      assert_not @employee.valid?
    end
  end

  test "password should contain uppercase letters" do
    @employee.password = @employee.password_confirmation = "abcd123$%^"
    assert_not @employee.valid?
  end

  test "password should contain lowercase letters" do
    @employee.password = @employee.password_confirmation = "ABCDEFG@123"
    assert_not @employee.valid?
  end

  test "password should contain numeric characters" do
    @employee.password = @employee.password_confirmation = "ABcd!@#$%^&*"
    assert_not @employee.valid?
  end

  test "password should contain special characters" do
    @employee.password = @employee.password_confirmation = "ABcdefgh123"
    assert_not @employee.valid?
  end

  test "password should be valid" do
    valid_passwords = ["Hh!@#4%^&*()", "@123Has123", "1/*0nJD&^%?>", "bNVCXR4$LOPI"]
    valid_passwords.each do |valid|
      @employee.password = @employee.password_confirmation = valid
      assert @employee.valid?, "#{valid.inspect} should be valid"      
    end
  end

end
