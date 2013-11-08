$(document).ready(function() {
  // This is called after the document has loaded in its entirety
  // This guarantees that any elements we bind to will exist on the page
  // when we try to bind to them

  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()

  $(document).on('submit','#new_survey', function(event) {
      event.preventDefault();
      $.post('/surveys/new', {title: document.forms["new_survey"]["title"].value}, function(surid) {
        var survey_id = surid;
      });


  });

});
