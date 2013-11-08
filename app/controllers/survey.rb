
get '/surveys/all' do
  @surveys = Survey.all
  erb :survey_all
end

get '/surveys/new' do

  if session[:user_id]
    erb :survey_new
  else
    redirect to('/')
  end

end

post '/surveys/new' do

  if request.xhr?
    @survey = Survey.create(user_id: session[:user_id], title: params[:title])
    @survey.id.to_json
  else
  end
end

get '/surveys/:survey_id' do

  if session[:user_id]
    @suvery = Survey.find(params[:survey_id])
    erb :survey
  else
    redirect to('/')
  end

end

post '/surveys/:survey_id' do
end


get '/surveys/:survey_id/results' do
end