package process;

public class matchingcode {

public static int EditDistanceDP(String x, String y)
{
	
    //Object cost;
	// Cost of alignment
	//	int EDIT_COST = 0;
	int cost = 0;/*
    int leftCell, topCell, cornerCell;
 char[] X=x.toCharArray();
 char[] Y=y.toCharArray();
 
    int m = x.length()+1;
    int n = y.length()+1;
 
    // T[m][n]
    int[][] T=new int[m][n];
    
    // Initialize table
    for(int i = 0; i < m; i++)
        for(int j = 0; j < n; j++)
        	T[i][j]=0;
 
    // Set up base cases
    // T[i][0] = i
    for(int i = 0; i < m; i++)
        T[i][0]=i;
 
    // T[0][j] = j
    for(int j = 0; j < n; j++)
        T[0][j]=j;
 
    // Build the T in top-down fashion
    for(int i = 1; i < m; i++)
    {
        for(int j = 1; j < n; j++)
        {
            // T[i][j-1]
            leftCell =T[i][j-1]; 
            
			leftCell += EDIT_COST; // deletion
 
            // T[i-1][j]
            topCell =T[i-1][j]; 
            topCell += EDIT_COST; // insertion
 
            // Top-left (corner) cell
            // T[i-1][j-1]
            cornerCell =T[i-1][j-1] ;
 
            // edit[(i-1), (j-1)] = 0 if X[i] == Y[j], 1 otherwise
            if((X[i-1] != Y[j-1]))
            cornerCell +=0;
            else
            	cornerCell +=1;
            		 // may be replace
 
            // Minimum cost of current cell
            // Fill in the next cell T[i][j]
            T[i][j] = min(leftCell, topCell, cornerCell);
        }
    }
 
    // Cost is in the cell T[m][n]
    if(m<X.length && n<Y.length)
    cost = T[m][n];
	int cost=0;*/
	char[] X=x.toCharArray();
	 char[] Y=y.toCharArray();
	
	    int m =X.length;
	    int n = Y.length;
	    
	    int j=0;
	for(int k=0;k<m && j<n;k++,j++)
	{
		System.out.println(Y[j]);
		if(X[k]!=Y[j])
			cost=cost+1;
	}
    return cost;
}
 
/*private static int min(int leftCell, int topCell, int cornerCell) {
	//int flag=1;
	if(leftCell<topCell)
	{
		if(leftCell<cornerCell)
			return leftCell;
	}
	else
	{
		if(topCell<cornerCell)
			return topCell;
	}
			// TODO Auto-generated method stub
	return cornerCell;
}

*/


 
public static void main(String[] args)
{
   String X="SATURDAY";
   String Y="SUNDAY";
    System.out.println("Minimum edits required to convert" +X+"into"+Y+" is"+EditDistanceDP(X, Y)+"\n" );
   // System.out.println("Minimum edits required to convert "+X+" into "+Y+" is "+strlen(X)+strlen(Y));
 
}}