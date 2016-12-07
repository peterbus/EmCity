String[] ptListB, listLengthB;
ArrayList <Spline3D> spb=new ArrayList<Spline3D>();
ArrayList <Spline3D> spb0=new ArrayList<Spline3D>();
Vec3D[] ptsB;
color blCol = color(100, 100, 100);


void buildings() {

  ptListB=loadStrings("budovy_body.txt");
  listLengthB=loadStrings("budovy_zoznam.txt");
  int totB=0;
  for (int i=0; i<listLengthB.length; i++) totB+=int(listLengthB[i]);
  ptsB=new Vec3D[totB];
  for (int i=0; i<ptsB.length; i++) ptsB[i]=new Vec3D(float(ptListB[2*i]), -float(ptListB[2*i+1]), 0);

  // BUDOVY-SPLINES //////////////////////
  int itB=0;
  int totIndexB=0;
  for (int iter=0; iter<listLengthB.length; iter++) {
    Spline3D spb0=new Spline3D();
    totIndexB+=int(listLengthB[iter]);
    for (int i=itB; i<totIndexB-1; i++) {
      Vec3D v=new Vec3D(ptsB[i].copy());
      spb0.add(v);
      if (i==totIndexB-1) {
        Vec3D V=new Vec3D(ptsB[i].copy());
        spb0.add(V);
        spb0.add(spb0.getPointList().get(0));
      }
    }
    itB+=int(listLengthB[iter]);
    spb.add(spb0);
  }
}


void drawBuildings() {

  // DRAW BUILDINGS /////////////////////////////////////////////


 // pushMatrix();
 // translate(-625, 15, 0);
  stroke(txtCol); //added for black bg
  strokeWeight(1);
  int itB=0;
  int totIndexB=0;
  for (int iter=0; iter<listLengthB.length; iter++) {
    totIndexB+=int(listLengthB[iter]);
    for (int i=itB+1; i<totIndexB; i++)if (Buildings) line(ptsB[i-1].x, ptsB[i-1].y, ptsB[i].x, ptsB[i].y);
    itB+=int(listLengthB[iter]);
  }
  stroke(blCol, 100);
  fill(blCol, 100);
//  popMatrix();
}