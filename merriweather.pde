import java.awt.Frame;
import java.awt.BorderLayout;
import controlP5.*;

int sz= 20;//(int)random(20)+10;
int um= 8;

float f= TWO_PI / um;
int xt, yt;
float der=0.00f;

int d=10;
int l=0;

private ControlP5 cp5;

ControlFrame cf;

PGraphics pg;
void setup() {
  size(600, 600);
  addControlFrame("ctrl", 300, 420);
  buildIt();

}

void buildIt() {
  println("Y"+sz+"-"+um+"-"+der+"-"+d+"-"+l+".tiff");
  pg = createGraphics(1800, 1800);
  //
  pg.beginDraw();
  pg.strokeWeight(d);
  pg.background(0, 0, 200);
  xt= (pg.width-200) / sz;
  yt= (pg.height-200) / sz;
  pg.smooth();
  for (int y=0; y < sz;y++) {
    for (int x=0; x < sz;x++) {

      pg.pushMatrix();
      pg.translate(xt/2+x*xt+100, yt/2+y*yt+100);
      pg.rotate((x+y)*f+PI*random(1-der, 1+der));
      drawM();
      pg.popMatrix();

    }
  }
  pg.endDraw();
  image(pg, 0, 0, width, height);
  //  pg.save("Y"+sz+"-"+um+"-"+der+"-"+d+"-"+l+".tiff");
}

void draw() {
}


void drawM() {
  pg.stroke(20, 200, 20);
  pg.line(-xt/2-l, 0, xt/2+l, 0); 
  pg.stroke(255);
  pg.line(-xt/2-l, -d, xt/2+l, -d);   
  pg.stroke(0);
  pg.line(-xt/2-l, d, xt/2+l, d);
}

ControlFrame addControlFrame(String theName, int theWidth, int theHeight) {
  Frame f = new Frame(theName);
  ControlFrame p = new ControlFrame(this, theWidth, theHeight);
  f.add(p);
  p.init();
  f.setTitle(theName);
  f.setSize(p.w, p.h);
  f.setLocation(100, 100);
  f.setResizable(false);
  f.setVisible(true);
  return p;
}

public class ControlFrame extends PApplet {

  int w, h;


  public void setup() {
    size(w, h);
    frameRate(25);
    PFont font = createFont("arial", 20);
    cp5 = new ControlP5(this);
    cp5.addTextfield("sz")
      .setPosition(20, 20)
        .setSize(200, 40)
          .setFont(font)
            .setFocus(true)
              .setColor(color(255, 0, 0));

    cp5.addTextfield("turn")
      .setPosition(20, 80)
        .setSize(200, 40)
          .setFont(font)
            .setFocus(true)
              .setColor(color(255, 0, 0))
                ;
    cp5.addTextfield("error")
      .setPosition(20, 140)
        .setSize(200, 40)
          .setFont(font)
            .setFocus(true)
              .setColor(color(255, 0, 0))
                ;
    cp5.addTextfield("weight")
      .setPosition(20, 200)
        .setSize(200, 40)
          .setFont(font)
            .setFocus(true)
              .setColor(color(255, 0, 0))
                ;
    cp5.addTextfield("length")
      .setPosition(20, 260)
        .setSize(200, 40)
          .setFont(font)
            .setFocus(true)
              .setColor(color(255, 0, 0));
    cp5.addBang("save")
      .setPosition(20, 320)
        .setSize(40, 40) ;
  }

  void save() {
    pg.save("Y"+sz+"-"+um+"-"+der+"-"+d+"-"+l+".tiff");
  }

  public void sz(String theText) {
    sz = Integer.valueOf(theText);
    buildIt();
  }

  public void turn(String theText) {
    um = Integer.valueOf(theText);
    f = TWO_PI / um;
    buildIt();
  }

  public void error(String theText) {
    der = Float.valueOf(theText);
    buildIt();
  }

  public void weight(String theText) {
    d = Integer.valueOf(theText);
    buildIt();
  }

  public void length(String theText) {
    l = Integer.valueOf(theText);
    buildIt();
  }


  public void draw() {
    background(0);
    text(sz, 230, 50);
    text(um, 230, 110);
    text(der, 230, 170);
    text(d, 230, 230);
    text(l, 230, 290);
  }

  private ControlFrame() {
  }

  public ControlFrame(Object theParent, int theWidth, int theHeight) {
    parent = theParent;
    w = theWidth;
    h = theHeight;
  }


  public ControlP5 control() {
    return cp5;
  }


  ControlP5 cp5;

  Object parent;
}

