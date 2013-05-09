int circle_count = 146;
Circle[] circles;
String[] major;
String[] incomeDisp;
PFont font = createFont("ArialRoundedMTBold", 24);
PFont font2 = createFont("times", 16);
PFont font3 = createFont("ArialRoundedMTBold", 75);
PFont font4 = createFont("ArialRoundedMTBold", 100);
PFont font5 = createFont("ArialRoundedMTBold", 50);

int w = 2000;
int h = 1024;
int cx;
int cy;

void setup () {
  size(w, h);
  background(240);
  smooth();
  cx = w/2;
  cy = h/2;
  
  String[] majortxt = loadStrings("whatsitworthdata.txt");
  String[] incometxt = loadStrings("whatsitworthincome2.txt");
  
  String[] majorTemp = split(majortxt[0], ", ");
  String[] incTemp = split(incometxt[0], ",");
  major = majorTemp;
  incomeDisp = incTemp;
  int[] income = PApplet.parseInt(incTemp);
 
  float zoomout = 3.8;
  int i;
  
  int[] c = new int[circle_count];
  
  circles = new Circle[circle_count];
  for (i=0; i<circle_count; i++)
  {
    //used area to find proper radius, as is to not augment data
    c[i] = round(sqrt(income[i]/PI)/zoomout);
  }
  //c = sort(c);
  for (i=0; i<circle_count; i++)
  {
    circles[i] = new Circle(c[circle_count-1-i]);
  }
  circles[0].x = cx;
  circles[0].y = cy;
  circles[0].computed = true;
  
  for (i=1; i<circle_count; i++)
  {
    circles[i].computePosition(circles);
  }
  
 
  
}

void draw () {
  /**/
  background(255);
 
  int xx = 10;
  int yy = 620;
  int yloc = 640;
  
  fill(46,139,87);
  textFont(font3);
  text("WHAT", 300, 200);
  textFont(font4);
  text("I$ IT", 300, 283);
  textFont(font5);
  text("WORTH?", 300, 340);
  
  textAlign(LEFT);
  noStroke();
  
  
  textFont(font);
  
  for(int b = 0; b < 15; b++){  
       if(b == 0){
       fill(255,24,0); //red
       rect(xx,yy,50,25);
       text("Agriculture and Natural Resources", 75, yloc);
       yy+=25;
       yloc+=25;
     } else if(b == 1){
       fill(255,128,0); //orange
       rect(xx,yy,44,25);
       text("Arts", 69, yloc);
       yy+=25;
       yloc+=25;
     } else if(b == 2){
       fill(255,255,0); //yellow
       rect(xx,yy,50,25);
       text("Biology and Life Science", 75, yloc);
       yy+=25;
       yloc+=25;
     } else if(b == 3){
       fill(204,204,0); //nasty yellow
       rect(xx,yy,60,25);
       text("Business", 85, yloc);
       yy+=25;
       yloc+=25;
     } else if(b == 4){
       fill(128,128,0); //olive
       rect(xx,yy,50,25);
       text("Communication and Journalism", 75, yloc);
       yy+=25;
       yloc+=25;
     } else if(b == 5){
       fill(178,255,102); //light green
       rect(xx,yy,70,25);
       text("Computers and Mathematics", 95, yloc);
       yy+=25;
       yloc+=25;
     } else if(b == 6){
       fill(46,139,87); //sea green
       rect(xx,yy,42,25);
       text("Education", 67, yloc);
       yy+=25;
       yloc+=25;
     } else if(b == 7){
       fill(70,196,77); //green
       rect(xx,yy,75,25);
       text("Engineering", 100, yloc);
       yy+=25;
       yloc+=25;
     } else if(b == 8){
       fill(51,51,255);  // blue
       rect(xx,yy,60,25);
       text("Health", 85, yloc);
       yy+=25;
       yloc+=25;
     } else if(b == 9){
       fill(64,224,208); //turquoise
       rect(xx,yy,47,25);
       text("Humanities and Liberal Arts", 72, yloc);
       yy+=25;
       yloc+=25;
     } else if(b == 10){
       fill(240,128,114); //coral
       rect(xx,yy,50,25);
       text("Industrial Arts and Consumer Services", 75, yloc);
       yy+=25;
       yloc+=25;
     } else if(b == 11){
       fill(75,0,130); //indigo
       rect(xx,yy,50,25);
       text("Law and Public Policy", 75, yloc);
       yy+=25;
       yloc+=25;
     } else if(b == 12){
       fill(100,149,237);  //cornflower blue
       rect(xx,yy,59,25);
       text("Physical Science", 84, yloc);
       yy+=25;
       yloc+=25;
     } else if(b == 13){
       fill(138,43,226); //purple
       rect(xx,yy,42,25);
       text("Psychology and Social Work", 67, yloc);
       yy+=25;
       yloc+=25;
     } else if(b == 14){
       fill(255,0,127); // pink
       rect(xx,yy,55,25);
       text("Social Science", 80, yloc);
       yy+=25;
       yloc+=25;
     }
   }

  
  int i;
  
  for (i=0; i<circle_count; i++)
  {
    circles[i].display();
  }
  /**/
}

class Circle {
  int x, y;
  int radius;
  boolean computed = false;
  
  Circle (int r) {
    radius = r;
  }
  
  void computePosition (Circle[] c) {
    int i, j;
    boolean collision;
    Point[] openPoints = new Point[0];
    int ang;
    Point pnt;
    
    if (computed) { return; }
    
    for (i=0; i<c.length; i++)
    {
      if (c[i].computed)
      {
        ang = 0;
        for (ang=0; ang<360; ang+=1)
        {
          collision = false;
          pnt = new Point();
          pnt.x = c[i].x + int(cos(ang*PI/180) * (radius+c[i].radius+1));
          pnt.y = c[i].y + int(sin(ang*PI/180) * (radius+c[i].radius+1));
          
          for (j=0; j<c.length; j++)
          {
            if (c[j].computed && !collision)
            {
              if (dist(pnt.x, pnt.y, c[j].x, c[j].y) < radius + c[j].radius)
              {
                collision = true;
              }
            }
          }
          
          if (!collision)
          {
            openPoints =  (Point[]) expand(openPoints, openPoints.length+1);
            openPoints[openPoints.length-1] = pnt;
          }
        }
      }
    }
    
    float min_dist = -1;
    int best_point = 0;
    for (i=0; i<openPoints.length; i++)
    {
      if (min_dist == -1 || dist(cx, cy, openPoints[i].x, openPoints[i].y) < min_dist)
      {
        best_point = i;
        min_dist = dist(cx, cy, openPoints[i].x, openPoints[i].y);
      }
    }
    if (openPoints.length == 0)
    {
      println("no points?");
    } else
    {
      //println(openPoints.length + " points");
      x = openPoints[best_point].x;
      y = openPoints[best_point].y;
    }
    
    computed = true;
  }
  
  void display () {
    int i;
    
    for (i=0; i<circles.length; i++)
    {
        
      
      ellipseMode(CENTER);
      noStroke();
      if(i < 9){
       fill(255,24,0); //red
     } else if(i >=9 && i < 16){
       fill(255,128,0); //orange
     } else if(i >=16 && i < 26){
       fill(255,255,0); //yellow
     } else if(i >=26 && i < 39){
       fill(204,204,0); //nasty yellow
     } else if(i >=39 && i < 43){
       fill(128,128,0); //olive
     } else if(i >=43 && i < 54){
       fill(178,255,102); //light green
     } else if(i >=54 && i < 67){
       fill(46,139,87); //sea green
     } else if(i >=67 && i < 92){
       fill(70,196,77); //green
     } else if(i >=92 && i < 103){
       fill(51,51,255);  // blue
     } else if(i >=103 && i < 111){
       fill(64,224,208); //turquoise
     } else if(i >=111 && i < 117){
       fill(240,128,114); //coral
     } else if(i >=117 && i < 121){
       fill(75,0,130); //indigo
     } else if(i >=121 && i < 129){
       fill(100,149,237);  //cornflower blue
     } else if(i >=129 && i < 136){
       fill(138,43,226); //purple
     } else if(i >=136 && i < 146){
       fill(255,0,127); // pink
     }
      ellipse(circles[i].x, circles[i].y, circles[i].radius*2, circles[i].radius*2);
      //hidden because of fill but wrong anyway
      //fill(255);
      textAlign(CENTER);
      textFont(font2);
      text(incomeDisp[i], circles[i].x, circles[i].y);
    }
  }
}


class Point {
  int x, y;
  
  Point () {
  }
  
 }
