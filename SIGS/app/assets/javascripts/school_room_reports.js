$(document).ready(function () {
  $(".reports_allocation, .reports_no_all").hide();

  $(".all_reports_school_room").click(function () {
    $(".reports_allocation").hide();
    $(".reports_no_all").hide();
    $(".reports_all").show();
  });

  $(".allocations_reports_school_room").click(function () {
    $(".reports_allocation").show();
    $(".reports_all").hide();
    $(".reports_no_all").hide();
  });

  $(".no_all_reports_school_room").click(function () {
    $(".reports_all").hide();
    $(".reports_no_all").show();
    $(".reports_allocation").hide();
  });
});