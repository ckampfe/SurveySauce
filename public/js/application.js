$(document).ready(function() {
  // This is called after the document has loaded in its entirety
  // This guarantees that any elements we bind to will exist on the page
  // when we try to bind to them

  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()

  $(document).on('submit','#new_survey', function(event) {
      event.preventDefault();
      console.log("hahahaha")
      $.post('/surveys/new', {title: document.forms["new_survey"]["title"].value}, function(surid) {
        $('#done_button').attr('data-survey-id', surid);
        $('.survey_space').attr('style','display:none');
        $('.question_space').removeAttr('style');
      });
  });

  $(document).on('submit','#new_question', function(event) {
      event.preventDefault();
      $.post('/questions/new', {body: document.forms["new_question"]["body"].value,
                                option1: document.forms["new_question"]["option1"].value,
                                option2: document.forms["new_question"]["option2"].value,
                                option3: document.forms["new_question"]["option3"].value,
                                option4: document.forms["new_question"]["option4"].value,
                                survey_id: $("#done_button").attr('data-survey-id')
                                });
      $('#new_question')[0].reset();


  });

});
