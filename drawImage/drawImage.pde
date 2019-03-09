int canvasWidth=800;
int canvasHeight=500;
int imageGap=2;
int imageWidth;
int imageHeight;
PImage image1;
PImage image2;
processGraph processGraph=new processGraph();
void setup()
{
  size(1200,800);
  background(0);
;
  image1=loadImage("view1.png");
  image2=loadImage("view2.png");
  imageWidth=image1.width;
  imageHeight=image1.height;
  iniImage();
  
  processGraph=new processGraph();
  processGraph.run(image1,image2);
}

void iniImage()
{
  //Load and draw image

  image(image2,0,0,imageWidth,imageHeight);
  image(image2,imageWidth+imageGap,0,imageWidth,imageHeight);
  
  //DrawGap
  noStroke();
  fill(0,200);
  rectMode(CORNERS);
  rect(imageWidth,0,imageWidth+imageGap,imageHeight);
}
 
void draw()
{
  processGraph.update();
}
