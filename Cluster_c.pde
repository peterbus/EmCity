public class Cluster_c
{
  /////////////////////////////////////////////////////////////////////////////////////////////////////
  // FIELD
  /////////////////////////////////////////////////////////////////////////////////////////////////////
  ArrayList<Cell_c> cells_c;
  PVector attractor_c; //centroid - use TOXI Vec3D?

  int capacity_c;
  int occupation_c;
  int id_c; //not necessary (better orientation)
  boolean id_preview_c = false;
  boolean attraction_c;




  /////////////////////////////////////////////////////////////////////////////////////////////////////
  // CONSTRUCTOR
  /////////////////////////////////////////////////////////////////////////////////////////////////////
  Cluster_c(ArrayList<Cell_c> cells_c, int id_c)
  {
    this.id_c = id_c;
    this.cells_c = cells_c;
    this.occupation_c = 0;

    initCluster_c(); //getAttraction and clusterCapacity;
  }
  /////////////////////////////////////////////////////////////////////////////////////////////////////
  // METHODS
  /////////////////////////////////////////////////////////////////////////////////////////////////////
  private void initCluster_c()
  {
    this.capacity_c = 0;

    int sum_x = 0;
    int sum_y = 0;

    int count = cells_c.size();
    for (int i = 0; i < count; i++)
    {
      // sum of x, y positions for centroid calculation
      sum_x += cells_c.get(i).x;
      sum_y += cells_c.get(i).y;
      // increase cluster capacity
      this.capacity_c += cells_c.get(i).capacity_c;
    }
    // centroid calculation - attraction point
    this.attractor_c = new PVector(sum_x/count, sum_y/count);
    this.attraction_c = true;
  }   
  /////////////////////////////////////////////////////////////////////////////////////////////////////
  void Draw_c()
  {
    if (attractor_c == null)
      return;
    //Draw cicle as attractor if..
    if (attraction_c)
    {
      pushMatrix();
      translate(0, 0, -0.2);
      fill(0, 200, 0);
      ellipse(attractor_c.x, attractor_c.y, 7, 7);
      popMatrix();
    }
    //Draw cluster ID
    if (id_preview_c)
    {
      textSize(10);
      fill(255);
      text("id: "+id_c, attractor_c.x, attractor_c.y, cells_c.get(0).capacity_c+0.5);
    }
  }
  /////////////////////////////////////////////////////////////////////////////////////////////////////
  //  void AddCell(Cell cell)
  //  {
  //    this.cells.add(cell);
  //    // + store values for centroid calculation
  //    this.sum_x += cell.x;
  //    this.sum_y += cell.y;
  //    // increase cluster capacity
  //    this.capacity += cell.capacity;
  //  }
  /////////////////////////////////////////////////////////////////////////////////////////////////////
  void AgentInteraction_c(Agent agent)
  {
    // if claster is not fully used yet
    if (!isFull())
    {
      // colonize cluster's cells
      int rest_participants = Colonize(agent.participants);
      //println("cluster_"+ id +": colonization (rest of agents: " + rest +")");

      if (rest_participants > 0)
      {
        //println("cluster_"+ id +": agent splitting (new agent value is "+rest+")");
        //agent -= rest;
        this.occupation_c =  capacity_c;
        this.attraction_c = false;
        agent.participants = rest_participants;
      } else
      {
        // increase cluster occupation
        this.occupation_c += agent.participants;
        agent.participants = 0;
        agent.is_active = false;
      }
    } else
    {
      //println("cluster_"+ id +": obstacle (cells of cluster are obstacles for agents)");
      agent.colision();
      collision=true;
    }
  }
  /////////////////////////////////////////////////////////////////////////////////////////////////////
  int Colonize(int colonize_by)
  {
    int rest = colonize_by;   
    for (int i = 0; i < cells_c.size (); i++)
    {
      rest = cells_c.get(i).Colonize(rest);
      if (rest < 0)
        break;
    }
    return rest;
  }
  /////////////////////////////////////////////////////////////////////////////////////////////////////
  boolean isFull()
  {
    return occupation_c >= capacity_c;
  }
  ////////////////////////////////////////////////////////////////////////////////////////
  void Empty()
  {
    for (int i = 0; i < cells_c.size (); i++)
    {
      cells_c.get(i).ResetCapacity_c();
    }
    this.occupation_c = 0;
    this.attraction_c = true;
  }
  /////////////////////////////////////////////////////////////////////////////////////////////////////
  void Fill()
  {
    //fill empty cells gradually (if empty add agwent energy until run out of it)  
    for (int i = 0; i < cells_c.size (); i++)
    {
      //if cell is not full, colonize it
      cells_c.get(i).FillCapacity_c();
    }
    this.occupation_c = capacity_c;
    this.attraction_c = false;
    //occupancy ratio (if capcaity is full - ratio 1:1 - remove attraction)
    //if existing structure > and capacity is fulfilled > create new extened cluster
  }
  /////////////////////////////////////////////////////////////////////////////////////////////////////
}