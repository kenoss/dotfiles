var topLeft = slate.operation("corner", {
  "direction" : "top-left",
  "width"  : "screenSizeX",
  "height" : "screenSizeY"
});
  
var topRight = slate.operation("corner", {
  "direction" : "top-right",
  "width"  : "screenSizeX/2",
  "height" : "screenSizeY/2"
});
  
var bottomRight = slate.operation("corner", {
  "direction" : "bottom-right",
  "width"  : "screenSizeX/2",
  "height" : "screenSizeY/2"
});
  
var bottomLeft = slate.operation("corner", {
  "direction" : "bottom-left",
  "width"  : "screenSizeX/2",
  "height" : "screenSizeY/2"
});


// slate.bind("f:fn", function(win){
//   var appName = win.app().name();    
//   var tiled = {};
//   tiled[appName] = {
//     "operations" : [topLeft, topRight, bottomRight, bottomLeft],
//     "main-first" : true,
//     "repeat"     : true
//   };
//   var tiledLayout = slate.layout("tiledLayout", tiled);
//   slate.operation("layout", {"name" : tiledLayout }).run();
//   slate.operation("show", {"app" : appName}).run();
// });


slate.bind("f:alt", function(win){
  var appName = win.app().name();    
  var tiled = {};
  tiled[appName] = {
    "operations" : [topLeft, topRight, bottomRight, bottomLeft],
    "main-first" : true,
    "repeat"     : true
  };
  var tiledLayout = slate.layout("tiledLayout", tiled);
  slate.operation("layout", {"name" : tiledLayout }).run();
  slate.operation("show", {"app" : appName}).run();
});

