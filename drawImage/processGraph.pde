

class processGraph
{
  boolean scanning,Drawing,smoothed;
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
    if(line>imageHeight)
    {
      Drawing=false;
    }
    if(Drawing)
    {
      drawDepthImage();
      line++;
    } //<>//

    smoothImage(); 

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
        set(imageWidth-i,line,3*color((disparity[i+1]+disparity[i+2]+disparity[i-2]+disparity[i-1])/4));
      }
      else
      {
        set(imageWidth-i,line,grayness*3);
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
  
  
  int[][] getSingleGrayScale()
  {
    int[][] intensity=new int[imageWidth+1][line+1];
    int r,g,b,rgb;
    for(int i=0;i<imageWidth;i++)
    {
      for(int j=0;j<line;j++)
      {
        rgb=get(i,j);
        r = (rgb >> 16) & 0xFF;
        g = (rgb >> 8) & 0xFF;
        b = (rgb & 0xFF);
        intensity[i][j]=(r+g+b)/3;
      }
    }
    return intensity;
  }
  
  void smoothImage()
  {
    int value = 50;
    smoothed=true;
    int[][] intensity=getSingleGrayScale();
    for(int i=0;i<imageWidth;i++)
    {
     for(int j=0;j<line;j++)
     {
       if(i+1<intensity.length&&j+1<intensity[0].length&&i>0&&j>0)
       {
         if(Math.abs(intensity[i][j]-intensity[i-1][j])>value||Math.abs(intensity[i][j-1]-intensity[i][j])>value||Math.abs(intensity[i][j+1]-intensity[i][j])>value||Math.abs(intensity[i][j]-intensity[i+1][j])>value)
         {
           set(i,j,color((intensity[i-1][j] + intensity[i+1][j] + intensity[i][j+1] + intensity[i][j-1] + intensity[i-1][j-1] + intensity[i-1][j+1] + intensity[i+1][j-1] + intensity[i-1][j-1])/8));
         }
       }
     }
    }
  }
  
  
}
