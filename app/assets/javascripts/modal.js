function modalToggle() {
  $(".modal-toggle-js").on("click", function() {
    load_modal_data();
    $(".modal-inner").show();
    $(".modal-fade-screen").css({opacity: 0.5});
    $(".modal-fade-screen").css({visibility: "visible"});
  });

  $("#step2_trigger").on("click", function() {
    $("#modal-step-1").addClass("hidden-content");
    $("#modal-step-2").removeClass("hidden-content");
  })

  $(".close-icon").on("click", function() {
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

function load_modal_data() {
  $.ajax({
    type: "GET",
    url: '/static_pages/modal',
    success: function(data) {console.log("OK");},
    error: function(results) {console.log("Error: " + results.responseText);}
  });
};
