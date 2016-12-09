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



function Destination(data) {
  this.id = data.id;
  this.title = data.title;
  this.location = data.location;
  this.content = data.content;
  this.recommendation = data.recommendation;
  this.user = data.user;
}

$(function () {
  $(".js-more").on('click', function(e) {
    console.log('hello')
    e.preventDefault();
    // debugger;
    var id = $(this).data("id");
    $.get("/destinations/" + id + ".json", function(data) {
      console.log(data)
     $("#content-" + id).text(data["content"]);
    });
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
  // html += "" + this.user.name + ": <br>" + this.content + "<br>";
  // <div class="well well-white" id="comment-57">
  //   <strong>Dom</strong> says: Thank you for writing this post. I am happy to know that there are vegetarian options available in Sicily aside from having pizza .
  // </div>
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
    $('#new_comment').hide();
      console.log(json)
      // $('input[type="submit"]').prop("disabled", false);
      // $.rails.enableElement($('a[data-disable-with]'));
      var comment = new Comment(json);
      comment.renderDisplay();

    })
  })
})
