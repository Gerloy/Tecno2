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
  int objetivo, terminados, total, cool, time, sig;
  boolean termino, perdio;
  Fondo fondo;
  Arbolitos arb;
  
  //cosas del sonido
  //Minim minim;
  AudioOutput out;
  Sampler win,lose,music;
  
  Mapa(int indice, Minim minim){
    
    //cosas del sonido
    lose = new Sampler("snd/derr.wav",4,minim);
    win = new Sampler("snd/ganar.wav",4,minim);
    
    out = minim.getLineOut();
    
    lose.patch(out);
    win.patch(out);
    
    cool = 1000;
    
    //Cargo el archivo .json correspondiente al mapa que quiero cargar
    JSONObject map_File = loadJSONObject("maps/Map_"+nf(indice,3)+".json");
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
    mundo = new FWorld(-400,-400,tam+400,height+400);
    mundo.setGravity(x,y);
    mundo.setEdges(0,0,tam,height+200);
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
    
    //Carga pisos
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
    
    //Cargo las paredes
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
    
    //Cargo la platafoema que reduce velocidad
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
    
    //Cargo la plataforma que aumenta velocidad
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
    
    //Cargo los subeybajas
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
    
    //Carga del fondo
    JSONObject fon = mapita.getJSONObject("fondo");
    String id = fon.getString("texId");
    fondo = new Fondo(id);
    fon = null;
    sig = mapita.getInt("siguiente");
    
    arb = new Arbolitos();
  }
  
  void update(Minim minim){
    if (!termino && !perdio){
      if(spawns != null){
        for (Spawner spawn : spawns){
          spawn.update(chobis,mundo,minim);
          if (spawn.termino){
            spawn = null;
          }
        }
      }
      
      if(chobis != null){
        for(Chobi bicho : chobis){
          bicho.update(total,objetivo,terminados);
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
        win.trigger();
        time = millis();
        
      }else if(total < objetivo-terminados){ //Si la cantidad de bichos que hay 
        perdio = true;                       //y van a aparecer es menor a la necesaria el jugador pierde
        lose.trigger();
        time = millis();
      }
      mundo.step();
      mover();
      circulo.update(pos);     
    }
    if(termino){
      if(millis()>=time+cool){
        if(sig!=-1){
          mapita = sig;
          estado = 1;
        }else{reset();}
      }
    }else if(perdio){
      if(millis() >= time+cool){
        estado = 1;
      }
    }
  }
  
  void dibujar(){
    //Fondo
      translate(-pos,0);
      fondo.dibujar(pos);
      arb.dibujar(pos);
      
    //Plataformas inamovibles
    //paredes
      for(Plataforma pared : paredes){
        pared.dibujar();
      }
    //pisos
      for(Plataforma piso : pisos){
        piso.dibujar();
      }
    //Subir vel
      for(Plataforma sub : subirVel){
        sub.dibujar();
      }
    //Bajar vel
      for(Plataforma baj : bajarVel){
        baj.dibujar();
      }
    //Portales
      for(Portal por : portales){
        por.dibujar();
      }
    
    
    //Objetos interactuables
    //Sube y Bajas
      for (Sube_Y_Baja suba : subajs){
        suba.dibujar();
      }
    //Tablas
      for(Tabla tab : tablas){
        tab.dibujar();
      }
    //Cajas
      for(Caja caj : cajas){
        caj.dibujar();
      }
    //dibujar los chobis
      for(Chobi cho : chobis){
        cho.dibujar();
      }
    
    //Cosas de la interfaz
    //Player
      circulo.dibujar();
    //Info sobre el objetivo
      textSize(height*.1);
      fill(255);
      text(terminados+"/"+objetivo,width-height*.15+pos,height*.15);
      //text("Pos: "+pos,200+pos,100);
      
    //Victoria y derrota
      if(termino){
        textSize(50);
        fill(255);
        text("Ganaste",width*.5+pos,height*.5);
      }else if (perdio){
        textSize(50);
        fill(255);
        text("Perdiste",width*.5+pos,height*.5);
      }
  }
  
  void mover(){
    if (mouseX>=width*.8){
      if (pos < map.tam-width){
        float v = map(mouseX,width*.8,width,0,vel);
        pos+=v;
        fondo.movDer();
        arb.movDer();
      }//else{pos = map.tam-width*.5;}
    }
    if (mouseX<=width*.2){
      if(pos>=0){
        float v = map(mouseX,width*.2,0,0,vel);
        pos-=v;
        fondo.movIz();
        arb.movIz();
      }
    }
  }
}
