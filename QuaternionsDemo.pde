
Quaternion point1;
Quaternion opoint1;
PShape point;
PShape navball;
PImage navballTex;
PImage blankjpg;

Quaternion rot;
Quaternion totalRot;

float turnSpeed = -1;
int t;


void setup(){
  t = 0;
  noStroke();
  point = createShape(SPHERE, 40);
  blankjpg = loadImage("blank.jpg");
  //point.setTexture(blankjpg);
  navball = createShape(SPHERE, 200);
  navballTex = loadImage("navball.png");
  navball.setTexture(navballTex);
  
  point1 = new Quaternion(0, 0, -1, 0);
  opoint1 = point1.copy();
  
  totalRot = new Quaternion(1, 0, 0, 0);
  rot = new Quaternion(0, 0, 0, 0);
  rot.fromAngleVec(radians(turnSpeed), radians(30), radians(30));
  rot.normalize();
  size(1024, 1024, P3D);
  strokeWeight(2);
}

void draw(){
  point1 = opoint1.copy();
  totalRot.mult(rot);
  point1.totalRotate(totalRot);
  background(0);
  translate(width/2, height/2, -300);
  rotateX(radians(-90));
  PVector axis = new PVector((float)rot.i, (float)rot.j, (float)rot.k);
  axis.normalize();
  stroke(color(0, 255, 0));
  line(-400*axis.x, -400*axis.y, -400*axis.z, 400*axis.x, 400*axis.y, 400*axis.z);
  pushMatrix();
  translate(200*(float)point1.i, 200*(float)point1.j, 200*(float)point1.k);
  shape(point);
  popMatrix();
  rotateX(-totalRot.toEuler(0));
  rotateY(-totalRot.toEuler(1));
  rotateZ(-totalRot.toEuler(2));
  shape(navball);
  //delay(100);
  t++;
  if(t >= 100){
    rot.fromAngleVec(radians(random(-5, 5)), radians(random(0, 360)), radians(random(0, 360)));
    t = 0;
  }
}
