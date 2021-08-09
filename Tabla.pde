class Tabla{

  FBox tabla;
  
  Tabla(float x,float y,float sx,float sy, float p, int i, FWorld mundo){
    
    tabla = new FBox(sx,sy);
    tabla.setPosition(x,y);
    tabla.setDensity(p);
    tabla.setFill(0);
    tabla.setStroke(255);
    tabla.setName("Tabla_"+i);
    tabla.setGroupIndex(1);
    mundo.add(tabla);
  }
  
  void delete(FWorld mundo){
    mundo.remove(tabla);
  }
}
