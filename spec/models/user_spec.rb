require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Associations" do
    it { is_expected.to have_many(:bookings)}
  end

  describe "Validation" do
    it {is_expected.to validate_presence_of(:name)}
    it {is_expected.to validate_presence_of(:address)}
    it {is_expected.to validate_presence_of(:id_card)}
    it {is_expected.to validate_presence_of(:birthday)}
    it {is_expected.to validate_presence_of(:email)}
    it {is_expected.to allow_value("email@addresse.foo").for(:email)}
    it {is_expected.to_not allow_value("email@addresse").for(:email)}
    it {is_expected.to_not allow_value("email").for(:email)}
    it {is_expected.to have_secure_password(:password)}
    it {is_expected.to validate_confirmation_of(:password)}
  end

  describe "Callbacks check" do
    let(:user)  {FactoryBot.build(:user)}
    it "downcase email before save" do
      expect(user).to receive(:downcase_email)
      user.run_callbacks(:save)
    end
  end
end
