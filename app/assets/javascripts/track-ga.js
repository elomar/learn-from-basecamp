var track = function() {
  ga('create', 'UA-36284081-2', 'auto');
  ga('send', 'pageview');
}

document.addEventListener("turbolinks:load", track);
