/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package process;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.sound.sampled.AudioFormat;
import javax.sound.sampled.AudioInputStream;
import javax.sound.sampled.AudioSystem;
import javax.sound.sampled.UnsupportedAudioFileException;
import model.Database;
import java.sql.SQLException;

public class pitchtrack 
{
        public static float segment[]=new float[500];
        public static float fundfreq[]=new float[5000];//stores fundamental frequencies
        public static float avg[]=new float[500];//stores segmented note frequencies
        public static notation n=new notation();//object of notation class
        public static int i=0,k=0,f=0;
        public static String str="";
        
        
       
	public static void main(String[] agrs) throws UnsupportedAudioFileException, IOException, SQLException
	{
           
		pitchtrack.processFile("RecordAudio22.wav",PRINT_DETECTED_PITCH_HANDLER);
                segmentation();
                StoreQuery();
	}
        
       
        
        
        
        
        public static float[] segmentation()
        {
            float temp[]=new float[100];
            int i=1,cnt,j=1;
            float sum=0;
            k=0;
            while(i<fundfreq.length)
            {
                temp[0]=0;
                if(fundfreq[i]>0)
                {   
                    j=i;
                    cnt=0;
                    sum=0;
                    while(fundfreq[j]>0)
                    {
                        temp[cnt]=fundfreq[j];
                        sum=sum+temp[cnt];
                        cnt++;
                        j++;
                        //System.out.println("\t"+temp[cnt]+"\t"+cnt);
                    }
                    segment[k]=sum/cnt;
                    i=j-1;
                    System.out.println("\tavg="+segment[k]+"\t"+k);
                    k++;
                }
                i++;
            }
             str=n.matching(segment);
             //System.out.println("contour string="+str);
            return segment;
        }
        
        
        public static void deletequery() throws SQLException
        {
            try
            {
              Database db=new Database();
            Connection con=db.dataConnection();
           
            String query1="delete from query";
             PreparedStatement ps=con.prepareStatement(query1);
              boolean i=ps.execute();
              
              if(i=true)
              {
                  System.out.println("Query sucessfully deleted");
              }
              ps.close();
              con.close();
            }
            catch(Exception e)
            {
                  System.out.println("Query not deleted"+e);
            }
        }
        
       public static void StoreQuery() throws SQLException
       {
         deletequery();
           try
           {
            Database db=new Database();
            Connection con=db.dataConnection();
            String query2="insert into query values(?,?)";
            PreparedStatement ps2=con.prepareStatement(query2);
            
            ps2.setString(1,str);
            ps2.setInt(2, 2);
            System.out.println("contour string="+str);
            boolean i=ps2.execute();
              
              if(i=true)
              {
                  System.out.println("Query sucessfully insertedted");
                  f=0;
                  str="";
              }
              ps2.close();
              con.close();
           }
           catch(Exception e)
           {
               System.out.println("not inserted"+e);
           }
       }
	/**
	 * Used to start and stop real time annotations.

*/
	public static pitchtrack pitchtrackInstance;

	/**
	 * The pitchtrack threshold value (see paper)
	 */
      
	public final double threshold = 0.15;

	public final int bufferSize;
	public final int overlapSize;
	public final float sampleRate;
	/**
	 * A boolean to start and stop the algorithm.
	 * Practical for real time processing of data.
	 */
	public volatile boolean running;
	/**
	 * The original input buffer
	 */
	public final float[] inputBuffer;

	/**
	 * The buffer that stores the calculated values.
	 * It is exactly half the size of the input buffer.
	 */
	public final float[] pitchtrackBuffer;

	public pitchtrack(float sampleRate)
        {
		this.sampleRate = sampleRate;
		bufferSize = 1024;
		overlapSize = bufferSize/2;//half of the buffer overlaps
		running = true;
		inputBuffer = new float[bufferSize];
		pitchtrackBuffer = new float[bufferSize/2];
	}

    

	/**
	 * Implements the difference function as described
	 * in step 2 of the pitchtrack paper
	 */
	public void difference()
        {
		int j,tau;
		float delta;
		for(tau=0;tau < pitchtrackBuffer.length;tau++)
                {
			pitchtrackBuffer[tau] = 0;
		}
		for(tau = 1 ; tau < pitchtrackBuffer.length ; tau++)
                {
			for(j = 0 ; j < pitchtrackBuffer.length ; j++)
                        {
				delta = inputBuffer[j] - inputBuffer[j+tau];
				pitchtrackBuffer[tau] += delta * delta;
			}
		}
	}

	/**
	 * The cumulative mean normalized difference function
	 * as described in step 3 of the YIN paper
	 * <br><code>
	 * pitchtrackBuffer[0] == pitchtrackBuffer[1] = 1
	 * </code>
	 *
	 */
	public void cumulativeMeanNormalizedDifference()
        {
		int tau;
		pitchtrackBuffer[0] = 1;
		//Very small optimization in comparison with AUBIO
		//start the running sum with the correct value:
		//the first value of the yinBuffer
		float runningSum = pitchtrackBuffer[1];
		//yinBuffer[1] is always 1
		pitchtrackBuffer[1] = 1;
		//now start at tau = 2
		for(tau = 2 ; tau < pitchtrackBuffer.length ; tau++)
                {
			runningSum += pitchtrackBuffer[tau];
			pitchtrackBuffer[tau] *= tau / runningSum;//
		}
	}

	/**
	 * Implements step 4 of the YIN paper
	 */
	public int absoluteThreshold()
        {
		//Uses another loop construct
		//than the AUBIO implementation
		for(int tau = 1;tau<pitchtrackBuffer.length;tau++)
                {
			if(pitchtrackBuffer[tau] < threshold)
                        {
				while(tau+1 < pitchtrackBuffer.length && pitchtrackBuffer[tau+1] < pitchtrackBuffer[tau])
					tau++;
				return tau;
			}
		}
		//no pitch found
		return -1;
	}

	/**
	 * Implements step 5 of the YIN paper. It refines the estimated tau value
	 * using parabolic interpolation. This is needed to detect higher
	 * frequencies more precisely.
	 *
	 * @param tauEstimate
	 *            the estimated tau value.
	 * @return a better, more precise tau value.
	 */
	public float parabolicInterpolation(int tauEstimate) 
        {
		float s0, s1, s2;
		int x0 = (tauEstimate < 1) ? tauEstimate : tauEstimate - 1;
		int x2 = (tauEstimate + 1 < pitchtrackBuffer.length) ? tauEstimate + 1 : tauEstimate;
		if (x0 == tauEstimate)
			return (pitchtrackBuffer[tauEstimate] <= pitchtrackBuffer[x2]) ? tauEstimate : x2;
		if (x2 == tauEstimate)
			return (pitchtrackBuffer[tauEstimate] <= pitchtrackBuffer[x0]) ? tauEstimate : x0;
		s0 = pitchtrackBuffer[x0];
		s1 = pitchtrackBuffer[tauEstimate];
		s2 = pitchtrackBuffer[x2];
		//fixed AUBIO implementation, thanks to Karl Helgason:
		//(2.0f * s1 - s2 - s0) was incorrectly multiplied with -1
		return tauEstimate + 0.5f * (s2 - s0 ) / (2.0f * s1 - s2 - s0);
	}

	/**
	 * The main flow of the YIN algorithm. Returns a pitch value in Hz or -1 if
	 * no pitch is detected using the current values of the input buffer.
	 *
	 * @return a pitch value in Hz or -1 if no pitch is detected.
	 */
        
	public float getPitch()
        {
		int tauEstimate = -1;
		float pitchInHertz = -1;
		//step 2
		difference();

		//step 3
		cumulativeMeanNormalizedDifference();

		//step 4
		tauEstimate = absoluteThreshold();

		//step 5
		if(tauEstimate != -1)
                {
			 float betterTau = parabolicInterpolation(tauEstimate);

			//step 6
			//TODO Implement optimization for the YIN algorithm.
			//0.77% => 0.5% error rate,
			//using the data of the YIN paper
			//bestLocalEstimate()

			//conversion to Hz
                         pitchInHertz = sampleRate/betterTau;
                         
                    }               
              return pitchInHertz;
	}


	/**
	 * The interface to use to react to detected pitches.
	 * @author Joren Six
	 *
	 */
	public interface DetectedPitchHandler
        {
		/**
		 * Use this method to react to detected pitches.
		 * The handleDetectedPitch is called for every sample even when
		 * there is no pitch detected: in that case -1 is the pitch value.
		 * @param time in seconds
		 * @param pitch in Hz
		 */
		void handleDetectedPitch(float time,float pitch);
	}

	/**
	 * Annotate a file with pitch information.
	 *
	 * @param fileName
	 *            the file to annotate.
	 * @param detectedPitchHandler
	 *            handles the pitch information.
	 * @throws UnsupportedAudioFileException
	 *             Currently only WAVE files with one channel (MONO) are
	 *             supported.
	 * @throws IOException
	 *             If there is an error reading the file.
	 */
	public static void processFile(String fileName,DetectedPitchHandler detectedPitchHandler)  throws UnsupportedAudioFileException, IOException
        {
		
		AudioInputStream ais = AudioSystem.getAudioInputStream(new File(fileName));
		AudioFloatInputStream afis = AudioFloatInputStream.getInputStream(ais);
		pitchtrack.processStream(afis,detectedPitchHandler);
		segmentation();
        try {
			StoreQuery();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
        
	/**
	 * Annotate an audio stream: useful for real-time pitch tracking.
	 *
	 * @param afis
	 *            The audio stream.
	 * @param detectedPitchHandler
	 *            Handles the pitch information. If null then the annotated
	 *            pitch information is printed to <code>System.out</code>
	 * @throws UnsupportedAudioFileException
	 *             Currently only WAVE streams with one channel (MONO) are
	 *             supported.
	 * @throws IOException
	 *             If there is an error reading the stream.
	 */
	public static void processStream(AudioFloatInputStream afis,DetectedPitchHandler detectedPitchHandler) throws UnsupportedAudioFileException, IOException{
		AudioFormat format = afis.getFormat();
		float sampleRate = format.getSampleRate();
		double frameSize = format.getFrameSize();
		double frameRate = format.getFrameRate();
		float time = 0;

		//by default use the print pitch handler
		if(detectedPitchHandler==null)
			detectedPitchHandler = pitchtrack.PRINT_DETECTED_PITCH_HANDLER;

		//number of bytes / frameSize * frameRate gives the number of seconds
		//because we use float buffers there is a factor 2: 2 bytes per float?
		//Seems to be correct but a float uses 4 bytes: confused programmer is confused.
		float timeCalculationDivider = (float) (frameSize * frameRate / 2);
		long floatsProcessed = 0;
		pitchtrackInstance = new pitchtrack(sampleRate);
		int bufferStepSize = pitchtrackInstance.bufferSize - pitchtrackInstance.overlapSize;

		//read full buffer
		boolean hasMoreBytes = afis.read(pitchtrackInstance.inputBuffer,0, pitchtrackInstance.bufferSize) != -1;
		floatsProcessed += pitchtrackInstance.inputBuffer.length;
		while(hasMoreBytes && pitchtrackInstance.running) {
			float pitch = pitchtrackInstance.getPitch();
			time = floatsProcessed / timeCalculationDivider;
			detectedPitchHandler.handleDetectedPitch(time,pitch);
			//slide buffer with predefined overlap
			for(int i = 0 ; i < bufferStepSize ; i++)
				pitchtrackInstance.inputBuffer[i]=pitchtrackInstance.inputBuffer[i+pitchtrackInstance.overlapSize];
			hasMoreBytes = afis.read(pitchtrackInstance.inputBuffer,pitchtrackInstance.overlapSize,bufferStepSize) != -1;
			floatsProcessed += bufferStepSize;
		}
	}

	/**
	 * Stops real time annotation.
	 */
	public static void stop()
        {
		if(pitchtrackInstance!=null)
			pitchtrackInstance.running = false;
	}


	/**
     *
     */
    public static DetectedPitchHandler PRINT_DETECTED_PITCH_HANDLER = new DetectedPitchHandler()
        {   
		@Override
		public void handleDetectedPitch(float time, float pitch)
                {  
                            fundfreq[f]=pitch;//stores fundamental frequencies
                            f++;         
                            System.out.println("\t"+pitch+"\t"+f);
		}
                
	};	
}
