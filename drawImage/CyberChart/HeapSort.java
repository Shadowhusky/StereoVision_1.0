public class HeapSort {

  private int[] unsortedArray;
  public int numberOfComparison_Heap;
  
    HeapSort(int[] unsortedArray)
    {
      this.unsortedArray=unsortedArray;
    }
   
    public int[] heapSort()
    {
        int len= unsortedArray.length;
        for (int i = len/2 -1; i >= 0 ; i--) {
            numberOfComparison_Heap++;
            unsortedArray= Heapify(unsortedArray, i , len-1);
        }
        for (int i = len - 1; i > 0 ; i--) {
            numberOfComparison_Heap++;
            unsortedArray=Swap(unsortedArray, i, 0);
            unsortedArray= Heapify(unsortedArray,0, i-1);
        }
        return unsortedArray;
    }

    public int[] Heapify(int[] array, int dad, int end)
    {
        int son = dad * 2 + 1;
        numberOfComparison_Heap++;
        while(son<=end)
        {
            //Use the bigger one to compare with dad.(To ensure dad is the biggest)
            numberOfComparison_Heap++;
            if(son+1 <= end && array[son] < array[son+1])
            {
                son++;
            }
            numberOfComparison_Heap++;
            if(array[dad] >= array[son])
            {
                numberOfComparison_Heap++;
                return array;
            }
            else
            {
                numberOfComparison_Heap++;
                array=Swap(array,dad,son);
                dad=son;
                son=dad * 2 + 1;
            }
        }
        return array;
    }

    public int[] Swap(int[] array, int index_A, int index_B) {
        numberOfComparison_Heap++;
        
        int temp = array[index_A];
        array[index_A] = array[index_B];
        array[index_B] = temp;
        return array;
    }
}
