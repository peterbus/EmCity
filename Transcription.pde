void ReadClusters(String path, int cell_size, Map map)
{  
  String txt_clusters[] = loadStrings(path);  
  if (txt_clusters == null) {
    println(path + " file is missing!");
    return;
  }
  // Get clusters from file
  ArrayList<Cluster> cluster_list = new ArrayList<Cluster>(txt_clusters.length);
  for (int i = 0; i< txt_clusters.length; i++) {
    String txt_cells[]= split (txt_clusters[i], " ");
    
   
  //  int sum =0;
    
    //println(txt_cells[0]+" a "+txt_cells[1])
    //Get cluster cells
    ArrayList<Cell> cluster_cells = new ArrayList<Cell>(txt_cells.length/3);
    for (int j = 0; j < txt_cells.length-1; j += 3)
    {
      int x = Integer.parseInt(txt_cells[j]);
      int y = -(Integer.parseInt(txt_cells[j+1]));
      int z = Integer.parseInt(txt_cells[j+2]);
  //    sum += Integer.parseInt(txt_cells[j]);
    
      //println(x +" "+ y +" " + z);


      Cell cell =  new Cell(x, y, z, cell_size, i);
      cluster_cells.add(cell);
      
      //Register cell in map
      map.AddCell(cell);
     

    }
    //Create cluster and store it into a list
    Cluster cluster = new Cluster(cluster_cells, i);
    cluster_list.add(cluster);
   // println(cluster_list.size());//amount of clusters
  }

  map.AddClusters(cluster_list);
  //println("cells:" +map.map.size());

} 


void ReadCulture_Clusters(String path, int cell_c_size, Map map)
{  
  String txt_clusters_c[] = loadStrings(path);  
  if (txt_clusters_c == null) {
    println(path + " file is missing!");
    return;
  }
  // Get clusters from file
  ArrayList<Cluster_c> cluster_list_c = new ArrayList<Cluster_c>(txt_clusters_c.length);
  for (int i = 0; i< txt_clusters_c.length; i++) {
    String txt_cells_c[]= split (txt_clusters_c[i], " ");
    //println(txt_cells_c[0]+" a "+txt_cells_c[1]);

    //Get cluster cells
    ArrayList<Cell_c> cluster_cells_c = new ArrayList<Cell_c>(txt_cells_c.length/3);
    for (int j = 0; j < txt_cells_c.length-1; j += 3)
    {
      int x = Integer.parseInt(txt_cells_c[j]);
      int y = -(Integer.parseInt(txt_cells_c[j+1]));
      int z = Integer.parseInt(txt_cells_c[j+2]);
      //println(x +" "+ y +" " + z);

      Cell_c cell_c =  new Cell_c(x, y, z, cell_c_size, i);
      cluster_cells_c.add(cell_c);
      //Register cell in map
      map.AddCell_c(cell_c);
    }
    //Create cluster and store it into a list
    Cluster_c cluster_c = new Cluster_c(cluster_cells_c, i);
    cluster_list_c.add(cluster_c);
  }
  //println("cells:" +map.map.size());
  map.AddClusters_c(cluster_list_c);
} 

/////////////////////////////////////////////////////////////////////////////////////////////////////
void ReadSquare_Clusters(String path, int cell_sq_size, Map map)
{  
  String txt_clusters_sq[] = loadStrings(path);  
  if (txt_clusters_sq == null) {
    println(path + " file is missing!");
    return;
  }
  // Get clusters from file
  ArrayList<Cluster_sq> cluster_list_sq = new ArrayList<Cluster_sq>(txt_clusters_sq.length);
  for (int i = 0; i< txt_clusters_sq.length; i++) {
    String txt_cells_sq[]= split (txt_clusters_sq[i], " ");
    //println(txt_cells_c[0]+" a "+txt_cells_c[1]);

    //Get cluster cells
    ArrayList<Cell_sq> cluster_cells_sq = new ArrayList<Cell_sq>(txt_cells_sq.length/3);
    for (int j = 0; j < txt_cells_sq.length-1; j += 3)
    {
      int x = Integer.parseInt(txt_cells_sq[j]);
      int y = -(Integer.parseInt(txt_cells_sq[j+1]));
      int z = Integer.parseInt(txt_cells_sq[j+2]);
      //println(x +" "+ y +" " + z);

      Cell_sq cell_sq =  new Cell_sq(x, y, z, cell_sq_size, i);
      cluster_cells_sq.add(cell_sq);
      //Register cell in map
      map.AddCell_sq(cell_sq);
    }
    //Create cluster and store it into a list
    Cluster_sq cluster_sq = new Cluster_sq(cluster_cells_sq, i);
    cluster_list_sq.add(cluster_sq);
  }

  map.AddClusters_sq(cluster_list_sq);
} 

/////////////////////////////////////////////////////////////////////////////////////////////////////




void ReadTypology(String path, Map map)
{  
  String txt_typology[] = loadStrings(path);  
  if (txt_typology == null) {
    println(path + " file is missing!");
    return;
  }
  // Get list of typology from file
  ArrayList<Typology> typology_list = new ArrayList<Typology>(txt_typology.length);
  for (int i = 0; i< txt_typology.length; i++) {
    String txt_cells[]= split (txt_typology[i], " ");
    //println(txt_cells[0]+" a "+txt_cells[1]);

    //Get one typology cells
    ArrayList<Integer[]> cells = new ArrayList<Integer[]>(txt_cells.length/3);
    int base_x=0; 
    int base_y=0;
    for (int j = 0; j < txt_cells.length-1; j += 3)
    {
      int x = Integer.parseInt(txt_cells[j]);
      int y = -(Integer.parseInt(txt_cells[j+1]));
      int z = Integer.parseInt(txt_cells[j+2]);
      //println(x +" "+ y +" " + z);

      if (j == 0)
      {
        base_x = x;
        base_y = y;

        cells.add(new Integer[] {
          0, 0, z
        }
        );
      } else
      {
        cells.add(new Integer[] { 
          base_x-x, base_y-y, z
        }
        );
      }
    }
    Typology typology = new Typology(cells);
    typology_list.add(typology);
  }
  map.AddTypologies(typology_list);
}