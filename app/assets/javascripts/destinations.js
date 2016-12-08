console.log('hello')
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
    var id = $(this).data("id");
    $.get("/destinations/" + id + "/destinations", function(data) {

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
  var html = "";
  html += "" + this.user.name + ": <br>" + this.content + "<br>";
  $("").append(html);
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
      var comment = new Comment(json);
      comment.renderDisplay();

    })
  })
})
