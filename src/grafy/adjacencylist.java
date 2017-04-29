package grafy;

import java.util.*;


public class adjacencylist{
	
	public static LinkedList<Integer>[] createGraph(int[][] A){
		
		int n = A.length;
		
		LinkedList<Integer>[] adj = new LinkedList[n];
		
		for(int i = 0; i < n; i++){
			if (adj[i] == null) {
				adj[i] = new LinkedList<Integer>();
			}
			for (int j = 0; j < n; j++){
				if(A[i][j]==1) adj[i].add(j);
			}
		}
		return adj;
	}
}
