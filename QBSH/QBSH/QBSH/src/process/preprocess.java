package process;
import process.pitchtrack;
public class preprocess {

	   static  pitchtrack p;
	    public static void processquery()
	    {
	     try 
	        {
	            pitchtrack.processFile("D:/Recording/RecordAudio3.WAV",pitchtrack.PRINT_DETECTED_PITCH_HANDLER);
	            pitchtrack.segmentation();
	            pitchtrack.StoreQuery();
	        } 
	        catch(Exception e)
	        {            
	            System.out.println("Not processed"+e);
	        }
	    }
}
