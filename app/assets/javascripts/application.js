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
  var currentIndex = 0;

  $.get("/destinations/indexes.json", function(data) {
    destinationArray = data;
    currentIndex = destinationArray.indexOf(id);
    console.log(currentIndex);
  });

  $(".js-more").on('click', function(e) {
    e.preventDefault();
    var id = $(this).data("id");
    $.get("/destinations/" + id + ".json", function(data) {
     $("#content-" + id).text(data["content"]);
    });
  });

  function loadDestination(id) {
    $.get("/destinations/" + id + ".json", function(data) {
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

    });
  }

  $(".js-next").on("click", function(event) {
    currentIndex += 1;
    event.preventDefault();
    loadDestination(destinationArray[currentIndex]);

    if (currentIndex == destinationArray.length - 1) {
      $(".js-next").attr("disabled", true);
    }
    $(".js-previous").attr("disabled", false);
  });

  $(".js-previous").on("click", function(event) {
    currentIndex -= 1;
    event.preventDefault();
    loadDestination(destinationArray[currentIndex]);

    if (currentIndex === 0) {
      $(".js-previous").attr("disabled", true);
    }
    $(".js-next").attr("disabled", false);
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
