function modalToggle() {
  $(".modal-toggle-js").on("click", function() {
    load_modal_data($(this));
    $(".modal-inner").empty();
    $(".modal-inner").show();
    $(".modal-fade-screen").css({opacity: 0.5});
    $(".modal-fade-screen").css({visibility: "visible"});
  });

  $('body').on("click", "#step2_trigger", function() {
    $("#modal-step-1").addClass("hidden-content");
    $("#modal-step-2").removeClass("hidden-content");
  })

  $('body').on("click", ".close-icon", function() {
    $(".modal-inner").hide();
    $(".modal-fade-screen").css({opacity: 0})
    $(".modal-fade-screen").css({visibility: "hidden"})
    $("#modal-step-1").removeClass("hidden-content");
    $("#modal-step-2").addClass("hidden-content");
  });

  $(".modal-inner").on("click", function(e) {
    e.stopPropagation();
  });
}

function load_modal_data($element) {
  var counter_id = $element.data('counter-id');
  var neighborhood = $('#neighborhoods').val().toLowerCase();

  $.ajax({
    type: "GET",
    url: '/static_pages/modal?counter_id=' + counter_id + '&neigborhood=' + neighborhood + '.js',
    success: function(data) {console.log("OK");},
    error: function(results) {console.log("Error: " + results.responseText);}
  });
};
