package grafy;

import java.util.concurrent.ThreadLocalRandom;
import java.util.*;

public class dagGenerator {
	
	public static int[][] genere(int precentageOfEdges, int n){
		int[][] A = new int[n][n];

		for(int i = 0; i < n; i++){
			for (int j = 0; j < n; j++) A[i][j] = 0;
		}
		

//		for(int i = 0; i < n-1; i++){
//			int x = ThreadLocalRandom.current().nextInt(i+1, n);
//			A[i][x] = 1;
//		}
		
		int countEdges = 0;
		int edgesInFullDAG = n*(n-1)/2;
		
		int k = 0;
		
		int[] tab = new int[edgesInFullDAG];
		for(int i = 0; i < edgesInFullDAG; i++) tab[i] = i+1;
		dagGenerator.shuffleArray(tab);		
		while (countEdges < precentageOfEdges*edgesInFullDAG/100 ){
			int x = tab[k];
			int i = n - dagGenerator.calculateCords(x)[0] -1; int j = n - dagGenerator.calculateCords(x)[1]  ;
			if (A[i][j] == 0) { A[i][j] = 1; countEdges++; }
			k++;
		}			
		int[] perm = new int[n];
		for (int i = 0; i < n; i++){
			perm[i] = i;
		}
		dagGenerator.shuffleArray(perm);
		
		int[][] B = new int[n][n];
		for (int i = 0; i < n; i++){
			for (int j = 0; j < n; j++){
				B[i][j] = A[perm[i]][perm[j]];
			}
		}
		return B;
	}
	
	public static int[] calculateCords(int rand){
		int count = 1, i = 1, j=1;
		while (count + i <= rand){
			count += i;
			i++;
		}
		while (count < rand){
			count =count + 1;
			j++;
		}
		int[] cords = {i,j};
		return cords;
	}
	
	public static void shuffleArray(int[] array)
	{
	    int index, temp;
	    Random random = new Random();
	    for (int i = array.length - 1; i > 0; i--)
	    {
	        index = random.nextInt(i + 1);
	        temp = array[index];
	        array[index] = array[i];
	        array[i] = temp;
	    }
	}	
}
 