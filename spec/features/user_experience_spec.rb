feature "User experience" do
  # In order to let poeple know what I am doing
  # As a maker
  # I want to post a peep to chitter
  include UserExperienceMethods

  feature "User signs in" do

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

feature "Peeps" do

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
                :posted_by => 'bob',
                :content => "I've had a great week at Makers",
                :created_at => '12:00')
  end
  
    scenario "User can see peeps without being logged in" do
      visit '/'
      expect(page).not_to have_content("Welcome, spongebob")
      expect(page).to have_content("I've had a great week at Makers")
    end

    scenario "user can post peep" do
      sign_in('spongebob', '1234')
      peep("Chitter is even better than Twitter")
      expect(page).to have_content("Chitter is even better than Twitter")
    end 

    scenario "User cannot send peeps unless logged in" do
      expect(page).not_to have_button("Peep")
    end

    # scenario "user can see others' peeps in chronological order" do
    #   sign_in('spongebob', '1234')
    #   peep("Chitter is even better than Twitter")
    #   sign_in('eatmyshorts', 'simpson')
    #   peep("Chitter is awesome dude!")
    #   sign_in('spongebob', '1234')
    #   peep("It needs some CSS though")
    #   expect(page).to have_content ?????
    # end

  # scenario "user can reply to a peep from another user" do
  #   pending
  # end
  end


end