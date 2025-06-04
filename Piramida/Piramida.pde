int numLaturi = 5;
float radius = 100;
float height = 150;

color culoareCurenta = color(255, 100, 100);
boolean wireframe = false;

float scaleFactor = 1;
float tx = 0, ty = 0, tz = 0;
float angleX = 0, angleY = 0, angleZ = 0;

void setup() {
  size(800, 800, P3D);
  textFont(createFont("Arial", 14));
}

void draw() {
  background(200);
  lights();
  camera();
  fill(0);
  text("Taste: 3-9 = laturi | R, G, B = culoare | J = mod wireframe | +/- = scalare", 10, 20);
  text("WASD/QE = translație | Săgeți/Z/X = rotație", 10, 40);
  text("Laturi curente: " + numLaturi, 10, 60);

  if (wireframe) {
    noFill();
    stroke(0);
  } else {
    noStroke();
    fill(culoareCurenta);
  }

  pushMatrix();
  translate(width/2 + tx, height*3 + ty, tz);
  scale(scaleFactor);
  rotateX(angleX);
  rotateY(angleY);
  rotateZ(angleZ);

  drawPyramid(numLaturi, radius, height);
  popMatrix();
}

void drawPyramid(int sides, float r, float h) {
  if (sides < 3 || sides > 10) return;

  PVector top = new PVector(0, -h, 0);
  PVector[] basePoints = new PVector[sides];

  for (int i = 0; i < sides; i++) {
    float angle = TWO_PI * i / sides;
    float x = cos(angle) * r;
    float z = sin(angle) * r;
    basePoints[i] = new PVector(x, 0, z);
  }

  beginShape();
  for (int i = 0; i < sides; i++) {
    vertex(basePoints[i].x, basePoints[i].y, basePoints[i].z);
  }
  endShape(CLOSE);

  for (int i = 0; i < sides; i++) {
    int next = (i + 1) % sides;
    beginShape();
    vertex(top.x, top.y, top.z);
    vertex(basePoints[i].x, basePoints[i].y, basePoints[i].z);
    vertex(basePoints[next].x, basePoints[next].y, basePoints[next].z);
    endShape(CLOSE);
  }
}

void keyPressed() {
  if (key == 'r') culoareCurenta = color(255, 0, 0);
  if (key == 'g') culoareCurenta = color(0, 255, 0);
  if (key == 'b') culoareCurenta = color(0, 0, 255);

  if (key == 'j' || key == 'J') wireframe = !wireframe;

  if (key >= '3' && key <= '9') numLaturi = key - '0';

  if (key == '+') scaleFactor += 0.1;
  if (key == '-') scaleFactor = max(0.1, scaleFactor - 0.1);

  if (key == 'a') tx -= 10;
  if (key == 'd') tx += 10;
  if (key == 'w') ty -= 10;
  if (key == 's') ty += 10;
  if (key == 'q') tz += 10;
  if (key == 'e') tz -= 10;

  if (keyCode == UP) angleX -= 0.1;
  if (keyCode == DOWN) angleX += 0.1;
  if (keyCode == LEFT) angleY -= 0.1;
  if (keyCode == RIGHT) angleY += 0.1;
  if (key == 'z') angleZ -= 0.1;
  if (key == 'x') angleZ += 0.1;
}
