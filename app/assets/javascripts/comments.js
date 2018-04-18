$(function(){
  attachListeners()
})

function attachListeners() {
  $("button.load_reviews").on('click', function(e) {
    var commentsLink = $("button.load_reviews").attr("id")
    loadComments(commentsLink)
    e.preventDefault();
  });
  $("button.add_review").on('click', function(e) {
    var formLink = $("button.add_review").attr("id")
    $.get(`${formLink}`).success(function(data){
      // var $button = $(this);
      // $button.before(data);
      $("div.comments_form").html(data);
    }).error(function(){alert("Loading Error!")});
    e.preventDefault();
  });

  $('#sort').on('click', () => sortComments());

}

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
