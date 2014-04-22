import java.io.*;
import java.util.ArrayList;
import java.util.Scanner;

public class Main {
	public static Scanner in = new Scanner(System.in); 
	
	public static void main(String[] args) throws IOException {
		//in = new BufferedReader(new InputStreamReader(System.in));
		
		// Get cases
		int cases = Integer.parseInt(in.nextLine());
		for(int i = 0; i < cases; i++) {
			// Get dimension info
			int gridNumRows = in.nextInt();
			int gridNumCols = in.nextInt();
                        in.nextLine();
			ArrayList<char[]> grid = new ArrayList<char[]>();
			
			// Populate with grid
			for(int j = 0; j < gridNumRows; j++) {
				grid.add(in.nextLine().toCharArray());				
			}
			
			int casualties = 0;
			for(int j = 0; j < gridNumRows; j++) {
				for(int k = 0; k < gridNumCols; k++) {
					if(grid.get(j)[k] == 'M' && (j == 0 || j == (gridNumRows - 1) || k == 0 || k == (gridNumCols - 1))) {
						casualties += 1;
					} else if(grid.get(j)[k] == 'M' && (grid.get(j+1)[k] == 'M' || grid.get(j-1)[k] == 'M' || grid.get(j)[k+1] == 'M' || grid.get(j)[k-1] == 'M')) {
						casualties += 1;
					}
				}
			}
			System.out.println(casualties);			
		}
	}
}