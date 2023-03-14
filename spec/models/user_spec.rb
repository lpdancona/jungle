require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    subject(:user) { described_class.new(
      first_name: 'John',
      last_name: 'Doe',
      email: 'test@test.com',
      password: 'password',
      password_confirmation: 'password'
    ) }

    it 'is valid with valid attributes' do
      expect(user).to be_valid
    end

    it 'is not valid without a first name' do
      user.first_name = nil
      expect(user).not_to be_valid
    end

    it 'is not valid without a last name' do
      user.last_name = nil
      expect(user).not_to be_valid
    end

    it 'is not valid without an email' do
      user.email = nil
      expect(user).not_to be_valid
    end

    it 'is not valid with a duplicate email address (case-insensitive)' do
      described_class.create!(
        first_name: 'Jane',
        last_name: 'Doe',
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password'
      )

      expect(user).not_to be_valid
    end

    it 'is not valid without a password' do
      user.password = nil
      expect(user).not_to be_valid
    end

    it 'is not valid without a password confirmation' do
      user.password_confirmation = nil
      expect(user).not_to be_valid
    end

    it 'is not valid when password and password_confirmation do not match' do
      user.password_confirmation = 'invalid'
      expect(user).not_to be_valid
    end
    it 'requires a password to have a minimum length' do
      user = User.new(password: 'abc', password_confirmation: 'abc', email: 'test@example.com', first_name: 'John', last_name: 'Doe')
      expect(user).to_not be_valid
      expect(user.errors[:password]).to include('is too short (minimum is 6 characters)')

      user = User.new(password: 'abcdef', password_confirmation: 'abcdef', email: 'test@example.com', first_name: 'John', last_name: 'Doe')
      expect(user).to be_valid
    end
  end
  describe '.authenticate_with_credentials' do
    before(:each) do
      @user = User.create(
        first_name: 'John',
        last_name: 'Doe',
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password'
      )
    end

    context 'with valid credentials' do
      it 'returns an instance of the user' do
        user = User.authenticate_with_credentials('test@test.com', 'password')
        expect(user).to eq(@user)
      end
    end

    context 'with invalid email' do
      it 'returns nil' do
        user = User.authenticate_with_credentials('invalid@test.com', 'password')
        expect(user).to be_nil
      end
    end

    context 'with invalid password' do
      it 'returns nil' do
        user = User.authenticate_with_credentials('test@test.com', 'invalid')
        expect(user).to be_nil
      end
    end

    context 'with email containing leading/trailing spaces' do
      it 'returns an instance of the user' do
        user = User.authenticate_with_credentials('   test@test.com   ', 'password')
        expect(user).to eq(@user)
      end
    end

    context 'with email in different case' do
      it 'returns an instance of the user' do
        user = User.authenticate_with_credentials('TeSt@tEsT.cOm', 'password')
        expect(user).to eq(@user)
      end
    end
    context 'with email containing leading/trailing spaces' do
      it 'returns an instance of the user' do
        user = User.authenticate_with_credentials('   test@test.com   ', 'password')
        expect(user).to eq(@user)
      end
    end
    
    context 'with email in different case' do
      it 'returns an instance of the user' do
        user = User.authenticate_with_credentials('TeSt@tEsT.cOm', 'password')
        expect(user).to eq(@user)
      end
    end
  end
end
