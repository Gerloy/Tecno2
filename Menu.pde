class Menu{
  
  FWorld mundo;
  int state, camara;
  //JSONObject config;
  boolean begin;
  Boton btnStart, btnExit, btnOptions, btnBack;
  //FBox btnStart, btnExit, btnOptions, btnBack;
  FBox[] btnMaps, btnCameras;
  HitCircle pj;
  PImage fondo;
  
  Menu(Minim minim){
    begin = false;
    mundo = new FWorld(-400,-400,width+400,height+400);
    mundo.setGravity(0,0);
    mundo.setEdges(0,0,width,height);
    mundo.setGrabbable(false);
    state = 0;
    camara = -1;
    pj = new HitCircle(mundo);
    //config = loadJSONObject("config.json");
    fondo = loadImage("img/fondo.png");
    
    btnStart = new Boton(width*.7,height*.5,400,100,"Start",2,mundo,minim);
    btnOptions = new Boton(width*.7,height*.65,400,100,"Options",1,mundo,minim);
    btnExit = new Boton(width*.7,height*.8,400,100,"Exit",-1,mundo,minim);
    btnBack = new Boton(width*.7,height*.8,400,100,"Back",0,mundo,minim);
    
  }
  
  void update(){
    /*
    Estado -1 = salir
    Estado 0 = inicio
    Estado 1 = opciones
    Estado 2 = cargar mapa
    */
    pj.update(0);
    switch (state){
      case 0:
        
        btnStart.prendido = true;
        //btnOptions.prendido = true;
        btnExit.prendido = true;
        btnBack.prendido = false;
        if (state == 0){
          state = btnStart.update(state);
        }
        //if (state == 0){
        //  state = btnOptions.update(state);
        //}
        if (state == 0){
          state = btnExit.update(state);
        }
        
        pj.checkBtns(new Boton[] {btnStart,btnOptions,btnExit});
        
        mundo.step();
      break;
      
      case 1:
        btnStart.prendido = false;
        btnOptions.prendido = false;
        btnExit.prendido = false;
        btnBack.prendido = true;
        if (state == 1){
          state = btnBack.update(state);
        }
        
        pj.checkBtns(new Boton[] {btnBack});
        
        mundo.step();
      break;
      
      case 2:
        begin = true;
      break;
      case -1:
        exit();
      break;
        
    }
  }
  
  void dibujar(){
    pushStyle();
      imageMode(CENTER);
      image(fondo,width*.5,height*.5,width,height);
    popStyle();
    /*pushStyle();
      imageMode(CENTER);
      image(fondo,width*.5,height*.5,width,height);
      if (fon!=null){
        tint(255,126);
        imageMode(CORNER);
        image(fon,-400,-400,width+700,height+700);
      }
    popStyle();*/
    switch (state){
      case 0:
      //Cosas de debug
        //pushStyle();
        //  textAlign(LEFT,CENTER);
        //  text(btnStart.btn.getName()+": "+btnStart.activo,40,40);
        //  text(btnOptions.btn.getName()+": "+btnOptions.activo,40,80);
        //  text(btnExit.btn.getName()+": "+btnExit.activo,40,120);
        //popStyle();
        
        pushStyle();
          fill(108,90,168);
          noStroke();
          rectMode(CENTER);
          
          //Botón start
          rect(btnStart.btn.getX(),btnStart.btn.getY(),btnStart.btn.getWidth(),btnStart.btn.getHeight());
          
          //Botón Options
          //rect(btnOptions.btn.getX(),btnOptions.btn.getY(),btnOptions.btn.getWidth(),btnOptions.btn.getHeight());
          
          //Botón Exit
          rect(btnExit.btn.getX(),btnExit.btn.getY(),btnExit.btn.getWidth(),btnExit.btn.getHeight());
          
        popStyle();
        
        pushStyle();
          fill(255);
          stroke(255);
          textSize(30);
          text("Comenzar",btnStart.btn.getX(),btnStart.btn.getY());
          //text("Opciones",btnOptions.btn.getX(),btnOptions.btn.getY());
          text("Salir",btnExit.btn.getX(),btnExit.btn.getY());
        popStyle();
        if (btnStart.activo){
          pushStyle();
            fill(255);
            noStroke();
            arc(pj.circulo.getX(),pj.circulo.getY(),pj.circulo.getSize(),pj.circulo.getSize(),0,btnStart.ang);
          popStyle();}
        //}else if (btnOptions.activo){
        //  pushStyle();
        //    fill(255);
        //    noStroke();
        //    arc(pj.circulo.getX(),pj.circulo.getY(),pj.circulo.getSize(),pj.circulo.getSize(),0,btnOptions.ang);
        //  popStyle();}
        else if (btnExit.activo){
          pushStyle();
            fill(255);
            noStroke();
            arc(pj.circulo.getX(),pj.circulo.getY(),pj.circulo.getSize(),pj.circulo.getSize(),0,btnExit.ang);
          popStyle();
        }
      break;
      
      case 1:
        pushStyle();
          textAlign(LEFT,CENTER);
          text(btnBack.btn.getName()+": "+btnBack.activo,40,40);
        popStyle();
        
        pushStyle();
          fill(0);
          stroke(255);
          rectMode(CENTER);
          
          //Botón back
          noStroke();
          fill(108,90,168);
          rect(btnBack.btn.getX(),btnBack.btn.getY(),btnBack.btn.getWidth(),btnBack.btn.getHeight());
        popStyle();
        
        pushStyle();
          fill(255);
          stroke(255);
          textSize(30);
          text("Volver",btnBack.btn.getX(),btnBack.btn.getY());
        popStyle();
        if (btnBack.activo){
          pushStyle();
            fill(255);
            noStroke();
            arc(pj.circulo.getX(),pj.circulo.getY(),pj.circulo.getSize(),pj.circulo.getSize(),0,btnBack.ang);
          popStyle();
        }
      break;
    }
    noFill();
    stroke(255);
    pj.dibujar();
  }
}
