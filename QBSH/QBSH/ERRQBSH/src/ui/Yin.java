
package ui;



import java.io.File;
import model.Database;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Statement;

import javax.sound.sampled.AudioFormat;
import javax.sound.sampled.AudioInputStream;
import javax.sound.sampled.AudioSystem;
import javax.sound.sampled.UnsupportedAudioFileException;


/**
 * @author Joren Six
 *An implementation of the YIN pitch tracking algorithm.
 *See <a href="http://recherche.ircam.fr/equipes/pcm/cheveign/ps/2002_JASA_YIN_proof.pdf">the YIN paper.</a>
 *
 *Implementation originally based on <a href="http://aubio.org">aubio</a>
 *
 *
 */




public class Yin 
{
        static float constr[]=new float[4000]; 
        static notation n=new notation();
        static String str[]=new String[4000];
        float p1=0,cs=0;
        int i=0;
        static int[] tym=new int[4000];
        
       
	public static void main(String[] agrs) throws UnsupportedAudioFileException, IOException
	{
		System.out.println("\nPitch detected");           
		String n1=Yin.processFile("D:/Recording/RecordAudiotw2.wav",PRINT_DETECTED_PITCH_HANDLER);
		//Yin.processFile("C:/00014.wav",PRINT_DETECTED_PITCH_HANDLER);
		int j=0;
	
		//notes();
		System.out.println("\nContour String: size"+n1);    
         
                
	}
	/**
	 * Used to start and stop real time annotations.
	 * @return 

*/
	public static float[] segmentation(float[] constrs)
	{
		float[] segment = new float[constrs.length];
		
		float dif=0.f;
		int c,z=0,cnt=0,s=0;
		float avg=0;
		System.out.println("call2");
		while((z<=constrs.length))
		{
			System.out.println(z);
			float[] sum = new float[30];
			if(z!=0)
				z=z+1;
			do
		{
			if((z+1)!=constrs.length)
			{	
			dif=constrs[z+1]-constrs[z];
			if(dif<=4)
			{	
				
			sum[s]=constrs[z];s++;z++;}}
		}while(dif==0);
		for(int av=0;av<sum.length;av++)
			avg=avg+sum[av];
		if(s!=0)
		{avg=avg/s;System.out.println("\t"+avg);
		
		segment[cnt]=avg;
		cnt++;}
		else
			{if(z!=constr.length) segment[cnt]=constrs[z];cnt++;}
		//System.out.println(z);
		s=0;avg=0;
		}
		   System.out.println("\nContour String: size");
		return segment;
		
	}
	public static String notes()
	{
		//System.out.println("\nContour String: size"+j);  
		System.out.println("call1");
      float[] seg =segmentation(constr);
	//	n.matching(constr);
       System.out.println("\nContour String: size");
        String savecont=n.matching(seg);
       
return savecont;
        	}
	private static Yin yinInstance;

	/**
	 * The YIN threshold value (see paper)
	 */
      
	private final double threshold = 0.01;

	private final int bufferSize;
	private final int overlapSize;
	private final float sampleRate;
	/**
	 * A boolean to start and stop the algorithm.
	 * Practical for real time processing of data.
	 */
	private volatile boolean running;

	/**
	 * The original input buffer
	 */
	private final float[] inputBuffer;

	/**
	 * The buffer that stores the calculated values.
	 * It is exactly half the size of the input buffer.
	 */
	private final float[] yinBuffer;

	public Yin(float sampleRate)
        {
		this.sampleRate = sampleRate;
		bufferSize = 1024;
		overlapSize = bufferSize/2;//half of the buffer overlaps
		running = true;
		inputBuffer = new float[bufferSize];
		yinBuffer = new float[bufferSize/2];
	}

	/**
	 * Implements the difference function as described
	 * in step 2 of the YIN paper
	 */
	private void difference()
        {
		int j,tau;
		float delta;
		for(tau=0;tau < yinBuffer.length;tau++)
                {
			yinBuffer[tau] = 0;
		}
		for(tau = 1 ; tau < yinBuffer.length ; tau++)
                {
			for(j = 0 ; j < yinBuffer.length ; j++)
                        {
				delta = inputBuffer[j] - inputBuffer[j+tau];
				yinBuffer[tau] += delta * delta;
			}
		}
	}

	/**
	 * The cumulative mean normalized difference function
	 * as described in step 3 of the YIN paper
	 * <br><code>
	 * yinBuffer[0] == yinBuffer[1] = 1
	 * </code>
	 *
	 */
	private void cumulativeMeanNormalizedDifference()
        {
		int tau;
		yinBuffer[0] = 1;
		//Very small optimization in comparison with AUBIO
		//start the running sum with the correct value:
		//the first value of the yinBuffer
		float runningSum = yinBuffer[1];
		//yinBuffer[1] is always 1
		yinBuffer[1] = 1;
		//now start at tau = 2
		for(tau = 2 ; tau < yinBuffer.length ; tau++)
                {
			runningSum += yinBuffer[tau];
			yinBuffer[tau] *= tau / runningSum;//
		}
	}

	/**
	 * Implements step 4 of the YIN paper
	 */
	private int absoluteThreshold()
        {
		//Uses another loop construct
		//than the AUBIO implementation
		for(int tau = 1;tau<yinBuffer.length;tau++)
                {
			if(yinBuffer[tau] < threshold)
                        {
				while(tau+1 < yinBuffer.length && yinBuffer[tau+1] < yinBuffer[tau])
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
	private float parabolicInterpolation(int tauEstimate) 
        {
		float s0, s1, s2;
		int x0 = (tauEstimate < 1) ? tauEstimate : tauEstimate - 1;
		int x2 = (tauEstimate + 1 < yinBuffer.length) ? tauEstimate + 1 : tauEstimate;
		if (x0 == tauEstimate)
			return (yinBuffer[tauEstimate] <= yinBuffer[x2]) ? tauEstimate : x2;
		if (x2 == tauEstimate)
			return (yinBuffer[tauEstimate] <= yinBuffer[x0]) ? tauEstimate : x0;
		s0 = yinBuffer[x0];
		s1 = yinBuffer[tauEstimate];
		s2 = yinBuffer[x2];
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
        
	private float getPitch()
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
                         p1=pitchInHertz;
                         if(p1!=-1)
                         {
                             constr[i]=p1;
                             i++;
                         }
                    }               
		//return pitchInHertz;
                //System.out.println(i+"\t"+cs);
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
	 * @return 
	 * @throws UnsupportedAudioFileException
	 *             Currently only WAVE files with one channel (MONO) are
	 *             supported.
	 * @throws IOException
	 *             If there is an error reading the file.
	 */
	public static String processFile(String fileName,DetectedPitchHandler detectedPitchHandler)  throws UnsupportedAudioFileException, IOException
        {
		fileName="D:/Recording/RecordAudiotw.wav";
		//fileName="C:/00014.wav";

		AudioInputStream ais = AudioSystem.getAudioInputStream(new File(fileName));
		AudioFloatInputStream afis = AudioFloatInputStream.getInputStream(ais);
		Yin.processStream(afis,detectedPitchHandler);
	
	String cont=notes();
		return cont;
		
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
			detectedPitchHandler = Yin.PRINT_DETECTED_PITCH_HANDLER;

		//number of bytes / frameSize * frameRate gives the number of seconds
		//because we use float buffers there is a factor 2: 2 bytes per float?
		//Seems to be correct but a float uses 4 bytes: confused programmer is confused.
		float timeCalculationDivider = (float) (frameSize * frameRate / 2);
		long floatsProcessed = 0;
		yinInstance = new Yin(sampleRate);
		int bufferStepSize = yinInstance.bufferSize - yinInstance.overlapSize;

		//read full buffer
		boolean hasMoreBytes = afis.read(yinInstance.inputBuffer,0, yinInstance.bufferSize) != -1;
		floatsProcessed += yinInstance.inputBuffer.length;
		while(hasMoreBytes && yinInstance.running) {
			float pitch = yinInstance.getPitch();
			time = floatsProcessed / timeCalculationDivider;
			detectedPitchHandler.handleDetectedPitch(time,pitch);
			//slide buffer with predefined overlap
			for(int i = 0 ; i < bufferStepSize ; i++)
				yinInstance.inputBuffer[i]=yinInstance.inputBuffer[i+yinInstance.overlapSize];
			hasMoreBytes = afis.read(yinInstance.inputBuffer,yinInstance.overlapSize,bufferStepSize) != -1;
			floatsProcessed += bufferStepSize;
		}
	}

	/**
	 * Stops real time annotation.
	 */
	public static void stop()
        {
		if(yinInstance!=null)
		
			yinInstance.running = false;
	}


	/**
     *
     */
    public static DetectedPitchHandler PRINT_DETECTED_PITCH_HANDLER = new DetectedPitchHandler()
        {
            int j=0;
		@Override
		public void handleDetectedPitch(float time, float pitch)
                {   
                 
                    
                     if(pitch!=-1)
                     {
                    	 float dif=pitch-constr[j];
                    	// System.out.println(dif+"\n");
                    	// if(dif>4)
                    	 { constr[j]=pitch; tym[j]=(int) time;
                         System.out.println("\n"+constr[j]+"\t"+time);
                         j++;}
                     }
                     //n.matching(constr);
                    //System.out.println(" "+pitch);
		}

	};	
}
