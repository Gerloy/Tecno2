class Mapa{
  ArrayList<Chobi> chobis;
  Spawner[] spawns;
  Portal[] portales;
  Caja[] cajas;
  Plataforma[] pisos;
  Plataforma[] paredes;
  HitCircle circulo;
  Sube_Y_Baja[] subajs;
  float tam;
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
        
        portales[i] = new Portal(x,y,i);
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
        
        cajas[i] = new Caja(s,x,y,i);
        
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
        
        pisos[i] = new Plataforma(px,py,tx,ty,i,true);
        
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
        
        paredes[i] = new Plataforma(px,py,tx,ty,i,false);
        
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
        
        subajs[i] = new Sube_Y_Baja(s,x,y);
      }
    }
    subs = null;
    
    circulo = new HitCircle();
    
    termino = false;
  }
  
  void update(){
    if (!termino){
      circulo.update();
      if(spawns != null){
        for (Spawner spawn : spawns){
          spawn.update(chobis);
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
            bicho.delete();
            bicho = null;
          }
        }
      }
      if (objetivo <= terminados){termino = true;}
    }
    if(termino){
      textSize(50);
      textAlign(CENTER,CENTER);
      text("Ganaste",width*.5,height*.5);
    }
  }
}
