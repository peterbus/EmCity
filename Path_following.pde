void import_GH() { //String_for_import_points_for_path_following_splie

  String GH_PT[]=loadStrings("path_following_line.txt");

  for (int x=GH_PT.length-1; x>=0; x--) {
    float point[]=float (split (GH_PT[x], " "));
    PVector Temp_PT= new PVector(point[0], point[1]);
    GHpoints[x]=Temp_PT;
  }
}


// Spline_definition_for_path_following_test

void path_following() {


  sp_path=new Spline3D();//deklaracia - nazov krivky
  for (int i=0; i<1941; i++) {//vytvor body, je ich taky a taky pocet=musi sediet s Grassom
    import_GH();//calling function
    PVector a =GHpoints[i];
    Vec3D v =new Vec3D(a.x, a.y, 0);//tu sa mi budu nacitavat suradnice bodov (z Grasshoppera GH_Send)
    sp_path.add(v);
  }
}


//Draw spline_for_path_following_test

void draw_spline() {

  for (int i= 1; i<sp_path.pointList.size (); i++) {
    Vec3D a = sp_path.pointList.get(i);
    Vec3D b = sp_path.pointList.get(i-1);
    stroke(0, 90);//farba linky
    line(a.x, a.y, a.z, b.x, b.y, b.z); //tu je definovane, ze sa bude kreslit linka na zaklade spojenia serie bodov
  }
}