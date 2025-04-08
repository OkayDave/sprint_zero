require 'rails_helper'

RSpec.describe "Authentication", type: :feature do
  let!(:user) { create(:user) }
  let!(:admin) { create(:user, :admin) }

  describe "Sign up" do
    it "allows a user to sign up" do
      visit new_user_registration_path

      fill_in "Email", with: "newuser@example.com"
      fill_in "Password", with: "password123"
      fill_in "Password confirmation", with: "password123"

      click_button "Sign up"

      expect(page).to have_content("A message with a confirmation link has been sent to your email address")
    end

    it "shows validation errors for invalid sign up" do
      visit new_user_registration_path

      fill_in "Email", with: "invalid-email"
      fill_in "Password", with: "short"
      fill_in "Password confirmation", with: "different"

      click_button "Sign up"

      expect(page).to have_content("Email is invalid")
      expect(page).to have_content("Password is too short")
      expect(page).to have_content("Password confirmation doesn't match")
    end
  end

  describe "Sign in" do
    it "allows a user to sign in" do
      visit new_user_session_path

      fill_in "Email", with: user.email
      fill_in "Password", with: "password123"

      click_button "Sign in"

      expect(page).to have_content("Signed in successfully")
    end

    it "shows error for invalid credentials" do
      visit new_user_session_path

      fill_in "Email", with: user.email
      fill_in "Password", with: "wrongpassword"

      click_button "Sign in"

      expect(page).to have_content("Invalid Email or password")
    end
  end

  describe "Sign out" do
    it "allows a user to sign out" do
      sign_in user
      visit root_path

      click_button "Sign Out"

      expect(page).to have_content("Signed out successfully")
    end
  end

  describe "Password reset" do
    it "allows a user to request password reset" do
      visit new_user_password_path

      fill_in "Email", with: user.email
      click_button "Send me reset password instructions"

      expect(page).to have_content("You will receive an email with instructions")
    end

    it "allows a user to reset their password" do
      token = user.send_reset_password_instructions
      visit edit_user_password_path(reset_password_token: token)

      fill_in "New password", with: "newpassword123"
      fill_in "Confirm new password", with: "newpassword123"
      click_button "Change my password"

      expect(page).to have_content("Your password has been changed successfully")
    end
  end

  describe "Email confirmation" do
    it "allows a user to confirm their email" do
      user = create(:user, confirmed_at: nil)
      token = user.confirmation_token
      visit user_confirmation_path(confirmation_token: token)

      expect(page).to have_content("Your email address has been successfully confirmed")
    end

    it "allows a user to request confirmation email" do
      user = create(:user, confirmed_at: nil)
      visit new_user_confirmation_path

      fill_in "Email", with: user.email
      click_button "Resend confirmation instructions"

      expect(page).to have_content("You will receive an email with instructions")
    end
  end

  describe "Account edit" do
    it "allows a user to update their email" do
      # debugger
      sign_in create(:user), scope: :user
      visit edit_user_registration_path

      fill_in "Email", with: "newemail@example.com"
      fill_in "Current password", with: "password123"
      click_button "Update"

      expect(page).to have_content("You updated your account successfully, but we need to verify your new email address")
    end

    it "allows a user to update their password" do
      sign_in user
      visit edit_user_registration_path

      fill_in "Password", with: "newpassword123"
      fill_in "Password confirmation", with: "newpassword123"
      fill_in "Current password", with: "password123"
      click_button "Update"

      expect(page).to have_content("Your account has been updated successfully")
    end

    it "allows a user to cancel their account" do
      sign_in user
      visit edit_user_registration_path

      click_button "Cancel my account"

      expect(page).to have_content("Bye! Your account has been successfully cancelled")
    end
  end
end
