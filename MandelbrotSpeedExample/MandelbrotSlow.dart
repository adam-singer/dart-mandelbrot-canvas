// Reference http://rosettacode.org/wiki/Mandelbrot_set#Dart
class Complex {
  double _r,_i;
 
  Complex(this._r,this._i);
  double get r() => _r;
  set r(var __r) => _r=__r;
  double get i() => _i;
  set i(var __i) => __i;
  String toString() => "($r,$i)";
 
  Complex operator +(Complex other) => new Complex(r+other.r,i+other.i);
  Complex operator *(Complex other) =>
      new Complex(r*other.r-i*other.i,r*other.i+other.r*i);
  double abs() => r*r+i*i;
}

class MandelbrotSlow {

  final height;
  final width;
  final context;
  final palette;
  final zoom;
  ImageData imageData;
  CanvasPixelArray canvasPixelArray;
  
  MandelbrotSlow(this.height, this.width, this.context, this.palette, this.zoom) {
    context.fillStyle = "rgb(0,0,0)";
    context.fillRect (0,0,width,height);
    imageData=context.getImageData(0,0,width,height);
    canvasPixelArray=imageData.data;
  }
  
  draw() {
    var xzoom, yzoom;
    var index=0;
    
    if(width>height)
    {
      yzoom=zoom;
      xzoom=(width/height)*zoom;
    }
    else
    {
      xzoom=zoom;
      yzoom=(height/width)*zoom;
    }
    
    var xmin=0.0-xzoom;
    xmin-=0.5;
    
    var xch=(xzoom*2)/width;  /* xch is the width of each pixel */
    var ych=(yzoom*2)/height;  /* ych is the height of each pixel */
    var cimag=0.0-yzoom;
    
    for(var y=0;y<height;y++) {
      
      var creal=xmin;
      for(var x=0;x<width;x++) {
        Complex c=new Complex(creal,cimag);
        Complex z=new Complex(0,0);
        int i=0;
        for(;i<palette.colors.length-3;i+=3) {
          z=z*(z)+c;
          if(z.abs()>4) {
            break;
          }
        }
        
        creal+=xch;
        canvasPixelArray[index] = palette.colors[i];   // r
        canvasPixelArray[index+1] = palette.colors[i+1]; // g
        canvasPixelArray[index+2] = palette.colors[i+2]; // b
        canvasPixelArray[index+3] = 255; // a
        index+=4; 
      }
      cimag+=ych;
    }
    context.putImageData(imageData, 0,0);
  }
}
