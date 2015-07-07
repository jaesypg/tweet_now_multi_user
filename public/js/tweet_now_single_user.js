$(document).ready(function() {
  $("#form1").submit(function(event) {
    event.preventDefault(); //prevent form submission
    $("#button").attr('disabled', 'disabled');
    // $("#button").prop('disabled', 'disabled');  //jQuery earlier than v1.6
    $("#loader").show();

    $.ajax({
      type: "post",
      url: "/",
      data: $("#form1").serialize(),
      success: function(response) {
        // alert("all good");
        $(".tweets").html(response);
      },
      error: function(){
        alert("error");
      },
      complete: function(){   //function called when request finishes, after success and error callbacks are executed
        $("#button").attr('disabled', false);
        $("#loader").hide();
      }
    }); //end of ajax


  }); //end of form submit

}); //end of document ready



