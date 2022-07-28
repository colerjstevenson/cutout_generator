PImage img;
ArrayList<PShape> shapes;
float sunx = random(0, width);
float suny = random(0, height);
float base = random(0, 255);
PImage mask;
int wig = 5;
import java.util.Collections;



void setup(){
  size(1280, 720);
  img = loadImage("spider.jpg");
  mask = loadImage("mask.jpg");
  colorMode(HSB, 255);
  img.filter(POSTERIZE, 50);
  shapes = new ArrayList<PShape>();
  background(255);
  fill(0);
  
  for(int i = 0; i < 40; i++){
    createCutOut(100);
    print(i);
  }
  
  for(int i = 0; i < 1500; i++){
    createCutOut(40);
  }
  ArrayList<PShape> temp = new ArrayList<PShape>(shapes);
  
  shapes = new ArrayList<PShape>();
  
  for(int i = 0; i < 5000; i++){
    createCutOut(20);
  }
  
  for(int i = 0; i < 2000; i++){
    createCutOut(19);
  }
  
  Collections.shuffle(shapes);
  temp.addAll(shapes);
  shapes = new ArrayList<PShape>(temp);
  showShapes();
  //printShapes(150);

  
 
}

void draw(){
  if(mousePressed){
    printShapes(150);  
  }
}






void createCutOut(int size){
  float r = random(5, size);
  float x = random(50,width-50)+random(-20, 20);
  float y = random(50, height-50)+random(-20, 20);
  
  while(size < 20 && mask.get(int(x), int(y)) == mask.get(0, 0)){
      x = random(50,width-50)+random(-20, 20);
      y = random(50, height-50)+random(-20, 20);
  }
  
  float p = 0;
  
  fill(255);
  //ellipse(x, y, 2*r, 2*r);
  float hue = hue(img.get(int(x), int(y)));
  float bri = brightness(img.get(int(x), int(y)));
  float sat = saturation(img.get(int(x), int(y)))+50;
  if(hue > 255){
    hue -= 255;  
  }
  color tc  = color(wiggle(hue), wiggle(sat), wiggle(bri));
  PShape s = createShape();
  s.beginShape();
  
  s.fill(tc);
  s.noStroke();
  while(p < TWO_PI){
    float tr = random(r/2, r);
    float px = x + sin(p)*tr;
    float py = y + cos(p)*tr;
    
    s.vertex(px, py);
    
    p += random(0, PI/2);
    
  }
  s.endShape(CLOSE);
  
  shapes.add(s);
  
  //shape(s);
}

float wiggle(float n){
  float wiggle = random(-wig, wig);
  
  float new_n = n + wiggle;
  if(new_n < 0){
    new_n = 0;  
  }
  if(new_n > 255){
   new_n = 255;  
  }
  
  return new_n;
}


void showShapes(){
  for(int i = 0; i < shapes.size(); i++){
    shape(shapes.get(i));  
  }
  
}

void printShapes(int comb){
  String name = "sony";
  
  for(int frame = 0; frame < shapes.size()/comb; frame++){
    background(255);
    fill(0);
    for(int i = 0; i < comb; i ++){
      shape(shapes.get(frame*comb + i));
    }
    
    if(frame > 99){
       save("output/"+ name + "/" +frame+".png");
     }else if(frame >9){
       save("output/"+ name + "/0"+frame+".png");
     }else{
       save("output/"+ name + "/00"+frame+".png");  
     }
     
    
  }
    
}
