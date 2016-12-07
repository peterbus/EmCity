import java.util.Iterator;
import java.util.Set;
import java.util.Map;
import java.util.TreeMap;
//import java.io.*;
static class Map
{
  /////////////////////////////////////////////////////////////////////////////////////////////////////
  // STATIC
  /////////////////////////////////////////////////////////////////////////////////////////////////////
  private static Map instance;
  public static Map getGrid(){
    if (instance == null)
      instance = new Map();
    return instance;

    
  }
  
  
  /////////////////////////////////////////////////////////////////////////////////////////////////////
  long KeyGenerator(float x, float y)
  {
    int _x = (int)Math.floor(x*0.1); //0.1 coefficient depends on cell size!!!
    int _y = (int)Math.floor(y*0.1);
    return (((long)_x)<<32)+_y;
  }
  /////////////////////////////////////////////////////////////////////////////////////////////////////
  // FIELD
  /////////////////////////////////////////////////////////////////////////////////////////////////////
 TreeMap<Long, Cell> cell_grid;
 TreeMap<Long, Cell_c> cell_c_grid;
 TreeMap<Long, Cell_sq> cell_sq_grid;
  ArrayList<Cluster> clusters;
  ArrayList<Cluster_c> clusters_c;
  ArrayList<Cluster_sq> clusters_sq;
  ArrayList<Typology> typologies;
  public int sum_area;
  /////////////////////////////////////////////////////////////////////////////////////////////////////
  // CONSTRUCTOR
  /////////////////////////////////////////////////////////////////////////////////////////////////////
  public Map()
  {
    this.cell_grid = new TreeMap<Long, Cell>();
    this.cell_c_grid = new TreeMap<Long, Cell_c>();
    this.cell_sq_grid = new TreeMap<Long, Cell_sq>();
    this.clusters = new ArrayList<Cluster>();
    this.clusters_c = new ArrayList<Cluster_c>();
    this.clusters_sq = new ArrayList<Cluster_sq>();
    this.typologies = new ArrayList<Typology>();
  }
  /////////////////////////////////////////////////////////////////////////////////////////////////////
  // METHODS
  /////////////////////////////////////////////////////////////////////////////////////////////////////
  void AddCell(Cell cell)
  {
    long cell_key = KeyGenerator( cell.x, cell.y);
    cell_grid.put(cell_key, cell); //HACK - hashMap > treeMap   

    
  }
  /////////////////////////////////////////////////////////////////////////////////////////////////////  
  void AddCell_c(Cell_c cell_c)
  {
    long cell_c_key = KeyGenerator( cell_c.x, cell_c.y);
    cell_c_grid.put(cell_c_key, cell_c); //HACK - hashMap > treeMap
    int sum_cells_c = cell_c_grid.size();

  }
  ///////////////////////////////////////////////////////////////////////////////////////////////////// 
  void AddCell_sq(Cell_sq cell_sq)
  {
    long cell_sq_key = KeyGenerator( cell_sq.x, cell_sq.y);
    cell_sq_grid.put(cell_sq_key, cell_sq); //HACK - hashMap > treeMap
    int sum_cells_sq = cell_sq_grid.size();
  }
  ///////////////////////////////////////////////////////////////////////////////////////////////////// 
  void AddClusters(ArrayList<Cluster> cluster_list)
  {
    this.clusters.addAll(cluster_list);


  }
  /////////////////////////////////////////////////////////////////////////////////////////////////////  
  void AddClusters_c(ArrayList<Cluster_c> cluster_c_list)
  {
    this.clusters_c.addAll(cluster_c_list);
   
  }
  ///////////////////////////////////////////////////////////////////////////////////////////////////// 
  void AddClusters_sq(ArrayList<Cluster_sq> cluster_sq_list)
  {
    this.clusters_sq.addAll(cluster_sq_list);
  }
  ///////////////////////////////////////////////////////////////////////////////////////////////////// 
  void AddTypologies(ArrayList<Typology> typology_list)
  {
    this.typologies.addAll(typology_list);

  }

  /////////////////////////////////////////////////////////////////////////////////////////////////////
  void Interact(Agent agent, boolean test_coming_loc)//float x, float y) //long agent_position)
  {
    long a_key;
    if (test_coming_loc)
      a_key = KeyGenerator(agent.coming_loc.x, agent.coming_loc.y);
    else
      a_key = KeyGenerator(agent.loc.x, agent.loc.y);

    //if cell exist on position (key ...)
    if (cell_grid.containsKey(a_key))
    {
      Cell cell = cell_grid.get(a_key);
      //interact with cluster
      clusters.get(cell.cluster_id).AgentInteraction(agent);
    }
  }
  /////////////////////////////////////////////////////////////////////////////////////////////////////
  void Interact_c(Agent agent, boolean test_coming_loc)//float x, float y) //long agent_position)
  {
    long a_key;
    if (test_coming_loc)
      a_key = KeyGenerator(agent.coming_loc.x, agent.coming_loc.y);
    else
      a_key = KeyGenerator(agent.loc.x, agent.loc.y);

    //if cell exist on position (key ...)
    if (cell_c_grid.containsKey(a_key))
    {
      Cell_c cell_c = cell_c_grid.get(a_key);
      //interact with cluster
      clusters_c.get(cell_c.cluster_id_c).AgentInteraction_c(agent);
    }
  }
  /////////////////////////////////////////////////////////////////////////////////////////////////////
  void Interact_sq(Agent agent, boolean test_coming_loc)//float x, float y) //long agent_position)
  {
    long a_key;
    if (test_coming_loc)
      a_key = KeyGenerator(agent.coming_loc.x, agent.coming_loc.y);
    else
      a_key = KeyGenerator(agent.loc.x, agent.loc.y);

    //if cell exist on position (key ...)
    if (cell_sq_grid.containsKey(a_key))
    {
      Cell_sq cell_sq = cell_sq_grid.get(a_key);
      //interact with cluster
      clusters_sq.get(cell_sq.cluster_id_sq).AgentInteraction_sq(agent);
    }
  }

  boolean addNewCell(Cell cell)//HACK with addCell method
  {
    long a_key = KeyGenerator(cell.x, cell.y);
    //if cell already exists
    if (!cell_grid.containsKey(a_key)) { //TODO or if exist cell_grid.get(a_key).update(volume);
      this.cell_grid.put(a_key, cell); 
      return true;
    } else return false;
  }
  /////////////////////////////////////////////////////////////////////////////////////////////////////
  void Draw()
  {
    Iterator<Cell> i = cell_grid.values().iterator();


   
   
    while (i.hasNext ()) {
      i.next().Draw();
    }
    for (int c = 0; c < clusters.size (); c++)
    {
      clusters.get(c).Draw();

    }
   
 

  } 
  /////////////////////////////////////////////////////////////////////////////////////////////////////


  /////////////////////////////////////////////////////////////////////////////////////////////////////
  boolean addNewCell_c(Cell_c cell_c)//HACK with addCell method
  {
    long a_key = KeyGenerator(cell_c.x, cell_c.y);
    //if cell already exists
    if (!cell_c_grid.containsKey(a_key)) { //TODO or if exist cell_c_grid.get(a_key).update(volume);
      this.cell_c_grid.put(a_key, cell_c); 
      return true;
    } else return false;
  }
  /////////////////////////////////////////////////////////////////////////////////////////////////////
  void Draw_c()
  {
    Iterator<Cell_c> i = cell_c_grid.values().iterator();
    

    while (i.hasNext ()) {
      i.next().Draw_c();
      
    }
    for (int c = 0; c < clusters_c.size (); c++)
    {
      clusters_c.get(c).Draw_c();
    }
    for (int q = 0; q < clusters_c.size (); q++)
    {
      clusters_c.get(q).Draw_c();
    }
  } 
  /////////////////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////////////////////////////
  boolean addNewCell_sq(Cell_sq cell_sq)//HACK with addCell method
  {
    long a_key = KeyGenerator(cell_sq.x, cell_sq.y);
    //if cell already exists
    if (!cell_sq_grid.containsKey(a_key)) { //TODO or if exist cell_c_grid.get(a_key).update(volume);
      this.cell_sq_grid.put(a_key, cell_sq); 
      return true;
    } else return false;
  }
  /////////////////////////////////////////////////////////////////////////////////////////////////////
  void Draw_sq()
  {
    Iterator<Cell_sq> i = cell_sq_grid.values().iterator();
    while (i.hasNext ()) {
      i.next().Draw_sq();
    }
    for (int c = 0; c < clusters_sq.size (); c++)
    {
      clusters_sq.get(c).Draw_sq();
    }
    for (int q = 0; q < clusters_sq.size (); q++)
    {
      clusters_sq.get(q).Draw_sq();
    }
  } 
  /////////////////////////////////////////////////////////////////////////////////////////////////////
void Reset()
  {
    this.cell_grid = new TreeMap<Long, Cell>();
    this.clusters = new ArrayList<Cluster>();
    this.typologies = new ArrayList<Typology>();  
    this.cell_c_grid = new TreeMap<Long, Cell_c>();
    this.clusters_c = new ArrayList<Cluster_c>();  
    this.cell_sq_grid = new TreeMap<Long, Cell_sq>();
    this.clusters_sq = new ArrayList<Cluster_sq>();
  }

}