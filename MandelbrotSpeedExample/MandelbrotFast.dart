// Reference http://www.scale18.com/canvas2.html
class MandelbrotFast {

  final height;
  final width;
  final context;
  final palette;
  final zoom;
  ImageData imageData;
  CanvasPixelArray canvasPixelArray;
  
  MandelbrotFast(this.height, this.width, this.context, this.palette, this.zoom) {
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
    
    var zimag;
    var zreal;
    var rsquared;
    var isquared;
    var zboth;
    var izimag=0.0;
    var izreal=0.0;
    var irsquared=0.0;
    var iisquared=0.0;
    
    var xch=(xzoom*2)/width;  /* xch is the width of each pixel */
    var ych=(yzoom*2)/height;  /* ych is the height of each pixel */
    var cimag=0.0-yzoom;
    
    for(var y=0;y<height;y++) {
      
      var creal=xmin;
      for(var x=0;x<width;x++) {
        zimag=izimag;
        zreal=izreal;
        rsquared=irsquared;
        isquared=iisquared;
        
        int i=0;
        for(;i<palette.colors.length-3;i+=3) {
          zboth = zreal * zimag;
          zimag = zboth+zboth+cimag;
          zreal = (rsquared - isquared)+creal;

          rsquared = zreal * zreal;
          isquared = zimag * zimag;

          if ((rsquared + isquared) > 4.0)
          {
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
