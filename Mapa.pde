class Mapa{
  ArrayList<Chobi> chobis;
  Spawner[] spawns;
  Portal[] portales;
  Caja[] cajas;
  Tabla[] tablas;
  Plataforma[] pisos;
  Plataforma[] paredes;
  Plataforma[] bajarVel;
  Plataforma[] subirVel;
  HitCircle circulo;
  Sube_Y_Baja[] subajs;
  FWorld mundo;
  float tam, pos, vel;
  int objetivo, terminados, total;
  boolean termino, perdio;
  Aparecer_Cajita caj;
  
  Mapa(int indice){
    
    //Cargo el archivo .json correspondiente al mapa que quiero cargar
    JSONObject map_File = loadJSONObject("Map_"+nf(indice,3)+".json");
    //Cargo el objeto mapa del json
    JSONObject mapita = map_File.getJSONObject("mapa");
    
    //Asigno el tamaño del json
    tam = mapita.getFloat("tam");
    objetivo = mapita.getInt("objetivo");
    terminados = 0;
    total = 0;
    
    //Cargo los datos de las físicas
    JSONObject world = mapita.getJSONObject("mundo");{
    JSONObject gravedad = world.getJSONObject("gravedad");
    float x = gravedad.getFloat("x");
    float y = gravedad.getFloat("y");
    mundo = new FWorld(0,0,tam+200,600);
    mundo.setGravity(x,y);
    mundo.setEdges(0,0,tam,900);
    mundo.setGrabbable(false);
    }
    
    //Creo el arraylist de chobis
    chobis = new ArrayList<Chobi>();
    
    //Cargo el spawner de los bichos
    JSONArray sp = mapita.getJSONArray("spawners");
    if(sp != null){
      spawns = new Spawner[sp.size()];
      for (int i=0; i<sp.size(); i++){
        
        JSONObject spawn = sp.getJSONObject(i);
        
        JSONObject pos = spawn.getJSONObject("pos");
        float x = pos.getFloat("x");
        float y = pos.getFloat("y");
        
        int c = spawn.getInt("cantidad");
        int co = spawn.getInt("cooldown");
        float v = spawn.getFloat("velocidad"); 
        float s = spawn.getFloat("tam");
        
        spawns[i] = new Spawner(x,y,s,c,co,i,v);
        total += c;
      }
    }
    sp = null;
    
    //Cargo los portales a los que dirigir a los bichos
    JSONArray por = mapita.getJSONArray("portales");
    if(por != null){
      portales = new Portal[por.size()];
      for (int i=0; i<por.size(); i++){
        JSONObject puerta = por.getJSONObject(i);
        
        JSONObject pos = puerta.getJSONObject("pos");
        float x = pos.getFloat("x");
        float y = pos.getFloat("y");
        
        portales[i] = new Portal(x,y,i, mundo);
      }
    }
    por = null;
    
    //Cargo las cajas
    JSONArray boxes = mapita.getJSONArray("cajas");
    //Todo puede ser null, así que hay que corroborar
    if(boxes != null){
      cajas = new Caja[boxes.size()];
      for (int i = 0; i<boxes.size(); i++){
        JSONObject box = boxes.getJSONObject(i);
        
        float s = box.getFloat("escala");
        float p = box.getFloat("peso");
        JSONObject pos = box.getJSONObject("pos");
        float x = pos.getFloat("x");
        float y = pos.getFloat("y");
        
        cajas[i] = new Caja(s,x,y,p,i,mundo);
        
      }
    }
    //Lo borro por las dudas (todo sea por ahorrar memoria)
    boxes = null;
    
    //Cargo las tablas
    JSONArray tables = mapita.getJSONArray("tablas");
    //Todo puede ser null, así que hay que corroborar
    if(tables != null){
      tablas = new Tabla[tables.size()];
      for (int i = 0; i<tables.size(); i++){
        JSONObject tabla = tables.getJSONObject(i);
        
        float p = tabla.getFloat("peso");
        JSONObject pos = tabla.getJSONObject("pos");
        float x = pos.getFloat("x");
        float y = pos.getFloat("y");
        JSONObject tam = tabla.getJSONObject("tam");
        float tx = tam.getFloat("x");
        float ty = tam.getFloat("y");
        
        tablas[i] = new Tabla(x,y,tx,ty,p,i,mundo);
        
      }
    }
    //Lo borro por las dudas (todo sea por ahorrar memoria)
    tables = null;
    
    JSONArray pisitos = mapita.getJSONArray("pisos");
    if(pisitos != null){
      pisos = new Plataforma[pisitos.size()];
      for (int i = 0; i<pisitos.size(); i++){
        JSONObject piso = pisitos.getJSONObject(i);
        
        JSONObject pos = piso.getJSONObject("pos");
        float px = pos.getFloat("x");
        float py = pos.getFloat("y");
        
        JSONObject tam = piso.getJSONObject("tam");
        float tx = tam.getFloat("x");
        float ty = tam.getFloat("y");
        
        pisos[i] = new Plataforma(px,py,tx,ty,i,0,mundo);
        
      }
    }
    pisitos = null;
    
    JSONArray pareds = mapita.getJSONArray("paredes");
    if(pareds != null){
      paredes = new Plataforma[pareds.size()];
      for (int i = 0; i<pareds.size(); i++){
        JSONObject pared = pareds.getJSONObject(i);
        
        JSONObject pos = pared.getJSONObject("pos");
        float px = pos.getFloat("x");
        float py = pos.getFloat("y");
        
        JSONObject tam = pared.getJSONObject("tam");
        float tx = tam.getFloat("x");
        float ty = tam.getFloat("y");
        
        paredes[i] = new Plataforma(px,py,tx,ty,i,1,mundo);
        
      }
    }
    pareds = null;
    
    JSONArray baja = mapita.getJSONArray("bajarVel");
    if(baja != null){
      bajarVel = new Plataforma[baja.size()];
      for (int i = 0; i<baja.size(); i++){
        JSONObject bajar = baja.getJSONObject(i);
        
        JSONObject pos = bajar.getJSONObject("pos");
        float px = pos.getFloat("x");
        float py = pos.getFloat("y");
        
        JSONObject tam = bajar.getJSONObject("tam");
        float tx = tam.getFloat("x");
        float ty = tam.getFloat("y");
        
        bajarVel[i] = new Plataforma(px,py,tx,ty,i,2,mundo);
        
      }
    }
    baja = null;
    
    JSONArray sube = mapita.getJSONArray("subirVel");
    if(sube != null){
      subirVel = new Plataforma[sube.size()];
      for (int i = 0; i<sube.size(); i++){
        JSONObject bajar = sube.getJSONObject(i);
        
        JSONObject pos = bajar.getJSONObject("pos");
        float px = pos.getFloat("x");
        float py = pos.getFloat("y");
        
        JSONObject tam = bajar.getJSONObject("tam");
        float tx = tam.getFloat("x");
        float ty = tam.getFloat("y");
        
        subirVel[i] = new Plataforma(px,py,tx,ty,i,3,mundo);
        
      }
    }
    sube = null;
    
    JSONArray subs = mapita.getJSONArray("subajas");
    if(subs != null){
      subajs = new Sube_Y_Baja[subs.size()];
      for(int i = 0; i<subs.size(); i++){
        JSONObject subaj = subs.getJSONObject(i);
        
        float s = subaj.getFloat("escala");
        
        JSONObject pos = subaj.getJSONObject("pos");
        float x = pos.getFloat("x");
        float y = pos.getFloat("y");
        
        subajs[i] = new Sube_Y_Baja(s,x,y,mundo,i);
      }
    }
    subs = null;
    
    circulo = new HitCircle(mundo);
    
    termino = false;
    perdio = false;
    
    pos = 0;
    vel = mapita.getFloat("velocidad");
    
    caj = new Aparecer_Cajita(mundo);
  }
  
  void update(){
    pushMatrix();
    if (!termino && !perdio){
      if(spawns != null){
        for (Spawner spawn : spawns){
          spawn.update(chobis,mundo);
          if (spawn.termino){
            spawn = null;
          }
        }
      }
      
      if(chobis != null){
        for(Chobi bicho : chobis){
          bicho.update();
          if (bicho.llego){
            terminados +=1;
            bicho.delete(mundo);
            bicho = null;
            total--;
          }else if (bicho.f){
            bicho.delete(mundo);
            bicho = null;
            total--;
          }
        }
      }
      if (objetivo <= terminados){
        termino = true;
      }else if(total < objetivo-terminados){ //Si la cantidad de bichos que hay 
        perdio = true;                       //y van a aparecer es menor a la necesaria el jugador pierde
      }
      mundo.step();
      mover();
      caj.update(mundo);
      circulo.update(pos);
      translate(-pos,0);
      mundo.draw();
      //Info sobre el objetivo
      textSize(height*.1);
      text(terminados+"/"+objetivo,width-height*.15+pos,height*.15);
      //text("Pos: "+pos,200+pos,100);
    }
    if(termino){
      translate(-pos,0);
      mundo.draw();
      textSize(50);
      text("Ganaste",width*.5+pos,height*.5);
      if(mousePressed){
        estado = 0;
      }
    }else if(perdio){
      translate(-pos,0);
      mundo.draw();
      textSize(50);
      text("Perdiste",width*.5+pos,height*.5);
      if(mousePressed){
        estado = 0;
      }
    }
    popMatrix();
  }
  
  void mover(){
    if (mouseX>=width*.8){
      if (pos < map.tam-width*.5){
        pos+=vel;
      }//else{pos = map.tam-width*.5;}
    }
    if (mouseX<=width*.2){
      if(pos>=0){
        pos-=vel;
      }
    }
  }
}
