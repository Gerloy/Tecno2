import squarify.library.*; //<>// //<>//
import oscP5.*;

//Variables de OSC
float amp;
float pitch;
float p_amp;

PImage recs[];

OscP5 osc;

//Treemap general
Treemap canvas;

//Treemaps anidados a los treemaps más grandes para divirdir
//más sin que los rectángulos se hagan muy cuadrados
Treemap canvasInterior[];

void setup() {
  size(600, 600, P2D);

  colorMode(HSB, 360, 100, 100, 100);

  recs = new PImage[5];
  for (int i = 1; i <=recs.length; i++) {
    recs[i-1] = loadImage("rect"+i+".jpg");
    recs[i-1].filter(INVERT);
    recs[i-1].mask(recs[i-1]);
  }

  amp=85;
  canvas = new Treemap(width, height, 0, 0, 0);
  canvas.armar();


  osc = new OscP5(this, 12345);
}

void draw() {
  background(canvas.mapeo, 50, 75);
  //Checkea si al array vanvasInterior se le asignaron valores
  if (canvasInterior != null) {
    //Si se le asignaron valores dibuja los Treemaps que contiene el array
    for (int i=0; i<canvas.nbItems; i++) {
      canvasInterior[i].dibujar();
    }
  } else {
    canvas.dibujar();
  }
  checkearCanvas();
}

void oscEvent(OscMessage m) {
  if (m.addrPattern().equals("/amp")) {
    p_amp = amp;
    amp = m.get(0).floatValue();
  }

  if (m.addrPattern().equals("/pitch")) {
    pitch = m.get(0).floatValue();
  }
}

/*Función para hacer Treemaps que se dibujen dentro de los Treemaps del array canvas
 Nota: Pasar a objetos para que quede más bonito*/
void armarCanvasInterior() {
  canvasInterior = new Treemap[canvas.nbItems];
  for (int i=0; i <canvas.nbItems; i++) {
    SquarifyRect r = canvas.rects.get(i);
    canvasInterior[i] = new Treemap(r.getDx(), r.getDy(), r.getX(), r.getY(), 1);
    canvasInterior[i].armar();
  }
}

void checkearCanvas() {
  if (amp > 85) {
    if ((p_amp <= amp-5) || (p_amp >= amp+5)) {
      canvas.armar();
      if (canvas.nbItems > 8) {
        armarCanvasInterior();
      } else {
        canvasInterior = null;
      }
    }
  } else {
    if ((p_amp < amp-5) || (p_amp > amp+5)) {
      if (canvasInterior != null) {
        if (amp>20) {
          int cantidad = 0;
          for (int i = 0; i< canvas.nbItems; i++) {
            cantidad += canvasInterior[i].nbItems;
          }
          int tree = round(map(amp-20, 0, 65, 0, cantidad));
          int i = 0;
          while (tree > canvasInterior[i].nbItems) {
            tree -= canvasInterior[i].nbItems;
            i++;
          }
          float sat = map(pitch, 40, 70, 50, 100);
          while(tree<=-1){tree++;}
          Rectan rectangu = canvasInterior[i].rectangus.get(tree-1);

          rectangu.col = color(random(rectangu.mapeo-50, rectangu.mapeo+50), sat, 75);
        }
      } else {
        if (amp>20) {
          int tree = round(map(amp-20, 0, 65, 0, canvas.nbItems-1));
          //float valorMin = 65/canvasInterior.length*tree;
          //float valorMax = 65/canvasInterior.length*tree+1;
          //int inTree = round(map(amp-20, valorMin, valorMax, 0, canvasInterior[tree].nbItems-1));
          float sat = map(pitch, 40, 70, 50, 100);
          Rectan rectangu = canvas.rectangus.get(tree);
          rectangu.col = color(random(rectangu.mapeo-50, rectangu.mapeo+50), sat, 75);
        }
      }
    }
  }
}
