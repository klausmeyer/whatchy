$(document).ready(function() {
  // Open collapse section based on anker in URL
  if (window.location.hash) {
    $(window.location.hash).collapse("show");
  }

  // Update anker in URL on collapse section change
  $("#season-list").on("show.bs.collapse", function(e) {
    window.location.hash = e.target.id;
  });
});
