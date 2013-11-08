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
      user = User.create(username: params[:username]) # make user
      session[:user_id] = user.id # set session equal to user_id
      user.password = params[:password] # creates encrypted password
      user.save
      redirect to "/users/#{user.id}/surveys"
    else
      return "Password does not match. Please try again." # PLACEHOLDER
    end
  end
end


get '/users/:user_id/surveys' do
  @surveys = Survey.where(:user_id => params[:user_id])j
  @user = User.find(params[:user_id])
  erb :profile
end




