public class Cluster_sq
{
  /////////////////////////////////////////////////////////////////////////////////////////////////////
  // FIELD
  /////////////////////////////////////////////////////////////////////////////////////////////////////
  ArrayList<Cell_sq> cells_sq;
  PVector attractor_sq; //centroid - use TOXI Vec3D?

  int capacity_sq;
  int occupation_sq;
  int id_sq; //not necessary (better orientation)
  boolean id_preview_sq = false;
  boolean attraction_sq;




  /////////////////////////////////////////////////////////////////////////////////////////////////////
  // CONSTRUCTOR
  /////////////////////////////////////////////////////////////////////////////////////////////////////
  Cluster_sq(ArrayList<Cell_sq> cells_sq, int id_sq)
  {
    this.id_sq = id_sq;
    this.cells_sq = cells_sq;
    this.occupation_sq = 0;

    initCluster_sq(); //getAttraction and clusterCapacity;
  }
  /////////////////////////////////////////////////////////////////////////////////////////////////////
  // METHODS
  /////////////////////////////////////////////////////////////////////////////////////////////////////
  private void initCluster_sq()
  {
    this.capacity_sq = 0;

    int sum_x = 0;
    int sum_y = 0;

    int count = cells_sq.size();
    for (int i = 0; i < count; i++)
    {
      // sum of x, y positions for centroid calculation
      sum_x += cells_sq.get(i).x;
      sum_y += cells_sq.get(i).y;
      // increase cluster capacity
      this.capacity_sq += cells_sq.get(i).capacity_sq;
    }
    // centroid calculation - attraction point
    this.attractor_sq = new PVector(sum_x/count, sum_y/count);
    this.attraction_sq = true;
  }   
  /////////////////////////////////////////////////////////////////////////////////////////////////////
  void Draw_sq()
  {
    if (attractor_sq == null)
      return;
    //Draw cicle as attractor if..
    if (attraction_sq)
    {
      pushMatrix();
      translate(0, 0, -0.2);
      fill(#A2B93A);
      ellipse(attractor_sq.x, attractor_sq.y, 7, 7);
      popMatrix();
    }
    //Draw cluster ID
    if (id_preview_sq)
    {
      textSize(10);
      fill(255);
      text("id: "+id_sq, attractor_sq.x, attractor_sq.y, cells_sq.get(0).capacity_sq+0.5);
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
  void AgentInteraction_sq(Agent agent)
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
        this.occupation_sq =  capacity_sq;
        this.attraction_sq = false;
        agent.participants = rest_participants;
      } else
      {
        // increase cluster occupation
        this.occupation_sq += agent.participants;
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
    for (int i = 0; i < cells_sq.size (); i++)
    {
      rest = cells_sq.get(i).Colonize(rest);
      if (rest < 0)
        break;
    }
    return rest;
  }
  /////////////////////////////////////////////////////////////////////////////////////////////////////
  boolean isFull()
  {
    return occupation_sq >= capacity_sq;
  }
  ////////////////////////////////////////////////////////////////////////////////////////
  void Empty()
  {
    for (int i = 0; i < cells_sq.size (); i++)
    {
      cells_sq.get(i).ResetCapacity_sq();
    }
    this.occupation_sq = 0;
    this.attraction_sq = true;
  }
  /////////////////////////////////////////////////////////////////////////////////////////////////////
  void Fill()
  {
    //fill empty cells gradually (if empty add agwent energy until run out of it)  
    for (int i = 0; i < cells_sq.size (); i++)
    {
      //if cell is not full, colonize it
      cells_sq.get(i).FillCapacity_sq();
    }
    this.occupation_sq = capacity_sq;
    this.attraction_sq = false;
    //occupancy ratio (if capcaity is full - ratio 1:1 - remove attraction)
    //if existing structure > and capacity is fulfilled > create new extened cluster
  }
  /////////////////////////////////////////////////////////////////////////////////////////////////////
}