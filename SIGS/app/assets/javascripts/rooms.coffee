# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

`
$(document).ready(function () {
  $("input:radio").on('click', function() {
    var roomStatus = $(this).attr("value");

    $('tr').show()
    if (roomStatus === "active") {
      $('tr#inactive').hide()
    } else if (roomStatus === "inactive") {
      $('tr#active').hide()
    }
  });

  $('select#wing').on('change', function() {
    var selected = $(this).val();
    $('select#building_id').find('option').removeClass('hide');
    $('select#building_id').find('option').not('option[data-wing="' + selected + '"]').addClass('hide');
  });
})
`