package grafy;

import java.util.*;



public class topologicalSort{
	
	public static LinkedList<Integer> sortAdjList(LinkedList<Integer>[] adjList, int n){
		LinkedList<Integer> L = new LinkedList();
		boolean visited[] = new boolean[n];
		for(int i = 0; i < n; i++) visited[i] = false;
		
		for(int i = 0; i < n; i++){
			if (!visited[i]) topologicalSortAdjListUtil(i, visited, L, adjList);
		}
		return L;
	}
	static void topologicalSortAdjListUtil(int v, boolean visited[], LinkedList<Integer> L, LinkedList<Integer>[] adjList){
		
		visited[v] = true;
		Integer i;
		
		Iterator<Integer> it  = adjList[v].iterator();
		
		while(it.hasNext()){
			i = it.next();
			if(!visited[i]){
				topologicalSortAdjListUtil(i, visited, L, adjList);
			}	
		}
		L.offerFirst(new Integer(v));
	}
	public static LinkedList<Integer> sortAdjMatrix(int[][] matrix){
		
		LinkedList<Integer> L = new LinkedList();
		int n = matrix[0].length;
		boolean visited[] = new boolean[n];
		for(int i = 0; i < n; i++) visited[i] = false;
		
		for(int i = 0; i< n; i++){
			if(!visited[i]) topologicalSortAdjMatrixUtil(i, visited, L, matrix, n);
		}
		return L;
	}
	
	static void topologicalSortAdjMatrixUtil(int v, boolean visited[], LinkedList<Integer> L, int[][] matrix, int n){
		
		visited[v] = true;
		//Integer i;
		
		for(int j = 0; j < n; j++){
				if(matrix[v][j] == 1 && !visited[j]){
					topologicalSortAdjMatrixUtil(j, visited, L, matrix, n);
				}
		}
		L.offerFirst(new Integer(v));

	}
}


