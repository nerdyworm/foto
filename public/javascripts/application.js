$(document).ready(function() {

  var last_page = 0;

  $(window).scroll(function() {
    if ($(window).scrollTop() == $(document).height() - $(window).height()) {

      var count = $(".pictures .picture").size();

      var page = Math.floor(count / 6);

      if(page > last_page) {
        last_page = page;
        $.get("/pictures.js?page=" + page ); 
      }

    }
  });
});
