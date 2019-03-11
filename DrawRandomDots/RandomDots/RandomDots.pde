int y;
boolean drawBig,drawSmall_Left,drawSmall_Right;
void setup()
{
 this.drawBig=true;
 this.drawSmall_Left=false;
 this.drawSmall_Right=false;
 size(512,512); 
 background(0,0,255);
}

void draw()
{
   if(drawBig&&y>512){
   save("RandomDot_BackGround.gif");drawBig=false;drawSmall_Left=true;y=128;}
   
   if(drawSmall_Left&&y>128+256){
   save("RandomDot_Left.gif");
   image(loadImage("RandomDot_BackGround.gif"),0,0);//Reload background.
   drawSmall_Left=false;drawSmall_Right=true;y=128;
   }
   
   if(drawSmall_Right&&y>128+256){
   save("RandomDot_Right.gif");drawSmall_Right=false;y=0;
   textSize(50);
   textAlign(CENTER,CENTER);
   fill(255,0,0);
   text("Done!",512/2,512/2);
   }
   
   if(drawBig)
   {
     for(int x=0;x<=512;x++)
     {
     set(x,y,color(Math.round(random(1))*255));
     }
     y++;
   }
   if(drawSmall_Left)
   {
     for(int x=124;x<=124+256;x++)//123+256 there is not good, but I did it because it is easier to understand.
     {
     set(x,y,color(Math.round(random(1))*255));
     }
     y++;
   }
   if(drawSmall_Right)
   {
     for(int x=132;x<=132+256;x++)//123+256 there is not good, but I did it because it is easier to understand.
     {
     set(x,y,color(Math.round(random(1))*255));
     }
     y++;
   }
}
