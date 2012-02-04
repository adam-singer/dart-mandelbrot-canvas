class Palette {

  List hue;
  List colors;
  
  Palette() {
    hue=[
                  255,0,0,
                  0,255,0,
                  0,0,255,
                  0,255,255,
                  255,0,255,
                  255,255,0,
                  255,255,255,
                  0,0,0,
                  255,128,0,
                  139,69,19,
                  128,0,128,
                  255,105,180];
    colors = new List();
    buildpal(16);
  }
  
  Palette.fromHueList(this.hue) {
    colors = new List();
    buildpal(16);
  }
  
  buildpal(var perhue) {
    colors.clear();
    var hue1,hue2,row;
       
    for(var pass=0;pass<2;++pass)
    {
      row=0;
      hue1=0;
      
      for(hue2=2;hue2<=5;++hue2)
      {
        if(hue2>=0)
        {
          spreadPalette(perhue,row,hue1,hue2);
          ++row;
        }
        hue1=hue2;
      }
    }
  }
  
  spreadPalette(n,row,hue1,hue2) {
    var r1,g1,b1,r2,g2,b2;
    var i,r,g,b,f1,f2;

    r1=hue[hue1*3];
    r2=hue[hue2*3];
    g1=hue[hue1*3+1];
    g2=hue[hue2*3+1];
    b1=hue[hue1*3+2];
    b2=hue[hue2*3+2];
    for(i=0;i<n;++i)
    {
      f2=i/n;
      f1=1.0-f2;
      r=((r1*f1)+(r2*f2)).toInt();
      g=((g1*f1)+(g2*f2)).toInt();
      b=((b1*f1)+(b2*f2)).toInt();
      colors.add(r);
      colors.add(g);
      colors.add(b);
    }
  }
}
