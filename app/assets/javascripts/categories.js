$(function(){
  attachCategoriesListeners();
})

function attachCategoriesListeners() {
  $("button.show_profile").on('click', () => clickShow());
  $("button.next_profile").on('click', () => clickNext());
}
function clickShow(){
  var bestprofileLink = $("button.show_profile").attr("id");
  loadProfile(bestprofileLink);
}
function loadProfile(bestprofileLink){
  // $("div#best_profile > p").html("<ol><h5>Best Profile</h5></ol>")
  $.get(`${bestprofileLink}`).success(function(profile){
    var response = profile
    $("div#best_profile > p").append(profile);
  }).error(function(){alert("Loading Error!")});
}
