### GET ###

get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/login' do

  erb :login
end

post '/login' do
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
    else
      return "Password does not match. Please try again."
    end
  end
end


get '/users/:user_id/surveys' do

erb :profile
end




