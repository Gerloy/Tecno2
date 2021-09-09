class Boton{
  FBox btn;
  int cool, time, sta;
  boolean activo, prendido;
  float ang;
  
  Boton(float x, float y, float tx, float ty, String name, int st, FWorld world){
    btn = new FBox(tx,ty);
    btn.setPosition(x,y);
    btn.setStroke(255);
    btn.setFill(0);
    btn.setName("btn_"+name);
    btn.setStatic(true);
    btn.setSensor(true);
    btn.setDrawable(false);
    btn.setGroupIndex(-2);
    world.add(btn);
    
    cool = 1000;
    time = 0;
    activo = false;
    prendido = false;
    ang = 0;
    sta = st;
  }
  
  int update(int state){
    if (prendido){
      btn.setDrawable(true);
      btn.setFill(0);
      btn.setStroke(255);
      ArrayList<FContact> contactos = btn.getContacts();
      if (contactos == null){
        activo = false;
        ang = radians(.01);
        return(state);
      }else{
        for (FContact cont : contactos){
          FBody c1 = cont.getBody1();
          FBody c2 = cont.getBody2();
          //Si no está activo y está colisionando con el player
          //se activa y regresa el estado del menú
          if (!activo){
            if (c1.getName()!=null && c2.getName()!=null){
              if(c1.getName().contains("Player") || c2.getName().contains("Player")){
                activo = true;
                ang = radians(.01);
                time = millis();
                return(state);
              }
            }
          }else{
            //Si está activo y colisionando con el player
            //Se aumenta el ángulo del arco hasta uqe al llegar al máximo
            //el método devuelve el estado al que lleva el botón
            if (c1.getName()!=null && c2.getName()!=null){
              if(c1.getName().contains("Player") || c2.getName().contains("Player")){
                //println(btn.getName()+": "+activo);
                if(millis()<=time+cool){
                  ang = map(millis(),time,time+cool,0,TWO_PI);
                  return state;
                }else{ang = 0; activo = false;  return (sta);}
              }else {ang = 0; activo = false; return state;}
            }
          }
        }
      }
    }else{activo = false; btn.setDrawable(false); btn.setNoFill(); btn.setNoStroke();}
    return state;
  }
  
}
