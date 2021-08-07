class Mapa{
  ArrayList<Chobi> chobis;
  Spawner[] spawns;
  Portal[] portales;
  Caja[] cajas;
  Plataforma[] pisos;
  Plataforma[] paredes;
  HitCircle circulo;
  Sube_Y_Baja[] subajs;
  FWorld mundo;
  float tam, pos, vel;
  int objetivo, terminados;
  boolean termino;
  
  Mapa(int indice){
    
    //Cargo el archivo .json correspondiente al mapa que quiero cargar
    JSONObject map_File = loadJSONObject("Map_"+nf(indice,3)+".jsonc");
    //Cargo el objeto mapa del json
    JSONObject mapita = map_File.getJSONObject("mapa");
    
    //Asigno el tamaño del json
    tam = mapita.getFloat("tam");
    objetivo = mapita.getInt("objetivo");
    terminados = 0;
    
    //Cargo los datos de las físicas
    JSONObject world = mapita.getJSONObject("mundo");{
    JSONObject gravedad = world.getJSONObject("gravedad");
    float x = gravedad.getFloat("x");
    float y = gravedad.getFloat("y");
    mundo = new FWorld();
    mundo.setGravity(x,y);
    mundo.setEdges(0,0,tam,height);
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
        
        spawns[i] = new Spawner(x,y,c,co,i);
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
        JSONObject pos = box.getJSONObject("pos");
        float x = pos.getFloat("x");
        float y = pos.getFloat("y");
        
        cajas[i] = new Caja(s,x,y,i,mundo);
        
      }
    }
    //Lo borro por las dudas (todo sea por ahorrar memoria)
    boxes = null;
    
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
        
        pisos[i] = new Plataforma(px,py,tx,ty,i,true,mundo);
        
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
        
        paredes[i] = new Plataforma(px,py,tx,ty,i,false,mundo);
        
      }
    }
    pareds = null;
    
    JSONArray subs = mapita.getJSONArray("subajas");
    if(subs != null){
      subajs = new Sube_Y_Baja[subs.size()];
      for(int i = 0; i<subs.size(); i++){
        JSONObject subaj = subs.getJSONObject(i);
        
        float s = subaj.getFloat("escala");
        
        JSONObject pos = subaj.getJSONObject("pos");
        float x = pos.getFloat("x");
        float y = pos.getFloat("y");
        
        subajs[i] = new Sube_Y_Baja(s,x,y,mundo);
      }
    }
    subs = null;
    
    circulo = new HitCircle(mundo);
    
    termino = false;
    
    pos = 0;
    vel = mapita.getFloat("velocidad");
  }
  
  void update(){
    pushMatrix();
    mover();
    if (!termino){
      circulo.update(pos);
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
          }
        }
      }
      if (objetivo <= terminados){termino = true;}
      mundo.step();
      translate(-pos,0);
      mundo.draw();
    }
    if(termino){
      textSize(50);
      text("Ganaste",width*.5,height*.5);
      if(mousePressed){
        exit();
      }
    }
    popMatrix();
  }
  
  void mover(){
    if (mouseX>=width*.8){
      if (pos < map.tam-width*.5){
        pos+=vel;
      }else{pos =map.tam-width*.5;}
    }
    if (mouseX<=width*.2){
      if(pos>=0){
        pos-=vel;
      }
    }
  }
}
