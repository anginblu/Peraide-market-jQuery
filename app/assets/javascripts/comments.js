$(function(){
  attachCommentsListeners();
})

function attachCommentsListeners() {
  $("button.load_reviews").on('click', () => clickLoad());
  $("button.add_review").on('click', () => clickAdd());
}

//1. render at least one index page via jQuery and an Active Model Serialization JSON Backend
// 3. reveal at least one has-many relationship in the JSON
function clickLoad(){
    var commentsLink = $("button.load_reviews").attr("id")
    loadComments(commentsLink)
}

//4. use your Rails API and a form to create a resource and render the response without a page refresh
function clickAdd(){
  var formLink = $("button.add_review").attr("id");
  $.get(`${formLink}`).success(function(data){
      $("div.comments_form").html(data);
      $("form#new_comment").on("submit", function(e){
        var url = $("form#new_comment").attr("action");
        alert("You clicked submit!");
        var data = {
          'authenticity_token': $("input[name='authenticity_token']").attr("value"),
          'comment': {
            'content': $("input#comment_content").val()
          }
        };
        $.ajax({
          type: "POST",
          url: url,
          data: data,
          success: function(response){
            $("div.comments > ol").append(response)
          }
        });
        e.preventDefault();
      });
    }).error(function(){alert("Loading Error!")
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
  var newComment = new Comment(comment.content, comment.created_at);
  $("div.comments > ol").append(newComment.renderCommentString())
}

function noComments(){
  var message = "No review exists for this profile.";
  $("div.comments > ol").append(message);
}

//6. Translate the JSON responses into Javascript Model Objects
function Comment(content, created_at) {
  this.content = content
  this.created_at = created_at
};

Comment.prototype.renderCommentString = function(){
  var date = new Date(this.created_at);
  return `<li>"${this.content}" from ${moment(date).format('ll')}</li>`
};
