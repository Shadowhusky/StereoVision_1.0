

class processGraph
{
  boolean scanning,Drawing;
  int x,y=0;
  int patchSide=imageWidth/30;
  int line=0;
  int[][][] intensity;
  PImage image1;
  PImage image2;
  
  
  void run(PImage image1,PImage image2)
  {
    this.image1=image1;
    this.image2=image2;
    stereoVision();
    //this.scanning=true;
    //this.x=patchSide/2;
    //this.y=patchSide/2;
  }
  
  void update()
  {
    if(Drawing&&line<imageHeight)
    {
      drawDepthImage();
      line++;
    } //<>//
  }
  
  
  void stereoVision()
  {
    intensity=new int[2][imageWidth+1][imageHeight+1];
    intensity=getGrayScale();
    Drawing=true;
  }
  
  void drawDepthImage()
  {
    int up,down,left,right;
    
    calculateCost costCalculator=new calculateCost(intensity);
    costCalculator.getCostArray(imageWidth,line);
    int[] disparity=costCalculator.backPass();
    for(int i=imageWidth;i>=0;i--)
    {
      color grayness=color(disparity[i]);
      int j=line;
      if(grayness==color(0)&&i>2)//Smooth
      {
        set(imageWidth-i,line,2*color((disparity[i+1]+disparity[i+2]+disparity[i-2]+disparity[i-1])/4));
      }
      else
      {
      set(imageWidth-i,line,grayness*2);
      }
    }
  }
 
  
  
  int[][][] getGrayScale()
  {
    int r,g,b,rgb;
    for(int i=0;i<imageWidth;i++)
    {
      for(int j=0;j<imageHeight;j++)
      {
        rgb=image1.get(i,j);
        r = (rgb >> 16) & 0xFF;
        g = (rgb >> 8) & 0xFF;
        b = (rgb & 0xFF);
        intensity[0][i][j]=(r+g+b)/3;
        rgb=image2.get(i,j);
        r = (rgb >> 16) & 0xFF;
        g = (rgb >> 8) & 0xFF;
        b = (rgb & 0xFF);
        intensity[1][i][j]=(r+g+b)/3;
        //set(i,j,color(intensity[1][i][j]));
      }
    }
    return intensity;
  }
  
  
}
