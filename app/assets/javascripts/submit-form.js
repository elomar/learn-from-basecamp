var formViaTurbolinks = function(event) {
  var search = document.getElementById("search_query");
  search.parentElement.addEventListener("submit", function(e) {
    e.preventDefault();

    Turbolinks.visit("/?search[query]=" + search.value);
  });
};

window.onload = formViaTurbolinks;
document.addEventListener("turbolinks:load", formViaTurbolinks);
