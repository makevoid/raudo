

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


// main request
var actionRequest = function(app){
  var url  = "/apps/"+app.name+"/actions"
  var body = { name: "restart" }


  var oReq    = new XMLHttpRequest()
  oReq.onload = function() { // reqListener
    var resp = JSON.parse(this.responseText)

    handle_error(resp)

    setTimeout(function() {
      console.log("process ended: app_name: "+app.name)
      progress.classList.add("hidden")
    }, 2000)
  }

  oReq.open("post", url, true)
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


// jquery

$(document).ready(function () { // addEventListener "DOMContentLoaded"
  $('.button-collapse').sideNav(); // asd
  $('.collapsible').collapsible({
      'accordion': false // A setting that changes the collapsible behavior to expandable instead of the default accordion style
  });
});
