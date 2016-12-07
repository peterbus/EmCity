class Agent extends Ple_Agent {
  /////////////////////////////////////////////////////////////////////////////////////////////////////
  // FIELD
  /////////////////////////////////////////////////////////////////////////////////////////////////////
  int participants;
  boolean is_active;
  int counter;


  Vec3D coming_loc;
  Vec3D target_c;

  /////////////////////////////////////////////////////////////////////////////////////////////////////
  // CONSTRUCTOR
  /////////////////////////////////////////////////////////////////////////////////////////////////////
  Agent(PApplet _p5, Vec3D _loc) {
    super(_p5, _loc);
    this.participants = 500;
    this.is_active = true;
    this.counter=0;

    this.coming_loc = null;

  }

  /////////////////////////////////////////////////////////////////////////////////////////////////////
  // METHODS
  /////////////////////////////////////////////////////////////////////////////////////////////////////
  //ADD VOLUME
  void addVolume(Map map) {
    int typ_count = map.typologies.size();
    //get typology
    Typology typology = map.typologies.get((int)(random(0, typ_count-1)));//why random??
    //create new cluster (cells) on agent position

    if (counter>=approach) typology.createVolume(this.loc.x, this.loc.y, map); //condition declaration of the approach distance
    if (key == 't' || key == 'T') typology.createVolume(this.loc.x, this.loc.y, map);


    // }
  }  

  //ADD CULTURE VOLUME
  void addVolume_c(Map map) {
    int typ_count = map.typologies.size();
    //get typology
    Typology typology = map.typologies.get((int)(random(0, typ_count-1)));//why random?? 


    //create new cluster (cells) on agent position
    if (counter>=approach) typology.createVolume_c(this.loc.x, this.loc.y, map); //creates cell volume on agent in range of approach distance
    if (key == 'c' || key == 'C') typology.createVolume_c(this.loc.x, this.loc.y, map);
  } 

  //ADD SQUARE VOLUME
  void addVolume_sq(Map map) {
    int typ_count = map.typologies.size();
    //get typology
    Typology typology = map.typologies.get((int)(random(0, typ_count-1)));//why random?? 


    //create new cluster (cells) on agent position
    if (counter>=approach) typology.createVolume_sq(this.loc.x, this.loc.y, this.loc.z, map); //creates cell volume on agent in range of approach distance
    if (key == 'q' || key == 'Q') typology.createVolume_sq(this.loc.x, this.loc.y,this.loc.z, map);
  }   

  //ATTRACTION

  void attraction(float max_distance, float max_angle, float attraction_factor) {

    Map map = Map.getGrid();
    for (int i = 0; i < map.clusters.size (); i ++)
    {
      if (map.clusters.get(i).attraction)// && frameCount > 40) //Can start without attraction
      {
        Vec3D target = new Vec3D(map.clusters.get(i).attractor.x, map.clusters.get(i).attractor.y, 0);
        Vec3D direction =  target.sub(this.loc);
        float orientation_angle = direction.angleBetween(this.vel, true);
        //      println("orientation is: " +orientation_angle);
        distance = target.distanceTo(this.loc);
        if (distance < max_distance && orientation_angle < max_angle) //TODO variables (distance, angle) limits
        {
          this.seek(target, (max_distance - distance)*attraction_factor); //factor based on distance to target, coefficient smooths rotation
          
          if(show_distance){
          noStroke();
          fill(#E8C365);
          ellipse(this.loc.x, this.loc.y, distance, distance);
          }
          
        }



        if (generate) {
      //    if (counter>=approach) { //approach distance condition
            addVolume = true;
       //   counter=0;
      //   }
        }
      }
    }
  }



  //ATTRACTION TO CULTURE ACTIVITY
  void attraction_c(float max_distance_c, float max_angle_c, float attraction_factor_c) {

    Map map = Map.getGrid();
    for (int i = 0; i < map.clusters_c.size (); i ++)
    {
      if (map.clusters_c.get(i).attraction_c)// && frameCount > 40) //Can start without attraction
      {
        Vec3D target_c = new Vec3D(map.clusters_c.get(i).attractor_c.x, map.clusters_c.get(i).attractor_c.y, 0);
        Vec3D direction_c =  target_c.sub(this.loc);
        float orientation_angle_c = direction_c.angleBetween(this.vel, true);
        //      println("orientation is: " +orientation_angle);
        float distance_c = target_c.distanceTo(this.loc);
        if (distance_c < max_distance_c && orientation_angle_c < max_angle_c) //TODO variables (distance, angle) limits
        {
          this.seek(target_c, (max_distance_c - distance_c)*attraction_factor_c); //factor based on distance to target, coefficient smooths rotation
        }


        if (generate) {
          //  if (counter>=10) { //approach distance condition after reaching the first step
          addVolume_c = true;
          counter=0;
          //   }
        }
      }
    }
  }


  //ATTRACTION TO SQUARE ACTIVITY
  void attraction_sq(float max_distance_sq, float max_angle_sq, float attraction_factor_sq) {

    Map map = Map.getGrid();
    for (int i = 0; i < map.clusters_sq.size (); i ++)
    {
      if (map.clusters_sq.get(i).attraction_sq)// && frameCount > 40) //Can start without attraction
      {
        Vec3D target_sq = new Vec3D(map.clusters_sq.get(i).attractor_sq.x, map.clusters_sq.get(i).attractor_sq.y, 0);
        Vec3D direction_sq =  target_sq.sub(this.loc);
        float orientation_angle_sq = direction_sq.angleBetween(this.vel, true);
        //      println("orientation is: " +orientation_angle);
        float distance_sq = target_sq.distanceTo(this.loc);
        if (distance_sq < max_distance_sq && orientation_angle_sq < max_angle_sq) //TODO variables (distance, angle) limits
        {
          this.seek(target_sq, (max_distance_sq - distance_sq)*attraction_factor_sq); //factor based on distance to target, coefficient smooths rotation
        }


        if (generate) {
          //  if (counter>=10) { //approach distance condition after reaching the first step
          addVolume_sq = true;
          counter=0;
          //   }
        }
      }
    }
  }

  //UPDATE NORMALIZED + INTERACT(test coming position)
  void interacting_update(boolean normalized) {
    // Update velocity
    vel.addSelf(acc);
    counter++;
    // println(counter);//only test

    // Limit speed
    vel.limit(maxspeed);

    // Test coming position
    coming_loc = loc.add(vel);
    Map.getGrid().Interact(this, true);
    Map.getGrid().Interact_c(this, true);
    Map.getGrid().Interact_sq(this, true);

    if (normalized)
      vel.normalize();


    loc.addSelf(vel);
    loc.addSelf(vel);
    // Reset accelertion to 0 each cycle
    acc.clear();
  }


  //COLLISION - change direction
  void colision() {

    this.vel.x += random(-10, 10);
    this.vel.y += random(-10, 10);
    counter=0;


    ///this.vel = this.vel.normalize();
    //TODO test new position until finds empty cell - correct direction (loc+vel to key -> vel)
  }
}