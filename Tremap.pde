class Treemap{
  float CANVAS_WIDTH;
  float CANVAS_HEIGHT;
  float CANVAS_ORIGIN_X;
  float CANVAS_ORIGIN_Y;
  ArrayList<SquarifyRect> rects;
  int nbItems;
  int type;
  float mapeo;
  
  ArrayList<Rectan> rectangus;
  
  Treemap(float w, float h, float x, float y, int tipo){
    CANVAS_WIDTH = w;
    CANVAS_HEIGHT = h;
    CANVAS_ORIGIN_X = x;
    CANVAS_ORIGIN_Y = y;
    type = tipo;
    mapeo = 0;
    
    rectangus = new  ArrayList<Rectan>();
  }
  
  void armar(){
    
    //Define la cantidad de rectángulos basándose en la amplitud 
    nbItems = round(map(amp,85,100,10,20-10*type));
    
    //Crea un ArratList al que se le van a asignar los valores que la librería
    //va a usar para generar los rectángulos
    ArrayList<Float> values = new ArrayList<Float>();
    
    //Llena el array con valores aleatorios para generar los rectángulos
    for (int i=0; i<nbItems; i++){
      values.add(random(200,1000));
    }
    
    //La librería armma la distribución y tamaño de los rectángulos
    Squarify s = new Squarify(values, CANVAS_ORIGIN_X, CANVAS_ORIGIN_Y, CANVAS_WIDTH, CANVAS_HEIGHT);
    
    //Asigna los rectángulos del objeto tipo Squarify al array de rectángulos
    rects = s.getRects();
    
    //Creo las variables tipo Rectan que van a hacer las shapes en base
    //a los rectángulos creados por la librería
    mapeo = map(pitch, 40, 95, 0, 360);
    for (int i=0; i<nbItems; i++){
      SquarifyRect r = rects.get(i);
      rectangus.add(new Rectan(r.getX(), r.getY(), r.getDx(), r.getDy(), type, mapeo));
      Rectan rectangu = rectangus.get(i);
      rectangu.armar();
    }
    
  }
  
  void dibujar(){
    
    for (int i = 0; i < nbItems; i++) {
      Rectan rectangu = rectangus.get(i);
      rectangu.dibujar();
      
    }
    
  }
}
