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

    var formLink = $("button.add_review").attr("id");
    $.get(`${formLink}`).success(function(data){
        $("div.comments_form").html(data);
      }).error(function(){alert("Loading Error!")
    });
    $("#new_comment").on("subimt", newComment(e));

    // var source = $("#comment-template").text;
    // var template = Handlebars.compile(source);
    // $("div.comments_form").html(template);

    e.preventDefault();

  });
}

function newComment(e){
  url = this.action
  data = {
    'authenticity_token': $("input[name='authenticity_token']").value(),
    'comment': {
      'content': $("#commment_content").value()
    }
    // debugger
  }
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
