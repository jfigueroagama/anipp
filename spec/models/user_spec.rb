# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe User do

  before do
  	@user = User.new(name: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar")
  end

  subject { @user }

  it { should respond_to(:name)}  # respond_to? takes a symbol and returns true 
  it { should respond_to(:email)} # if the object respond to a given method or attribure
  it { should respond_to(:password_digest)}
  it { should respond_to(:password)}
  it { should respond_to(:password_confirmation)}
  it { should respond_to(:authenticate)}

  it { should be_valid }

  describe "when name is not present" do
  	before { @user.name = " " }
  	it { should_not be_valid }
  end

  describe "when name is too long" do
  	before { @user.name = "a" * 51 }
  	it { should_not be_valid }
  end

  describe "when email is not present" do
  	before { @user.email = " " }
  	it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "shoul be invalid" do
      addresses = %w(user@foo,com user_at_foo.com example.user@foo. foo@bar_baz.com foo.bar@bar+baz.org)
      addresses.each do |address|
        @user.email = address
        @user.should_not be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "shoul be valid" do
      addresses = %w(user@gmail.COM user_at@anipp.org example.user@foo.jp example@gmail.gov foo.bar@baz.com.mx)
      addresses.each do |address|
        @user.email = address
        @user.should be_valid
      end
    end
  end

  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup   #creates a duplicated user with the same attributes
      user_with_same_email.email = @user.email.upcase # test the eMail case insensitive
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "when password is not present" do
    before { @user.password = @user.password_confirmation = " " }
    it { should_not be_valid }
  end

  describe "when password confirmation does not match" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "when password confirmation is nil" do
    before { @user.password_confirmation = nil }
    it { should_not be_valid }
  end

  describe "when password is too short" do
    before { @user.password = @userpassword_confirmation = "a" * 5 }
    it { should_not be_valid }
  end

  describe "return value of authenticate mathod" do
    before { @user.save } # saves the user to the database so it can be retrieved
    let(:found_user) { User.find_by_email(@user.email) } #retrieves the user using the email

    describe "with valid password" do
      it { should == found_user.authenticate(@user.password) } # user equals found_user
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid_password") }
      it { should_not == user_for_invalid_password }
      specify { user_for_invalid_password.should be_false } # specify is equal to it for brtter reading
    end
  end

end
