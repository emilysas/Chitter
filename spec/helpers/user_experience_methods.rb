module UserExperienceMethods
  
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

  def sign_in(username, password)
    visit '/sessions/new'
    fill_in 'username', :with => username
    fill_in 'password', :with => password
    click_button 'Login'
  end

end
