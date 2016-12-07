import controlP5.*;
public void initGUI() {
  controlP5 = new ControlP5(this);
  //controlP5.setColorLabel(color(250, 250, 250));  //Text Color
  ControlGroup ctrl = controlP5.addGroup("menu", 10, 20, 55);  
  ctrl.setColorLabel(color(255));
  ctrl.close(); 

  //Chart initialization
  //controlP5.printPublicMethodsFor(Chart.class);

  myChart = controlP5.addChart("Area Ratio")
    .setPosition(width-110, height-650)
      .setSize(30, 100)
        .setRange(0, 0.5)
          .setView(Chart.BAR);
  myChart.getColor().setBackground(color(#A0DB7E, 50));
  myChart.addDataSet("Area Ratio");
  myChart.setColors("Area Ratio", color(255, 85), color(255));
  myChart.setData("Area Ratio", new float[1]);
  myChart.setStrokeWeight(1);


  myChart2 = controlP5.addChart("Area Ratio C")
    .setPosition(width-80, height-650)
      .setSize(30, 100)
        .setRange(0, 0.4)
          .setView(Chart.BAR);
  myChart2.getColor().setBackground(color(#A0DB7E, 50));
  myChart2.addDataSet("Area Ratio C");
  myChart2.setColors("Area Ratio C", color(#D2E87E), color(#D2E87E));
  myChart2.setData("Area Ratio C", new float[1]);
  myChart2.setStrokeWeight(1);

  myChart3 = controlP5.addChart("Area Ratio SQ")
    .setPosition(width-50, height-650)
      .setSize(30, 100)
        .setRange(0, 0.4)
          .setView(Chart.BAR);
  myChart3.getColor().setBackground(color(#A0DB7E, 50));
  myChart3.addDataSet("Area Ratio SQ");
  myChart3.setColors("Area Ratio SQ", color(#A2B93A), color(#A2B93A));
  myChart3.setData("Area Ratio SQ", new float[1]);
  myChart3.setStrokeWeight(1);
  
    Growth = controlP5.addChart("Growth_level")
    .setPosition(width-110, height-520)
      .setSize(90, 100)
        .setRange(0.17, 0.6)
          .setView(Chart.BAR);
  Growth.getColor().setBackground(color(#A0DB7E, 50));
  Growth.addDataSet("Growth_level");
  Growth.setColors("Growth_level", color(255,80));
  Growth.setData("Growth_level", new float[1]);
  Growth.setStrokeWeight(1);


  ArrayList <Slider> sls = new ArrayList<Slider>(); 
  ArrayList <Toggle> tog = new ArrayList<Toggle>(); 

  //buttons

  tog.add(controlP5.addToggle("swarm", Swarmingonoff, 10, 250, 15, 15).setLabel("Swarming on/off"));
  tog.add(controlP5.addToggle("showTrails", showTrails, 10, 400, 15, 15).setLabel("show Trails"));
  tog.add(controlP5.addToggle("stigmergy", stigmergy, 10, 10, 15, 15).setLabel("stigmergy"));
  tog.add(controlP5.addToggle("showDir", showDir, 80, 400, 15, 15).setLabel("Direction"));
  tog.add(controlP5.addToggle("attract", attract, 10, 190, 15, 15).setLabel("Attract"));
  tog.add(controlP5.addToggle("generate", generate, 10, 350, 15, 15).setLabel("Generate volumes!"));
  tog.add(controlP5.addToggle("show_distance", show_distance, 190, 100, 15, 15).setLabel("Show"));
  tog.add(controlP5.addToggle("objexport", objexport, 80, 440, 15, 15).setLabel("export OBJ"));
  tog.add(controlP5.addToggle("record", record, 10, 440, 15, 15).setLabel("export PDF"));


/////////////////////////////////////////////DYNAMICS CONTROLS/////////////////////////////////////////////////////  

  //sliders
  sls.add(controlP5.addSlider("factor", -4, 4, 10, 220, 100, 10 ).setLabel("Path following factor"));
  sls.add(controlP5.addSlider("approach", 100, 1000, 10, 380, 100, 10).setLabel("accessible distance"));
  sls.add(controlP5.addSlider("scatter", 1, 15, 10, 40, 100, 10).setLabel("scatter"));
  sls.add(controlP5.addSlider("stigS", 0, 2, 10, 160, 100, 10).setLabel("stigmergy strength"));
  sls.add(controlP5.addSlider("decay", 0.75, 2, 10, 60, 100, 10).setLabel("decay"));
  sls.add(controlP5.addSlider("nSamples", 5, 255, 10, 80, 100, 10).setLabel("nsamples"));
  sls.add(controlP5.addSlider("att_distance", 100, 500, 10, 100, 100, 10).setLabel("att_distance"));
  sls.add(controlP5.addSlider("att_angle", 1.4, 3.12, 10, 120, 100, 10).setLabel("att_angle"));  
  sls.add(controlP5.addSlider("att_factor", 0.1, 1, 10, 140, 100, 10).setLabel("att_factor to buildings"));
  sls.add(controlP5.addSlider("coh", 0, 3, 10, 280, 100, 10).setLabel("cohesion"));
  sls.add(controlP5.addSlider("ali", 0, 3, 10, 300, 100, 10).setLabel("alignment"));
  sls.add(controlP5.addSlider("sep", 0, 3, 10, 320, 100, 10).setLabel("SEPARATION"));
  

  //user defined vectros - initial positions for x and y -1645, -1508
    sls.add(controlP5.addSlider("ax", -1645, 1645, 250, 10, 100, 10 ).setLabel("px 1"));
    sls.add(controlP5.addSlider("bx", -1645, 1645, 250, 30, 100, 10).setLabel("px 2"));
    sls.add(controlP5.addSlider("cx", -1645, 1645, 250, 50, 100, 10 ).setLabel("px 3"));
    sls.add(controlP5.addSlider("dx", -1645, 1645, 250, 70, 100, 10 ).setLabel("px 4"));
    sls.add(controlP5.addSlider("ex", -1645, 1645, 250, 90, 100, 10).setLabel("px 5"));
    sls.add(controlP5.addSlider("fx", -1645, 1645, 250, 110, 100, 10 ).setLabel("px 6"));
    sls.add(controlP5.addSlider("gx", -1645, 1645, 250, 130, 100, 10).setLabel("px 7"));
    sls.add(controlP5.addSlider("hx", -1645, 1645, 250, 150, 100, 10 ).setLabel("px 8"));
    
    sls.add(controlP5.addSlider("ay", -1508, 1508, 400, 10, 100, 10 ).setLabel("py 1"));
    sls.add(controlP5.addSlider("by", -1508, 1508, 400, 30, 100, 10).setLabel("py 2"));
    sls.add(controlP5.addSlider("cy", -1508, 1508, 400, 50, 100, 10).setLabel("py 3"));
    sls.add(controlP5.addSlider("dy", -1508, 1508, 400, 70, 100, 10).setLabel("py 4"));
    sls.add(controlP5.addSlider("ey", -1508, 1508, 400, 90, 100, 10).setLabel("py 5"));
    sls.add(controlP5.addSlider("fy", -1508, 1508, 400, 110, 100, 10).setLabel("py 6"));
    sls.add(controlP5.addSlider("gy", -1508, 1508, 400, 130, 100, 10).setLabel("py 7"));
    sls.add(controlP5.addSlider("hy", -1508, 1508, 400, 150, 100, 10).setLabel("py 8"));
    
    
  //levels of importance - weights level for each position
  
  sls.add(controlP5.addSlider("pop_1", 10, 40, 550, 10, 50, 10 ).setLabel("weights level p1"));
  sls.add(controlP5.addSlider("pop_2", 20, 60, 550, 30, 50, 10 ).setLabel("weights level p2"));
  sls.add(controlP5.addSlider("pop_3", 20, 70, 550, 50, 50, 10 ).setLabel("weights level p3"));
  sls.add(controlP5.addSlider("pop_4", 30, 80, 550, 70, 50, 10 ).setLabel("weights level p4"));
  sls.add(controlP5.addSlider("pop_5", 30, 90, 550, 90, 50, 10 ).setLabel("weights level p5"));
  sls.add(controlP5.addSlider("pop_6", 40, 100, 550, 110, 50, 10).setLabel("weights level p6"));
  sls.add(controlP5.addSlider("pop_7", 40, 100, 550, 130, 50, 10 ).setLabel("weights level p7"));
  sls.add(controlP5.addSlider("pop_8", 50, 100, 550, 150, 50, 10 ).setLabel("weights level p8"));

                  


    
  
  

 //menu group

  for ( int i=0; i< sls.size (); i++) {
    Slider s = sls.get(i);
    s.setGroup(ctrl);
    //s.setId(i);
  }

  for ( int i=0; i< tog.size (); i++) {
    Toggle t = tog.get(i);
    t.setGroup(ctrl);
    //t.setId(i);
  }
}

//draw gui
public void gui() {
  campeasy.beginHUD();  
  currCameraMatrix = new PMatrix3D(p3d.camera);

  //camera();
  controlP5.draw(); //draw GUI!




  float d = (float)campeasy.getDistance(); 
  float[] pos = campeasy.getLookAt(); 
  String camPos = "Camera position: x."+round(pos[0])+" | y."+round(pos[1])+" | z."+round(pos[2]);

  textSize(11);
  fill(230);
  area();
  textAlign(RIGHT);
  text( "Frame count | " +frameCount+ " | @ Frame Rate | " +round(frameRate)+ "|", width-20, height-20);
  text("Camera current distance: "+ round(d), width-20, height-40);
  text(camPos, width-20, height-60);
  text("Camera Mouse controls:", width-20, height-80);
  text("Left - orbit | middle - drag | right/wheel - zoom", width-20, height-100);
  text("Display statistics:", width-20, height-120);


  textAlign(LEFT);
  text("Press keys:", 10, height-230);
  text("Save Video sequence [V]", 10, height-200);
  text("Private activities [1] ", 10, height-180);
  text("Public activities  [2] ", 10, height-160);
  text("Squares | parks  [3] ", 10, height-140);
  text("Buildings 2D  [B] ", 10, height-120);
  text("Roads  [W] ", 10, height-100);
  text("Add agents!  [A] ", 10, height-80);
  text("Add top-down volumes![T]", 10, height-60);
  // text("Add Volume by hand [T][C][Q] ", 10, 670);
  text("Save Frame JPG [F] ", 10, height-40);
  text("Reset simulation [R] ", 10, height-20);


  p3d.camera = currCameraMatrix;
 
  campeasy.endHUD();
 controlP5.setAutoDraw(false);
}
void saveVideoFrame() {

  saveFrame(dataPath(this.getClass().getName()+"_video10/"+this.getClass().getName()+"_#####.jpg"));
  println("video recording");
}

void area() { 

  //calculate built area of private activities
  int sum_area =(map.cell_grid.size())*100;

  //calculate built area of public activities-culture
  int sum_area_c =(map.cell_c_grid.size())*100;

  //calculate built area of squares/parks
  int sum_area_sq =(map.cell_sq_grid.size())*100;
  float summ = sum_area+sum_area_c+sum_area_sq;
  float whole = 2893599;

  //calculate area ratio
  float area_ratio1 = sum_area / whole;
  float area_ratio2 = sum_area_c / whole;
  float area_ratio3 = sum_area_sq / whole;
  float area_ratio = summ / whole; //sqm of whole lay-out


  String ratio= nf(area_ratio, 0, 3);

  textSize(11);
  fill(230);
  textAlign(RIGHT, TOP);

  text("Built private area / sqm : " +sum_area, width-20, height-750);
  text("Built public area / sqm : " +sum_area_c, width-20, height-730);
  text("Built public parks and squares area / sqm : " +sum_area_sq, width-20, height-710);
  text("Total built area / sqm : " +summ, width-20, height-690);
  text("Area ratio : " +ratio, width-20, height-670);

  myChart.unshift("Area Ratio", area_ratio1);
  myChart2.unshift("Area Ratio C", area_ratio2);
  myChart3.unshift("Area Ratio SQ", area_ratio3);
  Growth.unshift("Growth_level", area_ratio);

  String ratio1= nf(area_ratio1, 0, 2);
  String ratio2= nf(area_ratio2, 0, 2);
  String ratio3= nf(area_ratio3, 0, 2);


  textSize(9.5);
  text(ratio1, width-90, height-550);
  text(ratio2, width-60, height-550);
  text(ratio3, width-25, height-550);
  text(ratio, width- 84, height-420);
  text("Urban Graininess", width-20, height-540);
  text("Density",  width-48, height-408);
  textSize(11);
  
}


//  ________________________________ ControlP5 in GUI FUNCTIONS

void checkOverlap() { // useful when interface is overlayed on main window - not used with external panel 

  // IMPORTANT!!!!///////////////////////////////////////////////
  // avoid rotation by mouse drag when using sliders of ControlP5
  //
  if (controlP5.isMouseOver()) {  // if mouse is over controllers
    campeasy.setActive(false);               // disable camera mouse controls
  } else {                                // otherwise....
    campeasy.setActive(true);                // ...way to go!
  }
}