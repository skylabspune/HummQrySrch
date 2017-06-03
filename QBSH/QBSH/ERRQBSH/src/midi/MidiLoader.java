package midi;
import javax.sound.midi.*;

import model.Database;

import java.io.*;
//import java.net.URL;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Arrays;
import model.*;


public class MidiLoader {
    public String str1;

	public static String u;
    
	public static void main(String[] args){
	//	u=new String("C:/tw.mid");
		//File f=new File(u);
	//	System.out.println(u);
	//	MidiLoader m=new MidiLoader(u);
		//m.getStr1();
		//System.out.println(m.str1);
		}
	
		public String getStr1() {
			System.out.print(str1);
		return str1;
	}



	public void setStr1(String str1) {
		this.str1 = str1;
	}

		/**

		*loads a midi file from disk and stores all notes in a nested Array List, using the Helper class "Note"

		* needs some cleanup though

		*/

		  ArrayList<ArrayList<Note>> tracks;

		  long maxTicks = 0;

		  final boolean DO_PRINT = false;

		 
          int [] pitch1=new int[800];
          int x = 0;
		  public MidiLoader(String fileName,String song) {
//System.out.println("\nFile: "+fileName);
			  System.setProperty("dir", "D:/song");
			 // System.out.println("construct");
				
		    //Notes are stored in this nested array list to mirror the track-note structure (depending on type of midi file)

		    tracks = new ArrayList<ArrayList<Note>>();

		    Track[] trx;

		 

		    try  	
		    {
			 	FileInputStream fis=new FileInputStream(fileName);	
		      Sequence mySeq = MidiSystem.getSequence(fis);

		      trx = mySeq.getTracks();

		 

		      for (int i = 0; i < trx.length; i++) {

		        ArrayList<Note> trackAsList = new ArrayList<Note>();

		        tracks.add(trackAsList);

		        Track t = trx[i];

		         

		          System.out.println("track ");

		          System.out.println("length:"+ t.ticks());

		          System.out.println("num events:" + t.size());

		        
		        
		        int counter = 0;

		        //iterate over the vector, and remove each handled event.

		        while (t.size () > 0 && counter < t.size()) {

		          counter ++;

		          if (t.get(0).getMessage() instanceof ShortMessage) {

		 

		            ShortMessage s = (ShortMessage)(t.get(0).getMessage());

		            //find note on events

		            if (s.getCommand() == ShortMessage.NOTE_ON) 
		            {

		              
		             System.out.print( s.getData1()+"\t");              
		           
		             
		              long startTime = t.get(0).getTick();

		              long endTime = 0;

		              int ch = s.getChannel();

		              int pitch = s.getData1();

		              int vel = s.getData2();

		              
pitch1[x]=s.getData1();
x++;

		//if the first note has zero velocity (== noteOff), remove it

		              if (vel == 0) {

		                t.remove(t.get(0));

		              } 

		              

		              else {

		                //start to look for the associated note off

		                for (int j = 0; j < t.size(); j++) {

		                  if (t.get(j).getMessage() instanceof ShortMessage) {

		                    ShortMessage s2 = (ShortMessage)(t.get(j).getMessage());

		                    //two types to send a note off... either as a clean command or as note on with 0 velocity

		                    if ((s2.getCommand() == ShortMessage.NOTE_OFF) || s2.getCommand() == ShortMessage.NOTE_ON) {

		                      //compare to stored values, sending a note off with same channel and pitch means to stop the note

		                      if (s2.getChannel() == ch && s2.getData1() == pitch && s2.getData2() == 0) {

		                        //calculate note duration

		                        endTime = t.get(j).getTick();

		                        //extend maxticks, so we know when the last midi event happened (sometimes tracks are much longer than the last note

		                        if (endTime > maxTicks)maxTicks = endTime;

		                        //create a new "Note" instance, store it

		                        Note n = new Note(startTime, endTime-startTime, ch, vel, pitch);

		                        trackAsList.add(n);

		                        t.remove(t.get(0));

		                        break;

		                      }

		                    }

		                  }

		                }

		              }

		              //remove event when done

		              t.remove(t.get(0));

		            }

		            else {

		              //remove events which are shortmessages but not note on (e.g. control change)

		              t.remove(t.get(0));

		            }

		          } 

		          else {

		            //remove events which are not of type short message

		            t.remove(t.get(0));

		          }

		        }

		      }
		      			
		    }

		    		    catch (Exception e) {

		      e.printStackTrace();

		    }
		    finally
		    {
		    	/*for(int k=0;k<x;k++)
				    System.out.print(pitch1[k]+"\t");
		      */
		      int [] contour=new int [x];
		      for(int y=0;y<x;y++)
		      {
		    	  
		    	  contour[y]=pitch1[y+1]-pitch1[y];
		    	  
		      }
		      System.out.println("Size:"+x); 
		      	System.out.print("\nContour String\n");
		      /*for(int k=0;k<x-2;k++)
				    System.out.print(contour[k]+"\t");
		      */
		      
		      StringBuffer sbufNumbers= new StringBuffer();
		      String strSeparator="";
		      if(contour.length>0)
		      {
		    	  
		    	  sbufNumbers.append(contour[0]);
		    	  for(int p1=1;p1<contour.length;p1++)
		    	  {
		    		  
		    		  sbufNumbers.append(strSeparator).append(contour[p1]);
		    	  }
		      }
		      
	str1=Arrays.toString(contour);
		      str1 =str1.replaceAll(",",strSeparator).replace("[","").replace("]","");
		      
		      Database db=new Database();
				Connection con=db.dataConnection();
				Statement stmt;
				
				try {
					stmt = con.createStatement();
				
System.out.println("\nDb");
				
				
				
				//long length=song.length();
				//int l =(int) length;
				//byte[] data=new byte[l];
/* String remString=song;
char[] ch1= remString.toCharArray();
char[] ch=song.toCharArray();

int s=0,i=0,j=ch.length;
       
				for(s=8;s<ch.length;s++)
				{
			
					ch1[i]=ch[s];
					i++;
						
				}
				remString=new String(ch1);*/
					 String stmts="Update song SET contour= ? where songtitle= '"+song+"' ";
					
					 System.out.println(stmts);
					 PreparedStatement ps=con.prepareStatement(stmts);
					 ps.setString(1, str1);
					 //ps.setString(2, remString);
					 
					int l= ps.executeUpdate();
					if(l!=0)
						System.out.println(l);
					else
						System.out.println(l);
					 ps.close();
					 con.close();
					
				}
				catch(Exception e)
				{
			System.out.println("\n"+e);
				}


			//System.out.print("\n\n"+str1+"\n\n");
			
		    
		    }

		  }

		 

		ArrayList<Note> trackAsArrayList(int i) {

		    return tracks.get(i);

		    // return null;

		  }

		  int numTracks() {

		    return tracks.size();

		  }

		}

		 

		/**

		*Helper Class Note, stores start time, end time, channel, pitch and duration

		*/

		class Note {

		  long start;

		  long duration;

		  int channel;

		  int velocity;

		  int pitch;

		 

		  Note(long theStart, long theDuration, int theChannel, int theVelocity, int thePitch) {

		    start = theStart;

		    channel = theChannel;

		    pitch = thePitch;

		    velocity = theVelocity;

		    duration = theDuration;

		  }


		}



