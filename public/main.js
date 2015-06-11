//
var progress      = document.querySelector(".container .mk_progress")
var progress_bar  = document.querySelector(".container .mk_progress .progress")
var progress_text = document.querySelector(".container .mk_progress .progress_text")
var onAction = function(evt) {
  var action = evt.target.dataset.actionName
  progress.classList.remove("hidden")
  progress_bar.style.top = progress.offsetTop
  progress_text.innerHTML = "executing: <span>"+action+"</span> ..."


  var app = { name: "mkdeploy" };
  actionRequest(app, action)
}
var buttons = document.querySelectorAll(".container .btn.action")
var arr = []
arr.forEach.call(buttons, function(button){
  button.addEventListener("click", onAction)
})




// xhr


// error handling
var handle_error = function(resp) {
  var error = resp.error
  if (error) {
    console.log("ERROR:")
    console.log(error.name)
    console.log(error.message+"\n")
    console.log("")
    // console.debug(error.backtrace.join("\n"))
    // console.log("")
  }
}

var nextEvents = []

// main request
var actionRequest = function(app, action){
  var url  = "/apps/"+app.name+"/actions"
  var body = JSON.stringify({ name: action })

  var oReq    = new XMLHttpRequest()
  oReq.onload = function() { // reqListener
    var resp = JSON.parse(this.responseText)

    handle_error(resp)

    nextEvents.push(
      { action: resp }
    )
  }

  oReq.open("post", url, true)
  oReq.setRequestHeader("Content-Type", "application/json;charset=UTF-8")
  oReq.send(body)
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

// SSE
var es = new EventSource('/stream');
es.onmessage = function(message) {
  console.log("message: "+JSON.stringify(message)+ "\n")

  var progress = document.querySelector(".mk_progress")
  progress.classList.add("hidden")
};




// jquery

$(document).ready(function () { // addEventListener "DOMContentLoaded"
  $('.button-collapse').sideNav(); // asd
  $('.collapsible').collapsible({
      'accordion': false // A setting that changes the collapsible behavior to expandable instead of the default accordion style
  });
});
