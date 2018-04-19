$(function(){
  attachListeners();
})

function attachListeners() {
  $("button.load_reviews").on('click', () => clickLoad());
  $("button.add_review").on('click', () => clickAdd());
  $("#new_comment").on("subimt", () => clickSubmit());
}

function clickLoad(){
    var commentsLink = $("button.load_reviews").attr("id")
    loadComments(commentsLink)
}

function clickAdd(){
    var formLink = $("button.add_review").attr("id");
    $.get(`${formLink}`).success(function(data){
        $("div.comments_form").html(data);
      }).error(function(){alert("Loading Error!")
      e.preventDefault();
  });
}

function clickSubmit(){
  url = this.action;
  data = {
    'authenticity_token': $("input[name='authenticity_token']").attr("value"),
    'comment': {
      'content': $("#commment_content").val()
    }
  };
  $.ajax({
    type: "POST",
    url: url,
    data: data,
    success: function(response){
      $$("div.comments > ol").append(response)
    }
  });
}

function loadComments(commentsLink){
  $("div.comments").html("<ol><h5>Reviews</h5></ol>")
  $.get(`${commentsLink}`).success(function(comments){
    if(comments.length > 0){
      comments.forEach(displayComments);
    }
    else{noComments()}
  }).error(function(){alert("Loading Error!")});
}

function displayComments(comment){
  var date = new Date(comment.created_at);
  var commentList = `<li>"${comment.content}" from ${moment(date).format('MMMM Do YYYY, h:mm:ss a')}</li>`;
  $("div.comments > ol").append(commentList);
}

function noComments(){
  var message = "No review exists for this profile.";
  $("div.comments > ol").append(message);
}
