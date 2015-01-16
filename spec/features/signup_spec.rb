require 'spec_helper'

feature "sign up"  do
  # In order to use Chitter
  # As a maker
  # I want to sign up to the service

    # people can sign up with their: email, password, name, and user name
    # the username and email must be unique
    # passwords are secured with bcrypt

  scenario "a user can sign up" do
    expect{ sign_up('test', 'username', 'test@test.com', '1234', '1234') }.to change(User, :count).by(1)
  end

  scenario "a user cannot sign up with an existing username" do
    sign_up('test', 'username', 'test@test.com', '1234', '1234')
    expect{ sign_up('another_test', 'username', 'another_test@test.com', '4321', '4321') }.not_to change(User, :count)
  end

  def sign_up(name, username, email, password, password_confirmation)
    visit '/'
    click_on 'Sign Up'
    fill_in 'name', :with => name
    fill_in 'username', :with => username
    fill_in 'email', :with => email
    fill_in 'password', :with => password
    fill_in 'password_confirmation', :with => password_confirmation
    click_on 'Submit'
  end


end
