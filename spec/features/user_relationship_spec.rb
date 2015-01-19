feature "forming relationships" do
  # In order to use chitter
  # As a maker
  # I want to follow other users

  include UserExperienceMethods

  before(:each) do
    User.create(:name => 'bob',
                :username => 'spongebob',
                :email => "bob@test.com",
                :password => '1234',
                :password_confirmation => '1234')

    User.create(:name => 'bart',
                :username => 'eatmyshorts',
                :email => "bart@test.com",
                :password => 'simpson',
                :password_confirmation => 'simpson')

    Peep.create(:user_id => User.first.id,
                :posted_by => 'bart',
                :content => "Please follow me!")
  end

  scenario "user can search for other users" do
    visit '/'
    click_on("Search for Chitterers")
    fill_in 'search_username', :with => 'eatmyshorts'
    click_button('Search')
    expect(page).to have_content('Please follow me!')
  end

  # scenario "user can follow other users" do
  #   sign_in('spongebob', '1234')
  #   fill_in 'search_username', :with => 'eatmyshorts'
  #   click_button('Search for Chitterers')
  #   click_button("Follow")
  #   expect(User.all(:username => 'eatmyshorts').first.followers.size).to eq(1)
  # end

end