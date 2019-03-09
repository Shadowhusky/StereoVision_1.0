import java.awt.*;

public class calculateCost
{
  int[][][] intensity;
  int N,M;
  public calculateCost(int[][][] intensity)
  {
    this.intensity=intensity;
    getCostArray(intensity[0].length-1,intensity[0][0].length-1);
  }
  
  private final float Occlusion=3.8f;
  int line=0;
  int[][] actions;

  void getCostArray(int N,int M) 
  {
    this.N=N;
    this.line=M;
    float[][] cost=new float[N+1][N+1];
    actions=new int[N+1][N+1];
    cost[0][0]=Cost(0,0);
    for(int i=1;i<=N;i++){cost[i][0]=i*Occlusion;}
    for(int i=1;i<=N;i++){cost[0][i]=i*Occlusion;}
    for(int i=1;i<=N;i++)
    {
     for(int j=1;j<=N;j++)
       {
         cost[i][j]=Math.min(Math.min(cost[i-1][j]+Occlusion,cost[i][j-1]+Occlusion), cost[i-1][j-1]+Cost(i,j)); 
         if(cost[i][j]==cost[i-1][j-1]+Cost(i,j))
         {
             actions[i][j]=1;
         }
         if(cost[i][j]==cost[i-1][j]+Occlusion)
         {
             actions[i][j]=2;
         }
         if(cost[i][j]==cost[i][j-1]+Occlusion)
         {
             actions[i][j]=3;
         }
         //System.out.println( actions[i][j]+"  "+i+"  "+j);
       }
       //System.out.println("");
    }
  }
  
  float Cost(int i,int j)
  {
    int intensityDiff=Math.abs(intensity[0][i][line]-intensity[1][j][line]);
    return (0.6f*intensityDiff);
  }
  
  int[] backPass()
  {
    int[] disparity=new int[N+N];
    int copy_N=N;
    int copy_M=N;
    int index=0;
    for(int i=0;i<N;i++)
    {
      switch (actions[copy_N][copy_M])
      {
        
        case 1:
          disparity[index]=Math.abs(copy_M-copy_N);
          copy_M-- ;
          copy_N--;
          index++;
          break;
        case 2: 
          copy_N--;
          index++;
          break;
        case 3:
          copy_M--;
          index++;
          break;
      }
    }
    return disparity;
  }
  
  
}
