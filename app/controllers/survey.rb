
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

  if(Complete.exists?(user_id: session[:user_id], survey_id: params[:survey_id]))
    erb :already_taken
  else
    @survey = Survey.find(params[:survey_id])
    @questions = @survey.questions
    @choices = @questions.first.choices

    erb :survey
  end
end

post '/surveys/:survey_id' do
  @survey = Survey.find(params[:survey_id]) # For use in _next_question partial.
  choice = Choice.find(params[:answer])
  question = Question.find(choice.question_id)

  Response.create(user_id: session[:user_id], choice_id: params[:answer], question_id: question.id )
    
  if @survey.questions.last == question
    Complete.create(user_id: session[:user_id], survey_id: @survey.id)
    return "Finished_Qs"
  else
    @next_question = @survey.questions.find(question.id + 1) # For use in _next_question partial.
    @next_choices = @next_question.choices
    erb :_next_question, layout: false
  end
end

get '/surveys/:survey_id/finished' do
  @survey = Survey.find(params[:survey_id]) # For use in partial.
  erb :_finished, layout: false
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
