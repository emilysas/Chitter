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
    expect{ sign_up('test', 'username', 'test@test.com', '1234', '1234') }.to change(User, :count).by(1)
    expect{ sign_up('another_test', 'username', 'another_test@test.com', '4321', '4321') }.to change(User, :count).by(0)
    expect(page).to have_content("This username is already taken")
  end

  scenario "user cannot sign up with an email that is already registered" do
    expect{ sign_up('test', 'username', 'test@test.com', '1234', '1234') }.to change(User, :count).by(1)
    expect{ sign_up('another_test', 'another_username', 'test@test.com', '4321', '4321') }.to change(User, :count).by(0)
    expect(page).to have_content("This email is already taken")
  end

  scenario "user cannot sign up unless password and password confirmation match" do
    expect { sign_up('test', 'username', 'test@test.com', '1234', '123') }.to change(User, :count).by(0)
    # expect(current_path).to eq('/users/new')
    expect(page).to have_content("Sorry, there were the following problems with the form")
  end


  def sign_up(name, username, email, password, password_confirmation)
    visit '/'
    click_on 'Sign Up'
    fill_in :name, :with => name
    fill_in :username, :with => username
    fill_in :email, :with => email
    fill_in :password, :with => password
    fill_in :password_confirmation, :with => password_confirmation
    click_on 'Submit'
  end


end
