String[] ptListRd, listLengthRd;
Vec3D[] ptsRd;
ArrayList <Spline3D> sprd=new ArrayList<Spline3D>();//cesty
boolean roads=true;
color txtCol = color(65);

/*void roads() {

  ptListRd=loadStrings("data/cesty_body.txt");
  listLengthRd=loadStrings("data/cesty_zoznam.txt");
  int totRd=0;
  for (int i=0; i<listLengthRd.length; i++) totRd+=int(listLengthRd[i]); 
  ptsRd=new Vec3D[totRd];
  for (int i=0; i<ptsRd.length; i++) ptsRd[i]=new Vec3D(float(ptListRd[2*i]), -float(ptListRd[2*i+1]), 0);

  // CESTY SPLINES //////////////////////////
  int itRd=0;
  int totIndexRd=0;
  for (int n=0; n<listLengthRd.length; n++) {
    Spline3D sprd0=new Spline3D();
    totIndexRd+=int(listLengthRd[n]);
    for (int i=itRd; i<totIndexRd; i++) {
      Vec3D v=new Vec3D(ptsRd[i].copy());
      sprd0.add(v);
    }
    itRd+=int(listLengthRd[n]);
    sprd.add(sprd0);
  }
}*/

void draw_roads() {
  // DRAW ROADS /////////////////////////////////////////////////
  stroke(txtCol, 150);
  strokeWeight(1);
  int itRd=0;
  int totIndexRd=0;  
  for (int iter=0; iter<listLengthRd.length; iter++) {
    totIndexRd+=int(listLengthRd[iter]);
    for (int i=itRd+1; i<totIndexRd; i++) if (roads) line(ptsRd[i-1].x, ptsRd[i-1].y, ptsRd[i].x, ptsRd[i].y);
    itRd+=int(listLengthRd[iter]);
  }
}


void points_Draw() {

  // draw initialization points for agents
  ellipseMode(CENTER);
  fill(255, 132, 0, 90);// Set fill to orange
  stroke(255, 100, 0); // Set stroke to deep orange
  strokeWeight(3);
 // ellipse(mouseX-width/2, mouseY-height/2, 15, 15);
  
/*  ellipse(-407, 37, 15, 15);
  ellipse(125, 225, 15, 15); 
  ellipse(158, -282, 15, 15);
  ellipse(576, 433, 15, 15);
  ellipse(288, 596, 15, 15);
  ellipse(752, 606, 15, 15);
  ellipse(879, -289, 15, 15);
  ellipse(-304, 474, 15, 15);*/
  
  ellipse(ax, ay, 15, 15);
  ellipse(bx, by, 15, 15); 
  ellipse(cx, cy, 15, 15);
  ellipse(dx, dy, 15, 15);
  ellipse(ex, ey, 15, 15);
  ellipse(fx, fy, 15, 15);
  ellipse(gx, gy, 15, 15);
  ellipse(hx, hy, 15, 15);
  
  
  

  
}