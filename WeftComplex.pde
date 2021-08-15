// Weft Complex
//   Jared S Tarbell
//   Santa Fe, New Mexico, USA
//   January 13, 2021

ArrayList<Weft> wefts = new ArrayList<Weft>();

float warp, weft;

void setup() {
  fullScreen(FX2D);
  background(0);
  
  init();
}

void init() {
  background(0);
  wefts.clear();
  
  // randomize noise parameters for individual wefts
  warp = random(.005,.01);
  weft = random(1000);
  
  // generate the layout of wefts
  int totalWidth = floor(width*.8);
  println("totalWidth:"+totalWidth);
  int num = floor(totalWidth/3);
  totalWidth = num*3;      // adjust total width to fit modulus
  float spc = totalWidth/num;
  float startx = floor(width*.1);
  float layoutWarp = random(.0001,.001);
  float layoutWeft = random(1000);
  for (int i=0;i<num;i++) {
    float px = startx+spc*i;    // initial x position
    float py = height*.9;       // initial y position
    float pt = -HALF_PI;        // theta angle of travel
    float pk = noise(layoutWeft + px*layoutWarp);  // displacement peak
    //pk = .5;
    float pd = pk*noise(layoutWeft + px*layoutWarp);     // displacement duration
    //pd = random(.2,.5);
    //pd = .5;
    float plen = 100;    // length of displacement
    Weft p = new Weft(px,py,pt,pk,pd,plen);
    wefts.add(p);
  }
  println("warp:"+warp+"   weft:"+weft);
  
  // highlight mods
  for (int i=0;i<wefts.size();i++) {
    if (i%5==0) wefts.get(i).myc = 0xFFFFFFFF;
  }
}

void draw() {
  for (int k=0;k<4;k++) for (Weft p:wefts) p.update();
  
}

void keyPressed() {
  if (key==' ') init();
}
