// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, ut if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap
//= require jquery_ujs

//= require_tree .

$(function () {
  var destinationArray = [];
  var id = parseInt($(".js-next").attr("data-id"));

  if ($("#destinationsInfo").length) {
    loadAllDestinations();
  }

  function loadAllDestinations() {
    $.ajax({
      url: "/destinations.json",
      method: 'GET'
    })
    // promise
    .then(function(data) {
       destinationArray = data;
       $.each(
         destinationArray, function(index, destination) {
           var destinationData = "<p><a href='/destinations/" + destination.id + "'>"
            + destination.title + "</a><div id='content-" + destination.id + "'>"
            + destination.content.substring(0, 250) + "..."
            + "<a href='#' data-id='" + destination.id + "' class='js-more'>Read More</a></div><br>";
           $('#destinationsInfo').append(destinationData);
         }
       )
     });
  }


// For the destinations index page

  $("#destinationsInfo").on('click', '.js-more', function(e) {
    e.preventDefault();
    var id = this.dataset.id;
    $.get("/destinations/" + id + ".json", function(data) {
      $("#content-" + id).html(data.content)
    });
  });

// For the Users Destinations Page

  $("#userDestinationsInfo").on('click', '.js-more', function(e) {
    e.preventDefault();
    var id = this.dataset.id;
    $.get("/destinations/" + id + ".json", function(data) {
     $("#content-" + id).html(data.content);

    });
  });

// For the Users Show Page

  $("#userDestinationsShowInfo").on('click', '.js-more', function(e) {
    e.preventDefault();
    var id = this.dataset.id;
    $.get("/destinations/" + id + ".json", function(data) {
     $("#content-" + id).html(data.content);

    });
  });

// For the Destinations Show page

  function loadDestination(data) {
      history.pushState({}, "", "/destinations/" + data.id)
      var destinationCommentPath = '/destinations/' + data.id + '/comments/';
      $("#new_comment").attr('action', destinationCommentPath);
      $(".destinationTitle").text(data["title"]);
      $(".destinationUserName").text(data["user"]["name"]);
      $(".destinationLocation").text(data["location"]);
      $(".destinationFoodName").text(data["food"]["name"]);
      $(".destinationFoodCategory").text(data["food"]["category"]);
      $(".destinationContent").text(data["content"]);
      $(".destinationRecommendation").text(data["recommendation"]);
      $(".js-next").attr("data-id", data["id"]);
      $(".js-previous").attr("data-id",data["id"]);
      $("#submitted-comments").empty();
      data["comment_list"].forEach(function(element){
        var comment = new Comment(element);
        comment.renderDisplay();
      });


  }

  $(".js-next").on("click", function(event) {
    var id = $(".js-next").attr("data-id")
    $.get("/destinations/" + id + "/next", function(data) {
      console.log(data)
      loadDestination(data);
    });
    event.preventDefault();
  });

  $(".js-previous").on("click", function(event) {
    var id = $(".js-previous").attr("data-id")
    $.get("/destinations/" + id + "/previous", function(data) {
      console.log(data)
      loadDestination(data);
    });
    event.preventDefault();

  });

});



function Comment(data) {
  this.id = data.id;
  this.content = data.content;
  this.user = data.user;
}



Comment.prototype.renderDisplay = function() {
  var html = "" ;
  html += "<div class=\'well well-white\' id=\'comment-\' + comment.id + '\'>" +  "<strong>" + this.user.name + "</strong>" + " says: " + this.content + "</div>";
  $("#submitted-comments").append(html);
}

$(function() {
  $("form#new_comment").on("submit", function(event) {
    event.preventDefault();
    var $form = $(this);
    var action = $form.attr("action");
    // in order to process the comment(form data), its need to be converted from an object to a string.
    var params = $form.serialize();
    $.ajax({
      url: action,
      data: params,
      dataType: "json",
      method: "POST"
    })
    .success(function(json) {
      $(".commentBox").val("");
      var comment = new Comment(json);
      comment.renderDisplay();

    })
  })
})
