class Typology {
  
  /////////////////////////////////////////////////////////////////////////////////////////////////////
  // FIELD
  /////////////////////////////////////////////////////////////////////////////////////////////////////
  ArrayList<Integer[]> types;

  /////////////////////////////////////////////////////////////////////////////////////////////////////
  // CONSTRUCTOR
  /////////////////////////////////////////////////////////////////////////////////////////////////////
  Typology(ArrayList<Integer[]> types) {
    this.types = types;
  }
  /////////////////////////////////////////////////////////////////////////////////////////////////////
  // METHODS
  /////////////////////////////////////////////////////////////////////////////////////////////////////
  void createVolume(float x, float y, Map map) {
    int a_x = (int)Math.floor(x*0.1);
    int a_y = (int)Math.floor(y*0.1);
   
    int cluster_index = map.clusters.size();
    ArrayList<Cell> cluster_cells = new ArrayList<Cell>(types.size());

    for ( Integer[] cell : types)
    { 

      // Calculate cell position from typology, round agent position (/10 + 5)
      Cell newCell = new Cell(a_x*10+5+cell[0], a_y*10+5+cell[1], cell[2], 10, cluster_index); //HACK! cell_size
      if (map.addNewCell(newCell))
        cluster_cells.add(newCell);

    }

    //add new cluster to map

    if (cluster_cells.size() > 0) {
      Cluster cluster = new Cluster(cluster_cells, cluster_index);
      map.clusters.add(cluster); //HACK unsave - change transctiption add Clusters to add Cluster
    }   
    

  }




  /////////////////////////////////////////////////////////////////////////////////////////////////////

  void createVolume_c(float x, float y, Map map) {
    int a_x = (int)Math.floor(x*0.1);
    int a_y = (int)Math.floor(y*0.1);

    int cluster_index_c = map.clusters_c.size();
    ArrayList<Cell_c> cluster_cells_c = new ArrayList<Cell_c>(types.size());
    //list of cells - addNewCell(cell);
    for ( Integer[] cell_c : types)
    { 
      // Calculate cell position from typology, round agent position (/10 + 5)
      Cell_c newCell_c = new Cell_c(a_x*10+5+cell_c[0], a_y*10+5+cell_c[1], cell_c[2], 10, cluster_index_c); //HACK! cell_size
      if (map.addNewCell_c(newCell_c))
        cluster_cells_c.add(newCell_c);
    }
    //add new cluster to map
    if (cluster_cells_c.size() > 0) {
      Cluster_c cluster_c = new Cluster_c(cluster_cells_c, cluster_index_c);
      map.clusters_c.add(cluster_c); //HACK unsave - change transctiption add Clusters to add Cluster
    }
  }

  /////////////////////////////////////////////////////////////////////////////////////////////////////

  void createVolume_sq(float x, float y, float z, Map map) {
    int a_x = (int)Math.floor(x*0.1);
    int a_y = (int)Math.floor(y*0.1);
  //  int a_z = (int)Math.floor(z*0.1);

    int cluster_index_sq = map.clusters_sq.size();
    ArrayList<Cell_sq> cluster_cells_sq = new ArrayList<Cell_sq>(types.size());
    //list of cells - addNewCell(cell);
    for ( Integer[] cell_sq : types)
    { 
      // Calculate cell position from typology, round agent position (/10 + 5)
      Cell_sq newCell_sq = new Cell_sq(a_x*10+5+cell_sq[0], a_y*10+5+cell_sq[1],1,12, cluster_index_sq); //HACK! cell_size //cell_sq[2]
      if (map.addNewCell_sq(newCell_sq))
        cluster_cells_sq.add(newCell_sq);
    }
    //add new cluster to map
    if (cluster_cells_sq.size() > 0) {
      Cluster_sq cluster_sq = new Cluster_sq(cluster_cells_sq, cluster_index_sq);
      map.clusters_sq.add(cluster_sq); //HACK unsave - change transctiption add Clusters to add Cluster
    }
  }
  

  
}