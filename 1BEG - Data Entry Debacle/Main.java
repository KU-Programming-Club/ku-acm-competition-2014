import java.io.*;

public class Main {
	public static BufferedReader in;
	
	public static void main(String[] args) throws IOException {
		in = new BufferedReader(new InputStreamReader(System.in));
		
		int lines = Integer.parseInt(in.readLine());
		String number;
		for(int i = 0; i < lines; i++) {
			number = in.readLine();
			if(number.length() == 9) {
				System.out.println(number.substring(0,3) + "1" + number.substring(3));
			} else {
				System.out.println(number);
			}
		}
	}
}