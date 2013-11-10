### GET ###

get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/login' do
  erb :login
end

post '/login' do
  user = User.find_by_username(params[:username]) #identify user
  if !user.nil?
    user.authenticate(params[:password]) #authenticate password by checking database
    session[:user_id] = user.id
    redirect to "/users/#{user.id}/surveys"
  else
    return "You need to create an account." # PLACEHOLDER
  end
end

# create new user
post '/users/new' do
  if User.find_by_username(params[:username]) #if username is in the database, pick another
    return "Username taken!"
  else
    if params[:password] == params[:confirmed_password]
      user = User.new(username: params[:username], ) # make user
      user.password = params[:password] # creates encrypted password
      user.save
      session[:user_id] = user.id # set session equal to user_id
      redirect to "/users/#{session[:user_id]}/surveys"
    else
      return "Password does not match. Please try again." # PLACEHOLDER
    end
  end
end


get '/users/:user_id/surveys' do
  if session[:user_id] != nil
    @surveys_created = Survey.where(:user_id => params[:user_id])
    
    @user = User.find(params[:user_id])
    surveys_completed = Complete.where(:user_id => params[:user_id])
    @completed_survey_titles = []
    
    surveys_completed.each do |complete|
      @completed_survey_titles << Survey.find(complete.survey_id).title
    end

  p @completed_survey_titles



    erb :profile
  else
    redirect to '/'
  end
end

get '/logout' do
  session[:user_id] = nil
  erb :index
end
