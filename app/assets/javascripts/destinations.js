function Destination(data) {
  this.id = data.id;
  this.title = data.title;
  this.location = data.location;
  this.content = data.content;
  this.recommendation = data.recommendation;
  this.user = data.user;
}

$(function () {
  $(".js-more").on('click', function() {
    var id = $(this).data("id");
    $.get("/destinations/" + id + "destination", function(data) {

      $("#content-" + id).text(data["content"]);
    });
  });
});
