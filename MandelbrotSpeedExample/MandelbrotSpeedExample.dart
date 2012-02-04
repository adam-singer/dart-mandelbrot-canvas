#import('dart:html');
#source('Palette.dart');
#source('MandelbrotSlow.dart');
#source('MandelbrotFast.dart');

class MandelbrotSpeedExample {

  MandelbrotSpeedExample() {
  }

  void run() {
    ButtonElement paintit = document.query('#paintit');
    Palette palette = new Palette();
    var zoom = 1.0;
    var canvas = document.query('#canvas');
    var context = canvas.getContext('2d');
    
    paintit.on.click.add((var event) { 
      paintit.disabled=true;
      SelectElement selected = document.query('#mandeltype');
      var i = selected.selectedIndex;
      if (i==0) {
        /*
        palette = new Palette.fromHueList(
          [
           Math.random()*255,Math.random()*255,Math.random()*255,
           Math.random()*255,Math.random()*255,Math.random()*255,
           Math.random()*255,Math.random()*255,Math.random()*255,
           Math.random()*255,Math.random()*255,Math.random()*255,
           Math.random()*255,Math.random()*255,Math.random()*255,
           Math.random()*255,Math.random()*255,Math.random()*255,
           Math.random()*255,Math.random()*255,Math.random()*255,
           Math.random()*255,Math.random()*255,Math.random()*255,
           Math.random()*255,Math.random()*255,Math.random()*255,
           Math.random()*255,Math.random()*255,Math.random()*255,
           Math.random()*255,Math.random()*255,Math.random()*255,
           Math.random()*255,Math.random()*255,Math.random()*255
           ]);
        */
        
        var stopwatch = new Stopwatch.start();
        MandelbrotFast m = new MandelbrotFast(canvas.height, canvas.width, context, palette, zoom);
        m.draw();
        stopwatch.stop();
        write("MandelbrotFast took ${stopwatch.elapsedInMs()}ms");
      } else if (i==1) {
        /*
        palette = new Palette.fromHueList(
          [
           Math.random()*255,Math.random()*255,Math.random()*255,
           Math.random()*255,Math.random()*255,Math.random()*255,
           Math.random()*255,Math.random()*255,Math.random()*255,
           Math.random()*255,Math.random()*255,Math.random()*255,
           Math.random()*255,Math.random()*255,Math.random()*255,
           Math.random()*255,Math.random()*255,Math.random()*255,
           Math.random()*255,Math.random()*255,Math.random()*255,
           Math.random()*255,Math.random()*255,Math.random()*255,
           Math.random()*255,Math.random()*255,Math.random()*255,
           Math.random()*255,Math.random()*255,Math.random()*255,
           Math.random()*255,Math.random()*255,Math.random()*255,
           Math.random()*255,Math.random()*255,Math.random()*255
           ]);
        */
        
        var stopwatch = new Stopwatch.start();
        MandelbrotSlow m = new MandelbrotSlow(canvas.height, canvas.width, context, palette, zoom);
        m.draw();
        stopwatch.stop();
        write("MandelbrotSlow took ${stopwatch.elapsedInMs()}ms");
      }
      paintit.disabled=false;
    });
    

    
  }

  void write(String message) {
    // the HTML library defines a global "document" variable
    document.query('#status').innerHTML = message;
  }
}

void main() {
  new MandelbrotSpeedExample().run();
}
