$(document).ready(function() {

  var username = $(".tweet").data("username");
  alert(username);
  // fires off an AJAX request which refreshes the cache
  $.ajax({
    type: "post",
    url: "/tweets/" + username + "/refresh"
  });

});

