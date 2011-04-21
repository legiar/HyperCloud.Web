$(document).ready(function () {
  // Message box fading
  $(".close-yellow").click(function() {
    $("#message-yellow").fadeOut("slow");
  });
  $(".close-red").click(function() {
    $("#message-red").fadeOut("slow");
  });
  $(".close-blue").click(function() {
    $("#message-blue").fadeOut("slow");
  });
  $(".close-green").click(function() {
    $("#message-green").fadeOut("slow");
  });

  // Table row background color changes on rollover
  $('#product-table tr').hover(
    function() {
      $(this).addClass('activity-blue');
    },
    function() {
      $(this).removeClass('activity-blue');
    }
  );
});

