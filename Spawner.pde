class Spawner{
  
  float px,py;
  int i, n, cooldown, cant;
  float time;
  boolean termino;
  //Chobi[] chobis;
  
  Spawner(float x, float y, int c, int co, int ns){
    
    px = x;
    py = y;
    i=0;
    n = ns;
    cant = c;
    cooldown = co;
    time = 0;
    termino = false;
    
  }
  
  void update(ArrayList<Chobi> chobis){
    
    if(millis() >= cooldown+time){
      if(i<cant){
        Chobi bicho = new Chobi(px,py,i,n);
        chobis.add(bicho);
        i++;
      }else{termino = true;}
      time = millis();
    } 
  }
}
