feature "sign up"  do
  # In order to use Chitter
  # As a maker
  # I want to sign up to the service

    # people can sign up with their: email, password, name, and user name
    # the username and email must be unique
    # passwords are secured with bcrypt

  scenario "a user can sign up" do
    visit '/'
    click_on 'Sign In'
    fill_in 'name', :with => 'test'
    fill_in 'username', :with => 'username'
    fill_in 'email', :with => 'test@test.com'
    fill_in 'password', :with => '1234'
    fill_in 'password_confirmation', :with => '1234'
    click_on 'Submit'
    expect(User.first(:email => 'test@test.com').name).to eq('test')
  end

end
