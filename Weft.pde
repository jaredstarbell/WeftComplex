class Weft {
  float x, y;
  float t;
  float agex, agey;  
  
  float tPeak;
  float tDuration;
  float tLen;
  
  int age, maxage;
  
  float ox, oy;
  
  float step = 1.0;
  
  color myc = 0x33FFFFFF;
  
  Weft(float _x, float _y, float _t, float _peak, float _duration, float _len) {
    x = _x;
    y = _y;
    t = _t;
    tPeak = _peak;
    tDuration = _duration;
    tLen = _len;

    agex = 0;
    agey = 0;

    // bound check
    tPeak = max(0,tPeak);
    tPeak = min(1,tPeak);
    float maxDuration = min(tPeak,1-tPeak);
    tDuration = min(maxDuration,tDuration);
  
    age = 0;
    maxage = floor(height*.8/step);
  }
  
  void update() {
    if (age>=maxage) return;
    
    // mark last known position
    ox = x+agex;
    oy = y+agey;
    
    // move along
    float dx = step*cos(t);
    float dy = step*sin(t);
    x+=dx;
    y+=dy;
    
    // divergent movement across time
    float f = (1.0*age)/maxage;
    if (abs(tPeak-f)<tDuration) {
      // calculate magnitude of divergent time peak
      float mag = 1.0 - abs(f-tPeak)/tDuration;

      //float dir = 0;//TWO_PI*noise(x*.05);
      //float len = 100*noise(f*.05,x*.05);
      //agex = mag*tLen*noise(y*warp,x*warp);
      //agey = mag*len*sin(dir);
      agex = mag*tLen*(noise(x*warp,y*warp)-.5);
      agey = mag*tLen*(noise(weft+x*warp,y*warp)-.5);
    }
    
    
    render();
    
    age++;
  }
  
  void render() {
    stroke(myc);
    line(ox,oy,x+agex,y+agey);
  }
  
}
