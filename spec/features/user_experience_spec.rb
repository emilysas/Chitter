feature "User experience" do
  # In order to let poeple know what I am doing
  # As a maker
  # I want to post a peep to chitter



  feature "User signs in" do

    before(:each) do
      User.create(:name => 'test',
                  :username => 'username',
                  :email => "test@test.com",
                  :password => 'test',
                  :password_confirmation => 'test')
    end

    scenario "with the correct credentials" do
      visit '/'
      expect(page).not_to have_content("Welcome, username")
      sign_in('username', '1234')
      expect(page).to have_content("Welcome, username")
    end

    # scenario "with incorrect credentails" do
    #   visit '/'
    #   expect(page).not_to have_content("Welcome, test@test.com")
    #   sign_in('test@test.com', 'wrong')
    #   expect(page).not_to have_content("Welcome, test@test.com")
    # end

    def sign_in(username, password)
      visit '/sessions/new'
      fill_in 'username', :with => username
      fill_in 'password', :with => password
      click_button 'Sign in'
    end
  end

  # feature "Peeps" do
  #   scenario "User can see peeps without being logged in" do
        # pending
  #   end

  #   scenario "user can post peep" do
  #     pending
  #   end 

  # #   scenario "User cannot send peeps unless logged in" do
  #       pending
  #   end

  # scenario "user can see others' peeps in chronological order" do
  #   pending
  # end

  # scenario "user can reply to a peep from another user" do
  #   pending
  # end
  # end


end