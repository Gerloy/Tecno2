class Rectan {

  //Variables del rectángulo
  float x1, x2, y1, y2, w, h, hue, cx, cy, mapeo;
  color col;
  color colInt[];
  PVector recInt[];
  PImage rec;
  PImage texInt[];
  int cantInter, type;

  Rectan(float px, float py, float wi, float he, int tipo, float mape) {
    x1 = px;
    x2 = px+wi;
    y1 = py;
    y2 = py+he;
    w = wi;
    h = he;
    type = tipo;

    cx = px+w*.5;
    cy = py+h*.5;
    
    mapeo = mape;
  }

  void armar() {
    /* COSAS DEL RECTÁNGULO*/

    //Hacer textura para el rectangulo
    /*Genero un int random entre 1 y 8 para seleccionar la imagen
     que se usará de textura*/
    pushStyle();
    hue = random(mapeo-50, mapeo+50);
    col = color(hue, 50, 75);
    int r = round(random(-.49, 4.49));
    rec = recs[r];
    popStyle();

    cantInter = round(random(.51, 6.49));
    recInt = new PVector[cantInter];
    texInt = new PImage[cantInter];
    colInt = new color[cantInter];

    for (int i=0; i<cantInter; i++) {
      recInt[i] = new PVector(w/(i+1.5), h/(i+1.5));

      r = round(random(-.49, 4.49));
      texInt[i] = recs[r];

      if (hue<75) {
        hue = random(hue+50, 360);
      } else if (hue>85) {
        hue = random(hue-50);
      } else {
        int men_may = round(random(-49, .49));
        if (men_may == 0) {
          hue = random(hue-50);
        } else {
          hue = random(hue+50, 360);
        }
      }
      colInt[i] = color(hue, 75, 75);
    }
  }

  void dibujar() {
    pushStyle();
      tint(col);
      imageMode(CORNER);
      image(rec,x1,y1,w*1.04,h*1.04);
    popStyle();

    for (int i = 0; i< recInt.length; i++) {
      pushStyle();
      imageMode(CENTER);
      tint(colInt[i]);
      image(texInt[i], cx, cy, recInt[i].x, recInt[i].y);
      popStyle();
    }
  }
}
