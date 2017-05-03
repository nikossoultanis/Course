import java.io.*;
import java.util.*;

public class FileReading {
	public static void main(String[] args) throws Exception{ 
	File src = new File ("src.txt");
	long srcBytes = src.length();
	
	if (!src.exists())
	{
		 throw new FileNotFoundException("src.txt has not been found");
	}
		File output = new File("output.txt");
		if(output.exists())
		{
			output.delete();
		}
		
		output.createNewFile();
	    int spaces = 0;
	    long outInitial = output.length();
	    FileReader reader = new FileReader(src); //Read streams of character not raw bytes.
	    BufferedReader bufferedReader = new BufferedReader(reader);
	    String contents = "";
	    String line ;
	    
	    while ((line = bufferedReader.readLine()) != null){
	        contents += line + "\n\n";
	    }
	    for (char gap : contents.toCharArray()) {  //convert the string to char array.
	        if (gap == ' ') {
	            spaces++;
	        }
	    }
	    	
	    	contents = contents.replaceAll(" ", "@");
	        bufferedReader.close();
	        FileWriter writer = new FileWriter(output); 
	        writer.write(contents); 
	        writer.flush();
	        writer.close();
	        long outFinal = output.length();
	            System.out.println("Spaces: " + spaces);
	            System.out.println("The number of bytes is: " + srcBytes);
	            System.out.println("Initial Out: " + outInitial);
	            System.out.println("Final Out: " + outFinal);
	    }
	}

