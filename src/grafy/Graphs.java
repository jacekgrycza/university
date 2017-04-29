package grafy;

import java.util.*;

public class Graphs {

	
	public static void main (String args[]){
		
		final long div = 1000000000;
		final int SKOK = 500;
		final int numOfSeries = 16;
		int[][] A;
		long start, stop;
		double time1, time2;
		LinkedList<Integer>[] adj;
		LinkedList<Integer> sorted;
		LinkedList<Integer> sorted2;
		System.out.println("n,list, matrix");
		for(int i = 0; i < numOfSeries; i++){
			
			A = dagGenerator.genere(90,(i+1)*SKOK);
			adj = adjacencylist.createGraph(A);
			start = System.nanoTime(); 
			sorted = topologicalSort.sortAdjList(adj, (i+1)*SKOK);
			stop = System.nanoTime();
			time1 = (double)(stop-start)/div;
			
			start = System.nanoTime(); 
			sorted2 = topologicalSort.sortAdjMatrix(A);
			stop = System.nanoTime();
			time2 = (double)(stop-start)/div;
			System.out.println((i+1)*SKOK+","+time1+","+time2);
			
			
		}
//		int n = 2000;
//		int[][] A = dagGenerator.genere(60,n);

//		for(int i = 0; i < n; i++){
//			for (int j = 0; j < n; j++){
//				System.out.print(A[i][j]);
//			}
//			System.out.println();	
//		}
//		LinkedList<Integer>[] adj = adjacencylist.createGraph(A);

//		for(int i = 0; i < n; i++){
//			System.out.print(i+":");
//			Iterator<Integer> it = adj[i].iterator();
//			while(it.hasNext()) System.out.print(it.next());
//			System.out.println();
//		}
//		long start = System.nanoTime(); 

//		LinkedList<Integer> sorted = topologicalSort.sortAdjList(adj, n);
//		long stop = System.nanoTime();
//		double time = (double)(stop-start)/div;
//		System.out.println(time);
//		Iterator<Integer> it = sorted.iterator();
//		//while(it.hasNext()) System.out.println(it.next());
//		start = System.nanoTime();
		//LinkedList<Integer> sorted2 = topologicalSort.sortAdjMatrix(A);
//		stop = System.nanoTime();
//		time = (double)(stop-start)/div;
//		System.out.println(time);
//		Iterator<Integer> it2 = sorted2.iterator();
		//while(it2.hasNext()) System.out.println(it2.next());
		
	}
	
}
