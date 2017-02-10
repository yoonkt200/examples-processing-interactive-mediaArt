import processing.serial.*;

int lf = 10;    // Linefeed in ASCII
String myString = null;
Serial myPort;  // Serial port you are using
String convert1;
String convert2;
float x_num, y_num;
//////////////////////////////////////////////////////////////////////
PImage right_arm1, right_arm2, left_arm1, left_arm2;
PImage right_leg, left_leg;
PImage face, body;
PImage backGround;
//////////////////////////////////////////////////////////////////////
float segArmLength = 100;
float segLegLength = 150;
float segFaceLength = 30;
float facex,facey;
float facex_bound;
float facey_bound;
float bodyx=800;
float bodyy=500;

float leftx, lefty, leftx2, lefty2, leftx3, lefty3;
float rightx, righty, rightx2, righty2, rightx3, righty3;
float leg_leftx, leg_lefty, leg_leftx3, leg_lefty3;
float leg_rightx, leg_righty, leg_rightx3, leg_righty3;
///////////////////////////////////////////////////////////////////////
Spring2D s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12;
Spring2D ss1, ss2, ss3, ss4, ss5, ss6, ss7, ss8, ss9, ss10, ss11, ss12;
leftarmmotion_Spring2D leftarm; 
leftlegmotion_Spring2D leftleg;
rightarmmotion_Spring2D rightarm; 
rightlegmotion_Spring2D rightleg;

float gravity = 3.0;
float mass = 2.0;
float motion_gravity = 0.2;
float motion_mass = 2.0;
///////////////////////////////////////////////////////////////////////
void setup() {
  size(1597, 897);
  
  right_arm1 = loadImage("rightarm1.png");
  right_arm2 = loadImage("rightarm2.png");
  left_arm1 = loadImage("leftarm1.png");
  left_arm2 = loadImage("leftarm2.png");
  right_leg = loadImage("rightleg.png");
  left_leg = loadImage("leftleg.png");
  face = loadImage("face.png");
  body = loadImage("body.png");
  backGround = loadImage("background.png");
  
  strokeWeight(20.0);
  stroke(0,100);
  
  leftarm = new leftarmmotion_Spring2D(0.0, width/2, motion_mass, motion_gravity);
  rightarm = new rightarmmotion_Spring2D(0.0, width/2, motion_mass, motion_gravity);
  leftleg = new leftlegmotion_Spring2D(0.0, width/2, motion_mass, motion_gravity);
  rightleg = new rightlegmotion_Spring2D(0.0, width/2, motion_mass, motion_gravity);
      
  s1 = new Spring2D(0.0, width/2, mass, gravity);
  s2 = new Spring2D(0.0, width/2, mass, gravity);
  s3 = new Spring2D(0.0, width/2, mass, gravity);
  s4 = new Spring2D(0.0, width/2, mass, gravity);
  s5 = new Spring2D(0.0, width/2, mass, gravity);
  s6 = new Spring2D(0.0, width/2, mass, gravity);
  s7 = new Spring2D(0.0, width/2, mass, gravity);
  
  ss1 = new Spring2D(0.0, width/2, mass, gravity);
  ss2 = new Spring2D(0.0, width/2, mass, gravity);
  ss3 = new Spring2D(0.0, width/2, mass, gravity);
  ss4 = new Spring2D(0.0, width/2, mass, gravity);
  ss5 = new Spring2D(0.0, width/2, mass, gravity);
  ss6 = new Spring2D(0.0, width/2, mass, gravity);
  ss7 = new Spring2D(0.0, width/2, mass, gravity);
}

void draw() {
  
  bodyx = mouseX;
  bodyy = mouseY;
  
  tint(255, 240); // transparency
  background(backGround);
  
  facex = bodyx + 67; // face point
  facey = bodyy - 54; // face point
  
  leg_leftx=bodyx+40; // pevis start point
  leg_lefty=bodyy+170;
  
  leg_rightx=bodyx+95; // pevis start point
  leg_righty=bodyy+165;
  
  leftleg.update(leftx2, lefty2);
  rightleg.update(rightx2, righty2);
  
  drawTrace();
  drawLeftArm();
  drawRightArm();
  drawLeftLeg();
  drawRightLeg();
  
  stroke(0);
  strokeWeight(3);
  
  stroke(50);
  strokeWeight(1.5);
  line(leftx3,0,leftx3,lefty3);
  line(rightx3,0,rightx3,righty3);
  line(bodyx+100,0,bodyx+100,bodyy+100);
  line(leg_rightx3,0,leg_rightx3,leg_righty3);
  line(leg_leftx3,0,leg_leftx3,leg_lefty3);
  
  image(body, bodyx,bodyy);
  drawFace();
  
  bodyx=constrain(bodyx,200,1400);
  bodyy=constrain(bodyy,440,580);
}

void drawFace(){
  
  facex_bound = bodyx;
  facey_bound = 50;
 
  facex_bound += random(-3,3);
  facey_bound += random(-3,3);
  
  float dx = facex_bound - facex;
  float dy = facey_bound - facey;
  float angle1 = atan2(dy, dx);  
  
  face_segment(facex, facey, angle1, face); 
}

void drawLeftArm(){

  leftx2 = bodyx+41;
  lefty2 = bodyy+47;
  
  leftarm.update(leftx2, lefty2);
  
  float dx = leftarm.x - leftx;
  float dy = leftarm.y - lefty;
  float angle1 = atan2(dy, dx);  
  
  float tx = leftarm.x - cos(angle1) * segArmLength;
  float ty = leftarm.y - sin(angle1) * segArmLength;
  dx = tx - leftx2;
  dy = ty - lefty2;
  
  float angle2 = atan2(dy, dx);  
  leftx = leftx2 + cos(angle2) * segArmLength;
  lefty = lefty2 + sin(angle2) * segArmLength;
  
  leftx3 = leftx+cos(angle1) * segArmLength;
  lefty3 = lefty+sin(angle1) * segArmLength;
  
  segment_left_arm(leftx, lefty, angle1, left_arm1); //real draw elbow to final
  segment_left_arm2(leftx2, lefty2, angle2, left_arm2); // real draw shoulder to elbow
}

void drawRightArm(){
  
  rightx2 = bodyx+105;
  righty2 = bodyy+30;
  
  rightarm.update(rightx2, righty2);
  
  float dx = rightarm.x - rightx;
  float dy = rightarm.y - righty;
  float angle1 = atan2(dy, dx);  
  
  float tx = rightarm.x - cos(angle1) * segArmLength;
  float ty = rightarm.y - sin(angle1) * segArmLength;
  dx = tx - rightx2;
  dy = ty - righty2;
  
  float angle2 = atan2(dy, dx);  
  rightx = rightx2 + cos(angle2) * segArmLength;
  righty = righty2 + sin(angle2) * segArmLength;
  
  rightx3 = rightx+cos(angle1) * segArmLength;
  righty3 = righty+sin(angle1) * segArmLength;
  
  segment_arm(rightx, righty, angle1, right_arm1); //real draw elbow to final
  segment_arm2(rightx2, righty2, angle2, right_arm2); // real draw shoulder to elbow
}

void drawLeftLeg(){
  float dx = leftleg.x - leg_leftx;
  float dy = leftleg.y - leg_lefty;
  float angle1 = atan2(dy, dx);  
  
  leg_leftx3 = leg_leftx  + cos(angle1) * segLegLength;
  leg_lefty3 = leg_lefty  + sin(angle1) * segLegLength;
  
  left_leg_segment(leg_leftx, leg_lefty, angle1, left_leg); 
}

void drawRightLeg(){
  float dx = rightleg.x - leg_rightx;
  float dy = rightleg.y - leg_righty;
  float angle1 = atan2(dy, dx);  
  
  leg_rightx3 = leg_rightx  + cos(angle1) * segLegLength;
  leg_righty3 = leg_righty  + sin(angle1) * segLegLength;
  
  right_leg_segment(leg_rightx, leg_righty, angle1, right_leg); 
}

void segment_arm(float x, float y, float a, PImage image) {
  pushMatrix();
  translate(x, y);
  rotate(a-90);
  image(image,-55,-20);
  popMatrix();
}

void segment_arm2(float x, float y, float a, PImage image) {
  pushMatrix();
  translate(x, y);
  rotate(a-90);
  image(image,-65,-20);
  popMatrix();
}

void segment_left_arm(float x, float y, float a, PImage image) {
  pushMatrix();
  translate(x, y);
  rotate(a-90);
  image(image,-70,-20);
  popMatrix();
}

void segment_left_arm2(float x, float y, float a, PImage image) {
  pushMatrix();
  translate(x, y);
  rotate(a-90);
  image(image,-60,-20);
  popMatrix();
}

void left_leg_segment(float x, float y, float a, PImage image) {
  pushMatrix();
  translate(x, y);
  rotate(a-90);
  image(image,-95,-10);
  popMatrix();
}

void right_leg_segment(float x, float y, float a, PImage image) {
  pushMatrix();
  translate(x, y);
  rotate(a-90);
  image(image,-70,-10);
  popMatrix();
}

void face_segment(float x, float y, float a, PImage image) {
  pushMatrix();
  translate(x, y);
  rotate(a-90);
  image(image,-70,-90);
  popMatrix();
}

void drawTrace(){
  s1.update(rightx3, righty3);
  s1.display(rightx3, righty3);
  s2.update(s1.x, s1.y);
  s2.display(s1.x, s1.y);
  s3.update(s2.x, s2.y);
  s3.display(s2.x, s2.y);
  s4.update(s3.x, s3.y);
  s4.display(s3.x, s3.y);
  s5.update(s4.x, s4.y);
  s5.display(s4.x, s4.y);
  s6.update(s5.x, s5.y);
  s6.display(s5.x, s5.y);
  s7.update(s6.x, s6.y);
  s7.display(s6.x, s6.y);
 
  ss1.update(leftx3, lefty3);
  ss1.display(leftx3, lefty3);
  ss2.update(ss1.x, ss1.y);
  ss2.display(ss1.x, ss1.y);
  ss3.update(ss2.x, ss2.y);
  ss3.display(ss2.x, ss2.y);
  ss4.update(ss3.x, ss3.y);
  ss4.display(ss3.x, ss3.y);
  ss5.update(ss4.x, ss4.y);
  ss5.display(ss4.x, ss4.y);
  ss6.update(ss5.x, ss5.y);
  ss6.display(ss5.x, ss5.y);
  ss7.update(ss6.x, ss6.y);
  ss7.display(ss6.x, ss6.y);
}