$(document).ready(function() {


  $('form').on('submit', function(e){
    e.preventDefault();
    var incomingTweet = $(this).serialize();
    $.ajax({
           url: '/',
           type: 'post',
           data: incomingTweet,
           beforeSend: function(){
                    $('div.response').empty();
                    $('form :input').attr('disabled', true);
                    $('<h2 id="wait">Hang on</h2>').appendTo('div.response');
           },
           success: function(){
                    $('#wait').remove();
                    $('<h2>Success!</h2>').appendTo('div.response');
                    $('form :input').attr("disabled", false);
           },
           error: function(){
                    $('#wait').remove();
                    $('<h2>Problem!</h2>').appendTo('div.response');
                    $('form :input').attr("disabled", false);
           }
    });
  });
});
