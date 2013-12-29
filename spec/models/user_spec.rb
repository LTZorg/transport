require 'spec_helper'

describe User do
  
	before { @user = User.new(name: "User", email: "user@example.com", password: "foobar", password_confirmation: "foobar") }

	subject { @user }

	it { should respond_to(:name) }
	it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }


	it { should be_valid }

	describe "когда имени нет" do

		before { @user.name = " " }
		it { should be_invalid }

	end	

	describe "когда почты нет" do

		before { @user.email = " " }
		it { should be_invalid }

	end

	describe "когда имя очень длинное" do
		before { @user.name = "a"*51 }
		it { should be_invalid }
	end

	describe "когда формат почты невалиден" do
      it "должен быть невалиден" do
        addresses = %w[user@foo,com user_at_foo.org foo@bar..com]
            addresses.each do |invalid_addresses|
              @user.email = invalid_addresses
              expect(@user).not_to be_valid
            end
      end
  end

  describe "когда формат почты валиден" do
      it "должен быть валиден" do
        addresses = %w[user@foo.com user_at_foo@mail.org]
        addresses.each do |valid_addresses|
          @user.email = valid_addresses
          expect(@user).to be_valid
        end
      end
  end

  describe "когда такая почта уже есть" do
        before do
          user_with_same_email = @user.dup
          user_with_same_email.email = @user.email.upcase
          user_with_same_email.save
        end

        it { should be_invalid }
  end

  describe "когда пароль пустой" do
      before { @user = User.new(name: "User", email: "user@example.com", password: " ", password_confirmation: " ") }
      it { should be_invalid }
  end

  describe "когда пароль не соответствует подтвержденному" do
    before { @user.password_confirmation = "mismatch" }
    it { should be_invalid }
  end

  describe "короткий пароль" do
    before { @user.password = @user.password_confirmation = "a"*5 }
    it { should be_invalid}
  end

  describe "возвращение значения метода ауинтификации" do
    before { @user.save }
    let(:found_user) { User.find_by(email: @user.email) }

    describe "с валидным паролем" do
      it { should eq found_user.authenticate(@user.password) }
    end

    describe "с невалидным паролем" do
      let(:user_for_invalid_password) { found_user.authenticate("newkar") }

      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_false }
    end
  end

  describe "почта с разным регистром" do
    let(:mixed_case_email) { "sdjhJJhjshdJ@JJid.coM" }

    it "должна быть сохранена в нижнем регистре" do
      @user.email = mixed_case_email
      @user.save
      expect(@user.reload.email).to eq mixed_case_email.downcase
    end
  end
end
