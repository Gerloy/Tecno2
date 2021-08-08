class Spawner{
  
  float px,py;
  int i, n, cooldown, cant;
  float time, vel;
  boolean termino;
  
  Spawner(float x, float y, int c, int co, int ns, float v){
    
    px = x;
    py = y;
    i=0;
    n = ns;
    cant = c;
    cooldown = co;
    time = 0;
    termino = false;
    vel = v;
    
  }
  
  void update(ArrayList<Chobi> chobis, FWorld mundo){
    
    if(millis() >= cooldown+time){
      if(i<cant){
        Chobi bicho = new Chobi(px,py,vel,i,n, mundo);
        chobis.add(bicho);
        i++;
      }else{termino = true;}
      time = millis();
    } 
  }
}
