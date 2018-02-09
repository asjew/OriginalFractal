int limit = 100;
int length = 10;
int Y_AXIS = 1;
int X_AXIS = 2;
color b1, b2;

public void setup() {
  size(500, 500);
  b1 = #FC5C7D;
  b2 = #6a82fb;
  // b1 = #3494E6;
  // b2 = #ec6ead;
  setGradient(0, 0, width, height, b1, b2, Y_AXIS);
}

public void draw() 
{
  myFractal(0, 0, 120+length);
}
public void keyPressed()
{
  if (key == CODED)
  {
    if (keyCode == UP)
    {
      if(limit < 1000)
      {
        limit += 5;
        length += 5;
      }
    }
    else if(keyCode == DOWN)
    {
      if (limit > 5)
      {
        limit -=5;
        length -=5;
      }
    }
  }
}

public void myFractal(int x, int y, int size)
{
	if (size <= limit)
	{
		pushMatrix();
      fill(185, 219, 232);
      stroke(145, 94, 255);
  		translate(width*0.5, height*0.5);
  		rotate(frameCount / 50.0);
  		polygon(x, y, size, 6);
  		popMatrix();
	}
	else
	{
		myFractal(x , y, size/4);
		myFractal(x + size/2, y, size/4);
		myFractal(x - size/2, y, size/4);
		myFractal(x + size/4, y - size/2 + size/12, size/4);
		myFractal(x - size/4, y - size/2 + size/12, size/4);
		myFractal(x + size/4, y + size/2 - size/12, size/4);
		myFractal(x - size/4, y + size/2 - size/12, size/4);
	}
}
public void polygon(float x, float y, float radius, int npoints) {
  float angle = TWO_PI / npoints;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius;
    float sy = y + sin(a) * radius;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}
void setGradient(int x, int y, float w, float h, color c1, color c2, int axis ) {

  noFill();

  if (axis == Y_AXIS) {  // Top to bottom gradient
    for (int i = y; i <= y+h; i++) {
      float inter = map(i, y, y+h, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(x, i, x+w, i);
    }
  }  
  else if (axis == X_AXIS) {  // Left to right gradient
    for (int i = x; i <= x+w; i++) {
      float inter = map(i, x, x+w, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(i, y, i, y+h);
    }
  }
}