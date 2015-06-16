//

var show_progress_bar = function(app, action) {
  var li_elem       = ""
  if (app.name)
    li_elem         = "li[data-app-name="+app.name+"]"
  var prog_sel      = ".container"+li_elem+" .mk_progress"
  var progress      = document.querySelector(prog_sel)
  var progress_bar  = document.querySelector(prog_sel+" .progress")
  var progress_text = document.querySelector(prog_sel+" .progress_text")
  progress.classList.remove("hidden")
  progress_bar.style.top = progress.offsetTop
  progress_text.innerHTML = "executing: <span>"+action+"</span> ..."
}
var onAction = function(evt) {
  var data   = evt.target.dataset
  var action = data.actionName
  var app = { name: data.appName }
  show_progress_bar(app, action)
  actionRequest(app, action)
}
var bind_action_buttons = function() {
  var buttons = document.querySelectorAll(".container .btn.action")
  var arr = []
  arr.forEach.call(buttons, function(button){
    button.addEventListener("click", onAction)
  })
}
var bind_create_button = function() {
  var btn = document.querySelector(".btn.create_app")
  if (btn) {
    btn.addEventListener("click", function(){
      var create_field = document.querySelector("input.app[name=name]")
      var app = create_field.value
      if (app) {
        show_progress_bar("cloning "+app)
        createRequest(app)
      }
    })
  }
}


var handle_error = function(resp) {
  var error = resp.error
  if (error) {
    console.log("ERROR:")
    console.log(error.name)
    console.log(error.message+"\n")
    // console.debug(error.backtrace.join("\n"))
  }
}


// main request
var actionRequest = function(app, action){
  var url  = "/apps/"+app.name+"/actions"
  var body = JSON.stringify({ name: action })

  var oReq    = new XMLHttpRequest()
  oReq.onload = function() { // reqListener
    var resp = JSON.parse(this.responseText)
    handle_error(resp)
    // console.log("got response: "+JSON.stringify(resp))
  }
  oReq.open("post", url, true)
  oReq.setRequestHeader("Content-Type", "application/json;charset=UTF-8")
  oReq.send(body)
}

var createRequest = function(app){
  var url  = "/apps"
  var body = JSON.stringify({ name: app })
  var oReq    = new XMLHttpRequest()
  oReq.onload = function() { // reqListener
    var resp = JSON.parse(this.responseText)
    handle_error(resp)
    // console.log("got response: "+JSON.stringify(resp))
  }
  oReq.open("post", url, true)
  oReq.setRequestHeader("Content-Type", "application/json;charset=UTF-8")
  oReq.send(body)
}

var on_sse_received = function(message) {
  // console.log("message: "+JSON.stringify(message)+ "\n")
  var progress      = document.querySelectorAll(".container .mk_progress")
  var arr = []
  arr.forEach.call(progress, function(progress){
    progress.classList.add("hidden")
  })
}

// -------------------------------------

// main

bind_create_button()
bind_action_buttons()

var es = new EventSource('/stream')
es.onmessage = on_sse_received



// jquery

$(document).ready(function () { // addEventListener "DOMContentLoaded"
  $('.button-collapse').sideNav(); // asd
  $('.collapsible').collapsible({
      'accordion': false // A setting that changes the collapsible behavior to expandable instead of the default accordion style
  });
});



// notes

// simple router
//
// var route = /\/apps\/([\w_]+)\/actions/
// if (location.pathname.match(route)) {
//   // match route
// }
