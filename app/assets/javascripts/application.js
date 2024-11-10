// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails

import "@hotwired/turbo-rails"

import $ from "jquery"
import "bootstrap"

$(document).on("turbo:load", function (e) {
  // Open collapse section based on anker in URL
  if (window.location.hash) {
    $(window.location.hash).collapse("show");
  }

  // Update anker in URL on collapse section change
  $("#season-list").on("show.bs.collapse", function (e) {
    window.location.hash = e.target.id;
  });
});
