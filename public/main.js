// jquery suxed js by pippo

$(document).ready(function () {
  $('.button-collapse').sideNav();
  $('.collapsible').collapsible({
      'accordion': false // A setting that changes the collapsible behavior to expandable instead of the default accordion style
  });
});


// good js by mad :p

var progress      = document.querySelector(".container .mk_progress")
var progress_bar  = document.querySelector(".container .mk_progress .progress")
var progress_text = document.querySelector(".container .mk_progress .progress_text")
var onAction = function(evt) {
  var action = evt.target.dataset.actionName
  progress.classList.remove("hidden")
  progress_bar.style.top = progress.offsetTop
  progress_text.innerHTML = "executing: <span>"+action+"</span> ..."

  var app = { name: "mkdeploy" };
  actionRequest(app)
}
var buttons = document.querySelectorAll(".container .btn.action")
var arr = []
arr.forEach.call(buttons, function(button){
  button.addEventListener("click", onAction)
})


// xhr
var actionRequest = function(app){
  console.log("app: "+app)
  var oReq = new XMLHttpRequest()
  oReq.onload = reqListener
  var body = { name: "restart" }
  oReq.open("post", "/apps/"+app.id+"/actions", true)
  oReq.send(body);
}

function reqListener () {
  console.log("got: "+this.responseText)
  setTimeout(function() {
    console.log("ended: "+this.responseText)
    progress.classList.add("hidden")
  }, 2000)
}

// router
var route = /\/apps\/([\w_]+)\/actions/
if (location.pathname.match(route)) {
  var match = route.exec(location.pathname)[1]
  var action = document.querySelector(".btn[data-action-name='"+match+"']")


  var elements = document.querySelectorAll(".hidden")
  var arr = []
  arr.forEach.call(elements, function(elem){
    elem.classList.remove("hidden")
    elem.dispatchEvent("click")

    var evt = document.createEvent("MouseEvents");
    evt.initMouseEvent("click", true, true, window, 1, 0, 0, 0, 0,
        false, false, false, false, 0, null);
    elem.dispatchEvent(evt);
  })

  // action.trigger("click")
}
