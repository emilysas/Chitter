feature "User signs in" do
  # In order to let poeple know what I am doing
  # As a maker
  # I want to post a peep to chitter
  include UserExperienceMethods

  before(:each) do
    User.create(:name => 'test',
                :username => 'username',
                :email => "test@test.com",
                :password => '1234',
                :password_confirmation => '1234')
  end

  scenario "with the correct credentials" do
    visit '/'
    expect(page).not_to have_content("Welcome, username")
    sign_in('username', '1234')
    expect(page).to have_content("Welcome, username")
  end

  scenario "with incorrect credentails" do
    visit '/'
    expect(page).not_to have_content("Welcome, username")
    sign_in('username', 'wrong')
    expect(page).not_to have_content("Welcome, test@test.com")
  end

end