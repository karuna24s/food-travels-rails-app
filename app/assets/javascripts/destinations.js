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
    // e.preventDefault();
    var id = $(this).data("id");
    $.get("/destinations/" + id + "/destinations", function(data) {

      $("#content-" + id).text(data["content"]);
    });
  });
});
