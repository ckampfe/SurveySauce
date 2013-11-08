### GET ###

get '/' do
  # Look in app/views/index.erb
  erb :index
end


get '/users/:user_id/surveys' do
end


get '/login' do
end

### POST ###

post '/users/new' do

end


post '/login' do
end