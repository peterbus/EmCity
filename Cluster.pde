import java.util.Set;
import java.util.Map;

public class Cluster
{
  /////////////////////////////////////////////////////////////////////////////////////////////////////
  // FIELD
  /////////////////////////////////////////////////////////////////////////////////////////////////////
  ArrayList<Cell> cells;


  PVector attractor; //centroid - use TOXI Vec3D?

  int capacity;

  int occupation;
  int id; //not necessary (better orientation)
  boolean id_preview = false;
  boolean attraction;




  //TODO cluster_type = existing structure or extension
  //TODO activity_type 


  /////////////////////////////////////////////////////////////////////////////////////////////////////
  // CONSTRUCTOR
  /////////////////////////////////////////////////////////////////////////////////////////////////////
  Cluster(ArrayList<Cell> cells, int id)
  {
    this.id = id;
    this.cells = cells;
    this.occupation = 0;



    initCluster(); //getAttraction and clusterCapacity;

  }
  /////////////////////////////////////////////////////////////////////////////////////////////////////
  // METHODS
  /////////////////////////////////////////////////////////////////////////////////////////////////////
  private void initCluster()
  {
    this.capacity = 0;


    int sum_x = 0;
    int sum_y = 0;






     //amount of cells in each cluster
     int count = cells.size();


    //loop for each cell in cluster
    for (int i = 0; i < count; i++)
    {
      // sum of x, y positions for centroid calculation
      sum_x += cells.get(i).x;
      sum_y += cells.get(i).y;

      // increase cluster capacity
      this.capacity += cells.get(i).capacity;

    }

    // centroid calculation - attraction point
    this.attractor = new PVector(sum_x/count, sum_y/count);
    this.attraction = true;

  }   
  /////////////////////////////////////////////////////////////////////////////////////////////////////
  void Draw()
  {
    if (attractor == null)
      return;
    //Draw circle as attractor if..
    if (attraction)
    {
      pushMatrix();
      translate(0, 0, -0.2);
      fill(#FFC67C);
      ellipse(attractor.x, attractor.y, 7, 7);
      popMatrix();

    }
    //Draw cluster ID
    if (id_preview)
    {
      textSize(10);
      fill(255);
      text("id: "+id, attractor.x, attractor.y, cells.get(0).capacity+0.5);
    }
  }

  /////////////////////////////////////////////////////////////////////////////////////////////////////
  void AgentInteraction(Agent agent)
  {
;

    // if cluster is not fully used yet
    if (!isFull())
    {
      // colonize cluster's cells
      int rest_participants = Colonize(agent.participants);

     // println("cluster_"+ id +": colonization (rest of agents: " + rest +")");

      if (rest_participants > 0)
      {
        //println("cluster_"+ id +": agent splitting (new agent value is "+rest+")");
        //agent -= rest;
        this.occupation =  capacity;
        this.attraction = false;
        agent.participants = rest_participants;
  
      } else
      {
        // increase cluster occupation
        this.occupation += agent.participants;
        agent.participants = 0;
        agent.is_active = false;
           

      }
    } else
    {
      //println("cluster_"+ id +": obstacle (cells of cluster are obstacles for agents)");
      agent.colision();
      agent.attraction_c(att_distance, att_angle, att_factor); //attraction to culture activities
      agent.attraction_sq(att_distance, att_angle, att_factor); //attraction to square-park activities
  
    }
  }
  /////////////////////////////////////////////////////////////////////////////////////////////////////
  int Colonize(int colonize_by)
  {
    int rest = colonize_by;   
    for (int i = 0; i < cells.size (); i++)
    {
      rest = cells.get(i).Colonize(rest);
      if (rest < 0)
        break;
        

    }
    return rest;
    
  }
  /////////////////////////////////////////////////////////////////////////////////////////////////////
  boolean isFull()
  {
    return occupation >= capacity;
  }
  ////////////////////////////////////////////////////////////////////////////////////////
  void Empty()
  {
    for (int i = 0; i < cells.size (); i++)
    {
      cells.get(i).ResetCapacity();
    }
    this.occupation = 0;
    this.attraction = true;
  }
  /////////////////////////////////////////////////////////////////////////////////////////////////////
  void Fill()
  {
    //fill empty cells gradually (if empty add agent energy until run out of it)  
    for (int i = 0; i < cells.size (); i++)
    {
      //if cell is not full, colonize it
      cells.get(i).FillCapacity();
    }
    this.occupation = capacity;
    this.attraction = false;
    
    //occupancy ratio (if capcaity is full - ratio 1:1 - remove attraction)
    //if existing structure > and capacity is fulfilled > create new extended cluster
  }
  /////////////////////////////////////////////////////////////////////////////////////////////////////
}