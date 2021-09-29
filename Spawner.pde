class Spawner{
  
  float px,py,time,vel,scale;
  int i, n, cooldown, cant;
  boolean termino;
  
  Spawner(float x, float y, float s, int c, int co, int ns, float v){
    
    px = x;
    py = y;
    scale = s;
    i=0;
    n = ns;
    cant = c;
    cooldown = co;
    time = 0;
    termino = false;
    vel = v;
    
  }
  
  void update(ArrayList<Chobi> chobis, FWorld mundo, Minim minim){
    
    if(millis() >= cooldown+time){
      if(i<cant){
        Chobi bicho = new Chobi(px,py,vel,scale,i,n,mundo,minim);
        chobis.add(bicho);
        i++;
      }else{termino = true;}
      time = millis();
    } 
  }
}
