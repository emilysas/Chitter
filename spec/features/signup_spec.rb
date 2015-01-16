require 'spec_helper'

feature "sign up"  do
  # In order to use Chitter
  # As a maker
  # I want to sign up to the service

    # people can sign up with their: email, password, name, and user name
    # the username and email must be unique
    # passwords are secured with bcrypt

  scenario "a user can sign up" do
    visit '/'
    click_on 'Sign Up'
    expect{ sign_up('test', 'username', 'test@test.com', '1234', '1234') }.to change(User, :count).by(1)
  end

  def sign_up(name, username, email, password, password_confirmation)
    fill_in 'name', :with => name
    fill_in 'username', :with => username
    fill_in 'email', :with => email
    fill_in 'password', :with => password
    fill_in 'password_confirmation', :with => password_confirmation
    click_on 'Submit'
  end


end
