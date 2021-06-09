Bola[] bolas;
int n;
int h = 0;
float div;
float ang;

void setup() {
  size(800, 800);
  colorMode(HSB, 360, 100, 100);
  bolas = new Bola[0];
  n = 4;
  float coly = height/n;
  float colx = width/n;
  div = min(width, height)/n; 
  for (float gridy = 0; gridy < n; gridy++) {
    float y = gridy * coly + coly/2;
    for (float gridx = 0; gridx < n; gridx++) {
      float x = gridx * colx + colx/2;
      bolas = (Bola[]) expand(bolas, bolas.length + 1);
      bolas[bolas.length-1] = new Bola(x, y, 0.4*div);
    }
  }
}

void draw() {
  randomSeed(0);
  background(210, 5, 100);
  for (int i = 0; i < bolas.length; i++) {
    bolas[i].ang += random(1, 8);
    bolas[i].display();
    bolas[i].over();
    if (bolas[i].d > div) {
      bolas[i].d = div;
    } 
    if (bolas[i].d < 0.4*div) {
      bolas[i].d = 0.4*div;
    }
  }
}

class Bola {
  float x, y, d, inc;  
  float ang = 1;
  boolean mouseover = false;

  Bola(float bx, float by, float bd) {
    x = bx;
    y = by;
    d = bd;
  }

  void display() {
    rectMode(CENTER);
    pushMatrix();
    translate(x, y);
    rotate(radians(ang));
    strokeWeight(2);
    stroke(0, 0, 100);
    fill(360-mouseY/4, 70, 80);
    circle(0, 0, d);

    fill(360-mouseX, 80, 80);
    square(0, 0, d-48);

    fill(360-(mouseY-200), 50, 80);
    quad(0, 0-d/2.3, 0+d/3, 0, 0, 0+d/2.3, 0-d/3, 0);

    fill(360-(mouseX-200), 90, 80);
    circle(0, 0, d-90);

    line(0-d/10, 0+d/10, 0+d/10, 0-d/10);
    line(0-d/10, 0-d/10, 0+d/10, 0+d/10);

    popMatrix();
  }

  void over() {
    inc = 5;
    float distancia = dist(mouseX, mouseY, x, y);
    if (distancia < d/2) {
      mouseover = true;
      d += inc;
      ang += 5;
    } else {
      mouseover = false;
      d-= inc;
    }
  }
}
