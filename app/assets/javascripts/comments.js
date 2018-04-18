$(function(){
  $("button.load_reviews").on("click", function(e){
    // alert("Loading reviews!");
    var commentsLink = $("button.load_reviews").attr("id")
    loadComments(commentsLink)
    e.preventDefault();
  })
})

function loadComments(commentsLink){
  $("div.comments").empty();
  $.get(`${commentsLink}`).success(function(comments){
    comments.forEach(displayComments);
  }).error(function(){alert("Loading Error!")});
}

function displayComments(comment){
  var commentList = `<li>"${comment.content}" from ${simplifyDate(comment.created_at)}</li><br>`;
  $("div.comments").append(commentList);
}

function simplifyDate(date) {
  return date.slice(0, 10)
}
