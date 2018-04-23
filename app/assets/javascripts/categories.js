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
  $.get(`${bestprofileLink}`).done(function(profile){
    console.log(profile)
    $("div#profile").append(profile);
  }).error(function(){alert("Loading Error!")});
}
