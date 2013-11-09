
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
  @survey = Survey.find(params[:survey_id])
  @questions = @survey.questions
  @choices = @questions.first.choices

  erb :survey
end

post '/surveys/:survey_id' do

#store choice_id to database for response

choice = Choice.find(params[:answer])
question = Question.find(choice.question_id)
response = Response.create(choice_id: params[:answer], user_id: session[:user_id], question_id: question.id )
p response
end


get '/surveys/:survey_id/results' do
end

post '/questions/new' do
  if request.xhr?

    myQuestion = Question.new(body: params[:body])
    puts myQuestion
    Survey.find(params[:survey_id]).questions << myQuestion

    myQuestion.choices << Choice.create(option: params[:option1])
    myQuestion.choices << Choice.create(option: params[:option2])
    myQuestion.choices << Choice.create(option: params[:option3])
    myQuestion.choices << Choice.create(option: params[:option4])

    else
    end
end
