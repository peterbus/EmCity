
/*
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 EmCity: case study AYE Singapore: AGENT-BASED SIMULATION MODEL OF COLONIAL GROWTH 12/2016
 Update 2016: Tanjong Pagar simulation model with interactive inputs
 
 Concept of simulation, partial methods programming, GUI, Path following/Attraction, Roads, Buildings2D, editing Agent Class  - (c) Peter Bus, MOLAB, FA CTU Prague, ETH Zurich 
 
 Programming Cells classes, Transcription, Clusters classes, Map and Typology class, editing Agent Class - (c) Lukas Kurilla, MOLAB, FA CTU Prague
 
 Stigmergy algorithm and Field2D class based on Stigmergy2D sketch by (c) Alessandro Zomparelli and (c) Alessio Eriolli, Co-de-iT
 and Pheromonics Processing workshop Prague 2014 organized by VSUP/RecodeNature.org by Martin Gsandtner and tutored by Alessio Eriolli (Co-de-iT), 06/2014
 Editing and adaptation by (c) Dr. Peter Bus, Lukas Kurilla, ETH Zurich, MOLAB, FA CTU Prague
 
 Plethora library by (c) Jose Sanchez (http://www.plethora-project.com/Plethora-0.3.0/index.html)
 
 
 contact: 
 
 Dr. Peter Bus
 Chair of Information Architecture
 DARCH ETH Zurich
 bus@arch.ethz.ch
 http://archa3d.com/

 (c)2011-2016
 
 //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 */
 
 
import hypermedia.net.*;
import nervoussystem.obj.*;
import plethora.core.*;
import toxi.geom.*;
import processing.dxf.*;
import processing.pdf.*;
import toxi.processing.*;
import peasy.*;
/////////////////////////////////////////////////////////////////////////////////////////////////////
// PUBLIC FIELD
/////////////////////////////////////////////////////////////////////////////////////////////////////
public PMatrix3D currCameraMatrix;
public PGraphics3D p3d; 
public PeasyCam campeasy;
public ControlP5 controlP5;
public Map map;
public Chart myChart;
public Chart myChart2;
public Chart myChart3;
public Chart Growth;



ArrayList<Agent> agents;
ArrayList<Ple_Agent> agents_ple;
//int pop = 10; //80 agents = 10*8
boolean addVolume = false;
boolean addVolume_c = false;
boolean addVolume_sq = false;
static final int cell_size_b = 10; 
static final int cell_size_park = 12; 
boolean showPheromone = true; // show pheromone path
float att_distance = 100;
float att_angle = 1.4;
float att_factor = 0.1;
boolean stigmergy = true;
boolean showTrails= true;
boolean attract=false;
boolean collision;
boolean record=false;
boolean showDir= true; 
boolean generate=true; 
boolean Buildings=true;
boolean video = false;
boolean mapdraw=true;
boolean mapdrawc=true;
boolean mapdrawsq=true;
boolean reset_button=false;

public boolean Swarmingonoff=false;


boolean objexport=false;

float coh = 1.5;
float ali = 0.5;
float sep = 1.5;

boolean swarm=false;
boolean show_distance=false;
float factor=3.5;
int res=0;
int iterT=1;
float approach=800;
float distant;
float distance;
Spline3D sp_path;
PVector GHpoints[] = new PVector[1941];
UDP udps;  // define the UDP object;

//floats for userd-defined initial position locations
float ax=-987,bx=1381,cx=158,dx=576,ex=-1020,fx=460,gx=-131,hx=1283,ay=-180.95,by=0,cy=845,dy=-332,ey=596,fy=392,gy=-289,hy=-482;

//levels of importance based on agent population for each point
int pop_1=10;
int pop_2=20;
int pop_3=25;
int pop_4=30;
int pop_5=30;
int pop_6=40;
int pop_7=45;
int pop_8=50;


/////////////////////////////////////////////////////////////////////////////////////////////////////
// METHODS
/////////////////////////////////////////////////////////////////////////////////////////////////////
void setup() {

  smooth(4);
  size(1200, 800, P3D);
  //fullScreen();
   frameRate(50);
   //size(720, 760, P3D);
 // size(4096, 2160, P3D); //4K resolution
  //glLoadIdentity
  p3d = (PGraphics3D)g;
  campeasy = new PeasyCam(this, 3200);
  campeasy.lookAt(0, 0, 0);
 campeasy.setResetOnDoubleClick(false);
  campeasy.setMinimumDistance(100);
  campeasy.setMaximumDistance(3000);

  //colorMode(HSB, 255);

  map = Map.getGrid();
  ReadClusters("data/clusters.txt", cell_size_b, map);//FIXME processing IDE problems with static class Map to use readClusters as Map method
  ReadCulture_Clusters("data/culture_clusters.txt", cell_size_b, map);//mixed-used function
  ReadSquare_Clusters("data/square_clusters.txt", cell_size_park, map);
  ReadTypology("data/typologies.txt", map);
  //println("map consist of "+ map.clusters.size() +" clusters.");

  agents = new ArrayList<Agent>();

  
    for (int i = 0; i < pop_1; i++) {
     Agent agent = new Agent(this, new Vec3D(ax, ay, 0));
     agent.setVelocity(new Vec3D (random(-1, 0.5), random(-1, 0.5), 0));//to do  - the velocity can be changed and can contribute to the weights as well
     agents.add(agent);
  } 
      for (int i = 0; i < pop_2; i++) {
     Agent agent2 = new Agent(this, new Vec3D(bx, by, 0));
     agent2.setVelocity(new Vec3D (random(-1, 0.5), random(-1, 0.5), 0));
     agents.add(agent2);
  }
      for (int i = 0; i < pop_3; i++) {
     Agent agent3 = new Agent(this, new Vec3D(cx, cy, 0));
     agent3.setVelocity(new Vec3D (random(-1, 0.5), random(-1, 0.5), 0));
     agents.add(agent3);
  }
      for (int i = 0; i < pop_4; i++) {
     Agent agent4 = new Agent(this, new Vec3D(dx, dy, 0));
     agent4.setVelocity(new Vec3D (random(-1, 0.5), random(-1, 0.5), 0));
     agents.add(agent4);
  }
      for (int i = 0; i < pop_5; i++) {
     Agent agent5 = new Agent(this, new Vec3D(ex, ey, 0));
     agent5.setVelocity(new Vec3D (random(-1, 0.5), random(-1, 0.5), 0));
     agents.add(agent5);
  }
      for (int i = 0; i < pop_6; i++) {
     Agent agent6 = new Agent(this, new Vec3D(fx, fy, 0));
     agent6.setVelocity(new Vec3D (random(-1, 0.5), random(-1, 0.5), 0));
     agents.add(agent6);
  }
      for (int i = 0; i < pop_7; i++) {
     Agent agent7 = new Agent(this, new Vec3D(gx, gy, 0));
     agent7.setVelocity(new Vec3D (random(-1, 0.5), random(-1, 0.5), 0));
     agents.add(agent7);
  }
      for (int i = 0; i < pop_8; i++) {
     Agent agent8 = new Agent(this, new Vec3D(hx, hy, 0));
     agent8.setVelocity(new Vec3D (random(-1, 0.5), random(-1, 0.5), 0));
     agents.add(agent8);
  }

  
  agents_ple = (ArrayList<Ple_Agent>) ((ArrayList<?>) agents);
  path_following();
  //roads();
  buildings();
  initGUI();
  
 /*   udps = new UDP( this, 6999);
    udps.log( true ); */
    //dataList = new ArrayList();
   
}
/////////////////////////////////////////////////////////////////////////////////////////////////////

void draw()
{
  checkOverlap();


  if (objexport) {
    beginRaw("nervoussystem.obj.OBJExport", "filename#####.obj");
  }


  if (record) {
    beginRaw(PDF, "filename#####.pdf");
  }

  img.loadPixels();

  background(160);


  strokeWeight(1);
  noFill();
  rect(-1645, -1508, 3291, 3016); //boundaries
  ellipse(0, 0, 50, 50);
  points_Draw();
  

  if (Buildings)drawBuildings();

  if (mapdraw) {
    map.Draw();//draw habitation activity
  }
  if (mapdrawc) {
    map.Draw_c();//draw culture clusters - culture activity
  }
  if (mapdrawsq) {
    map.Draw_sq();//draw square clusters - squares and parks
  }


  for (Agent agent : agents) {
   if (!agent.is_active)
      continue;


    if   (swarm) {
      agent.flock(agents_ple, 80F, 65F, 35F, coh, ali, sep); //zakladne "ozivenie" agentov podla formy prikazu v Plethore. Cisla udavaju miery hodnot viz vyssie.
    } else {

      agent.wander2D(5, 0, PI);
    }

    //wander: inputs: circleSize, distance, variation in radians
    // agent.wander2D(5, 0, PI);
    //separation
    agent.separationCall(agents_ple, 10F, 10F);
    //define the boundries of the sagentce as bounce
   // agent.bounceSpace(970,887.5, 0); //TODO get boundaries from map class (agents don't return)
    agent.bounceSpace(1575,1710, 0);
    agent.dropTrail(5, 2000);
    


    //update the tail info every frame (1)
    //    agent.updateTail(1);
    //    //display the tail interpolating 2 sets of values:
    //    //R,G,B,ALPHA,SIZE - R,G,B,ALPHA,SIZE
   //     agent.displayTailPoints(0, 0, 0, 0, 1, 0, 0, 0, 255, 1);
    //    //set the max speed of movement:
    //    //agent.setMaxspeed(2);
    //    //agent.setMaxforce(0.05);

    //attraction to clusters
    agent.attraction(att_distance, att_angle, att_factor);
    // agent.attraction_c(att_distance, att_angle, att_factor);
    //  agent.attraction_sq(att_distance, att_angle, att_factor);

    //STIGMERGY  
    if (stigmergy) {   

      //Vec3D fVec = new Vec3D(cos(ang)*fStrength, sin(ang)*fStrength, 0);
      agent.vel.normalize(); //unify actual velocity vector for other calculation
      Vec3D futLoc = agent.futureLoc(scatter); //scatter as distance of future localization
      Vec3D bestLoc = new Vec3D(); //default position


      //FIND MAX VALUE AROUND
      float val = -1; //default min value
      for (int i = 0; i < nSamples; i++) {    
        Vec3D v = futLoc.add(new Vec3D(random(-scatter, scatter), random(-scatter, scatter), 0));//scatter = distance radius
       float sampleVal = field.readValue(v);
      //float sampleVal = 10000000;
        if (sampleVal > val) {
          val = sampleVal;
          bestLoc = v;
        }
      }

      Vec3D stigVec = bestLoc.sub(agent.loc).normalize().scale(stigS);//stigmergic vector with scale
      agent.vel.addSelf(stigVec);//orient agent by stigmegic vector (add velocity)
      agent.vel.normalize();//to do a constant speed

      agent.setMaxspeed(3);

      //spread
      field.addValue(agent.loc, 80);//spread pheromone

      //agent.update(); //move agent to new position

      //update agents location based on agentst calculations
      agent.interacting_update(true); //normalized velocity vector (sum of vel + acc)(no acceleration)
    }

    if (showDir) {

      //calculate future location of the agent

      Vec3D fLoc = agent.futureLoc(15); //future location
      stroke(255, 0, 0, 90); //r,g,b, alpha
      strokeWeight(1);

      agent.vLine(fLoc, agent.loc);
    }


    if (attract) {// path following attraction
      //atraction to path spline
      Vec3D fLoc = agent.futureLoc(6);
      float m = map(width, 0, width, -5, 0); //agenti behaju sem a tam po spline
      Vec3D cns = agent.closestNormalandDirectionToSpline(sp_path, fLoc, m);
      agent.arrive(cns);
      agent.seek(cns, factor);
    }

    if (showTrails) {

      //vykreslenie chvosta ako linka - trajektoria

      stroke(random(255, 0), 0, 0, 90);
      strokeWeight(1);
      agent.drawTrail(200);
    }

    //update agents location based on agentst calculations
    agent.interacting_update(true); //normalized velocity vector (sum of vel + acc)(no acceleration)

    //Add new volume from stored typologies
    if (addVolume) {
      agent.addVolume(map);
      //addVolume = false;
    }

    if (addVolume_c) {
      agent.addVolume_c(map);

      //addVolume = false;
    }

    if (addVolume_sq) {
      agent.addVolume_sq(map);

      //addVolume = false;
    }
  //  agent.update();
    
  /*  String locList = ""; //data stored in the list - as a string
    
    
    for (int i=0; i<pop;i++){
      Agent n = agents.get(i);
      locList= locList+String.valueOf(-n.loc.x)+","+String.valueOf(n.loc.y)+";";
     
    }
    //String message  = agent.loc.x + "," + agent.loc.y;  // the message to send
    String message = locList;
 
    String ip       = "127.0.0.1";  // the remote IP address
    int port        = 7001;    // the destination port
    print(message);
    udps.send( message, ip, port );

                  

// print the result
//println( "receive: \""+message+"\" from "+ip+" on port "+port );*/
  

    //Display the location of the agent with a point
    strokeWeight(3);//agent.participants*0.1);
    stroke(255);
 
    agent.displayPoint();
    //Display the direction of the agent with a line
    strokeWeight(1);
    stroke(100, 90);
    //    //Display the direction of the agent with a line
    //    strokeWeight(1);
    //    stroke(100, 90);
    //    agent.displayDir(agent.vel.magnitude()*3);
  }
  if (decay<1)field.decay(decay);
  img.updatePixels();
  if (showPheromone)field.drawField();

  addVolume = false;
  addVolume_c = false;
  addVolume_sq = false;

  /*   if(generate){
   
   if (frameCount==res+iterT*approach||frameCount>res+iterT*approach) { //iteration approaching distance = based on frame_number
   addVolume = true;
   iterT+=1;
   } 
   
   
    /*   Vec3D fLoc1 = agent.futureLoc(5);
   distant = fLoc.distanceTo(agent.loc);
   
   if (distant>180){ //definition of real approach distance
   addVolume = true;
   }
   
   }*/

//draw_roads();
draw_spline();// test ok

  if (objexport) {
    endRaw();
    objexport=!objexport;
  }


  if (record) {
    endRaw();
    record=!record;
  }
  gui();
  if (video) saveVideoFrame();
  
/*  if (frameCount==4000){
    reset();   
  }*/
      
  
}
/////////////////////////////////////////////////////////////////////////////////////////////////////
void reset() {
  frameCount = 0;
  map.Reset();
  ReadClusters("data/clusters.txt", cell_size_b, map);//FIXME processing IDE problems with static class Map to use readClusters as Map method
  ReadCulture_Clusters("data/culture_clusters.txt", cell_size_b, map);
  ReadSquare_Clusters("data/square_clusters.txt", cell_size_park, map);
  ReadTypology("data/typologies.txt", map);
  agents = new ArrayList<Agent>();

  
      for (int i = 0; i < pop_1; i++) {
     Agent agent = new Agent(this, new Vec3D(ax, ay, 0));
     agent.setVelocity(new Vec3D (random(-1, 0.5), random(-1, 0.5), 0));//to do  - the velocity can be changed and can contribute to the weights as well
     agents.add(agent);
         agent.update();
    agent.interacting_update(true);
  } 
      for (int i = 0; i < pop_2; i++) {
     Agent agent2 = new Agent(this, new Vec3D(bx, by, 0));
     agent2.setVelocity(new Vec3D (random(-1, 0.5), random(-1, 0.5), 0));
     agents.add(agent2);
         agent2.update();
    agent2.interacting_update(true);
  }
      for (int i = 0; i < pop_3; i++) {
     Agent agent3 = new Agent(this, new Vec3D(cx, cy, 0));
     agent3.setVelocity(new Vec3D (random(-1, 0.5), random(-1, 0.5), 0));
     agents.add(agent3);
         agent3.update();
    agent3.interacting_update(true);
  }
      for (int i = 0; i < pop_4; i++) {
     Agent agent4 = new Agent(this, new Vec3D(dx, dy, 0));
     agent4.setVelocity(new Vec3D (random(-1, 0.5), random(-1, 0.5), 0));
     agents.add(agent4);
     
         agent4.update();
    agent4.interacting_update(true);
  }
      for (int i = 0; i < pop_5; i++) {
     Agent agent5 = new Agent(this, new Vec3D(ex, ey, 0));
     agent5.setVelocity(new Vec3D (random(-1, 0.5), random(-1, 0.5), 0));
     agents.add(agent5);
         agent5.update();
    agent5.interacting_update(true);
  }
      for (int i = 0; i < pop_6; i++) {
     Agent agent6 = new Agent(this, new Vec3D(fx, fy, 0));
     agent6.setVelocity(new Vec3D (random(-1, 0.5), random(-1, 0.5), 0));
     agents.add(agent6);
         agent6.update();
    agent6.interacting_update(true);
  }
      for (int i = 0; i < pop_7; i++) {
     Agent agent7 = new Agent(this, new Vec3D(gx, gy, 0));
     agent7.setVelocity(new Vec3D (random(-1, 0.5), random(-1, 0.5), 0));
     agents.add(agent7);
         agent7.update();
    agent7.interacting_update(true);
  }
      for (int i = 0; i < pop_8; i++) {
     Agent agent8 = new Agent(this, new Vec3D(hx, hy, 0));
     agent8.setVelocity(new Vec3D (random(-1, 0.5), random(-1, 0.5), 0));
     agents.add(agent8);
         agent8.update();
    agent8.interacting_update(true);
  }
    
  agents_ple = (ArrayList<Ple_Agent>) ((ArrayList<?>) agents);
  path_following();
 // roads();
  buildings();
  initGUI();
  
}

void keyPressed() {

  if (key == 'r' || key == 'R') {
    reset();
  }

  if (key == 't' || key == 'T') {
    addVolume = true;
  }

  if (key == 'c' || key == 'C') {
    addVolume_c = true;
  }

  if (key == 'q' || key == 'Q') {
    addVolume_sq = true;
  }



  if (key=='v') video = !video;
  if (key=='b') Buildings=!Buildings;
  if (key=='1') mapdraw=!mapdraw;
  if (key=='2') mapdrawc=!mapdrawc;
  if (key=='3') mapdrawsq=!mapdrawsq;

  if (key=='p' || key=='P') showPheromone = !showPheromone;

  if (key == 'f' || key == 'F') {
    saveFrame("data/simulation_model-####.jpg");
    println("JPG generated succsessfully");
    record = true;
  }
  if (key=='w' || key == 'W') roads=!roads;

  if (key== 'a' || key == 'A') {


      for (int i = 0; i < pop_1; i++) {
     Agent agent = new Agent(this, new Vec3D(ax, ay, 0));
     agent.setVelocity(new Vec3D (random(-1, 0.5), random(-1, 0.5), 0));//to do  - the velocity can be changed and can contribute to the weights as well
     agents.add(agent);
         agent.update();
    agent.interacting_update(true);
  } 
      for (int i = 0; i < pop_2; i++) {
     Agent agent2 = new Agent(this, new Vec3D(bx, by, 0));
     agent2.setVelocity(new Vec3D (random(-1, 0.5), random(-1, 0.5), 0));
     agents.add(agent2);
         agent2.update();
    agent2.interacting_update(true);
  }
      for (int i = 0; i < pop_3; i++) {
     Agent agent3 = new Agent(this, new Vec3D(cx, cy, 0));
     agent3.setVelocity(new Vec3D (random(-1, 0.5), random(-1, 0.5), 0));
     agents.add(agent3);
         agent3.update();
    agent3.interacting_update(true);
  }
      for (int i = 0; i < pop_4; i++) {
     Agent agent4 = new Agent(this, new Vec3D(dx, dy, 0));
     agent4.setVelocity(new Vec3D (random(-1, 0.5), random(-1, 0.5), 0));
     agents.add(agent4);
     
         agent4.update();
    agent4.interacting_update(true);
  }
      for (int i = 0; i < pop_5; i++) {
     Agent agent5 = new Agent(this, new Vec3D(ex, ey, 0));
     agent5.setVelocity(new Vec3D (random(-1, 0.5), random(-1, 0.5), 0));
     agents.add(agent5);
         agent5.update();
    agent5.interacting_update(true);
  }
      for (int i = 0; i < pop_6; i++) {
     Agent agent6 = new Agent(this, new Vec3D(fx, fy, 0));
     agent6.setVelocity(new Vec3D (random(-1, 0.5), random(-1, 0.5), 0));
     agents.add(agent6);
         agent6.update();
    agent6.interacting_update(true);
  }
      for (int i = 0; i < pop_7; i++) {
     Agent agent7 = new Agent(this, new Vec3D(gx, gy, 0));
     agent7.setVelocity(new Vec3D (random(-1, 0.5), random(-1, 0.5), 0));
     agents.add(agent7);
         agent7.update();
    agent7.interacting_update(true);
  }
      for (int i = 0; i < pop_8; i++) {
     Agent agent8 = new Agent(this, new Vec3D(hx, hy, 0));
     agent8.setVelocity(new Vec3D (random(-1, 0.5), random(-1, 0.5), 0));
     agents.add(agent8);
         agent8.update();
    agent8.interacting_update(true);
  }
     
   //   agent.interacting_update(true);
   // }
  }
}