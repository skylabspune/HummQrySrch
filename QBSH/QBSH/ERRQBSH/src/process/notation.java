/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package process;
import java.lang.*;
/**
 *
 * @author pramod
 */
public class notation
{
     
    float diff1,diff2;
    public String contour="";
     String[] note=new String[500];
        int [] noterow= new int[500];  
    float [][] notefreq=new float[][]
    {
        {16.35F,17.32F,18.35F,19.45F,20.60F,21.83F,23.12F,24.50F,25.96F,27.50F,29.14F,30.87F,32.70F},
        {32.70F	,34.65F,36.71F,38.89F,41.20F,43.65F,46.25F,49.00F,51.91F,55.00F,58.27F,61.74F,65.41F},
        {65.41F,69.30F,73.42F,77.78F,82.41F,87.31F,92.50F,98.00F,103.8F,110.0F,116.5F,123.5F,130.8F},
        {130.8F,138.6F,146.8F,155.6F,164.8F,174.6F,185.0F,196.0F,207.7F,220.0F,233.1F,246.9F,261.6F},
        {261.6F	,277.2F,293.7F,311.1F,329.6F,349.2F,370.0F,392.0F,415.3F,440.0F,466.2F,493.9F,523.3F},
        {523.3F,554.4F,587.3F,622.3F,659.3F,698.5F,740.0F,784.0F,830.6F,880.0F,932.3F,987.8F,1047F},
        {1047F,1109F,1175F,1245F,1319F,1397F,1480F,1568F,1661F,1760F,1865F,1976F,2093F},
        {2093F,2217F,2349F,2489F,2637F,2794F,2960F,3136F,3322F,3520F,3729F,3951F,4186F},
        {4186F,4435F,4699F,4978F,5274F,5588F,5920F,6272F,6645F,7040F,7459F,7902F,8550F},
    };
    
    
    public static void main(String[] agrs)
    {
       
        //char[] str=new char[1000];
        
        notation n=new notation();
        float [] fq=new float[]{221.22F,121.11F,273.11F,160.62F,181.22F,191.11F,253.11F,170.22F,64.90F};
         n.matching(fq);
      // n.contour_string();
        //n.print();
        //System.out.println(" "+str);
    }
    
    
    
    public String matching(float[] a)
    {
        int i=0,j,k,cnt=0;
        String str="";
        while(i<a.length)//freq array
        {
            j=0;
            while(j<9)//row
            {   
                k=0;
                while(k<12)//col
                {
                    
                    if(a[i]>=notefreq[j][k] && a[i]<notefreq[j][k+1])
                    {
                        diff1=a[i]-notefreq[j][k];
                        diff2=notefreq[j][k+1]-a[i];
                        if(diff1<diff2)
                        {
                            
                            switch(k)
                            {
                                case 0:
                                       
                                        note[cnt]="C";
                                         noterow[cnt]=j;
                                        cnt++;
                                        
                                        //System.out.println("C");
                                        break;
                                case 1:
                                        
                                        note[cnt]="C#";
                                        noterow[cnt]=j;
                                        cnt++;
                                        
                                        //System.out.println("#");
                                        break;
                                case 2:
                                        
                                        note[cnt]="D";
                                        noterow[cnt]=j;
                                        cnt++;
                                        
                                        //System.out.println("D");
                                        break;
                                case 3:
                                        
                                        note[cnt]="Eb";
                                        noterow[cnt]=j;
                                        cnt++;
                                        
                                        //System.out.println("Eb");
                                        break;
                                case 4:
                                        
                                        note[cnt]="E";
                                        noterow[cnt]=j;
                                        cnt++;
                                        
                                        //System.out.println("E");
                                        break;
                                case 5:
                                        
                                            note[cnt]="F";
                                            noterow[cnt]=j;
                                            cnt++;
                                        
                                        //System.out.println("F");
                                        break;
                                case 6:
                                        
                                        note[cnt]="F#";
                                        noterow[cnt]=j;
                                        cnt++;
                                        
                                        //System.out.println("F#");
                                        break;
                                case 7:
                                        
                                        note[cnt]="G";
                                        noterow[cnt]=j;
                                        cnt++;
                                       
                                        //System.out.println("G");
                                        break;
                                case 8:
                                        
                                        note[cnt]="G#";
                                        noterow[cnt]=j;
                                        cnt++;
                                        
                                        //System.out.println("G#");
                                        break;
                                case 9:
                                        
                                            note[cnt]="A";
                                            noterow[cnt]=j;
                                            cnt++;
                                        
                                        //System.out.println("A");
                                        break;
                                case 10:
                                        
                                            note[cnt]="Bb";
                                            noterow[cnt]=j;
                                            cnt++;
                                        
                                        //System.out.println("Bb");
                                        break;
                                case 11:
                                        
                                            note[cnt]="B";
                                            noterow[cnt]=j;
                                            cnt++;
                                        
                                        //System.out.println("B");
                                        break;
                           
                            }//end switch
                        }
                        /*
                        if(note[cnt-1]!="C")
                                        {
                                            note[cnt]="C";
                                            noterow[cnt]=j;
                                            cnt++;
                                        }*/
                                        
                        else
                        {
                           
                            switch(k+1)
                            {
                                case 0:
                                         
                                            note[cnt]="C";
                                            noterow[cnt]=j;
                                            cnt++;
                                        
                                        //System.out.println("C");
                                        break;
                                case 1:
                                        
                                        note[cnt]="C#";
                                        noterow[cnt]=j;
                                        cnt++;
                                        
                                        //System.out.println("#");
                                        break;
                                case 2:
                                        
                                            note[cnt]="D";
                                        noterow[cnt]=j;
                                        cnt++;
                                        
                                        //System.out.println("D");
                                        break;
                                case 3:
                                        
                                        note[cnt]="Eb";
                                        noterow[cnt]=j;
                                        cnt++;
                                        
                                        //System.out.println("Eb");
                                        break;
                                case 4:
                                     
                                        note[cnt]="E";
                                        noterow[cnt]=j;
                                        cnt++;
                                        
                                        //System.out.println("E");
                                        break;
                                case 5:
                                        
                                        note[cnt]="F";
                                        noterow[cnt]=j;
                                        cnt++;
                                        
                                        //System.out.println("F");
                                        break;
                                case 6:
                                        
                                        note[cnt]="F#";
                                        noterow[cnt]=j;
                                        cnt++;
                                        
                                        //System.out.println("F#");
                                        break;
                                case 7:
                                    
                                        note[cnt]="G";
                                        noterow[cnt]=j;
                                        cnt++;
                                    
                                        //System.out.println("G");
                                        break;
                                case 8:
                                        
                                        note[cnt]="G#";
                                        noterow[cnt]=j;
                                        cnt++;
                                        
                                        //System.out.println("G#");
                                        break;
                                case 9:
                                        
                                        note[cnt]="A";
                                        noterow[cnt]=j;
                                        cnt++;
                                        
                                        //System.out.println("A");
                                        break;
                                case 10:
                                        
                                        
                                        note[cnt]="Bb";
                                        noterow[cnt]=j;
                                        cnt++;
                                        
                                        //System.out.println("Bb");
                                        break;
                                case 11:
                                        
                                        note[cnt]="B";
                                        noterow[cnt]=j;
                                        cnt++;
                                        
                                        //System.out.println("B");
                                        break;
                                case 12:
                                        
                                        note[cnt]="C";
                                        noterow[cnt]=j+1;
                                        cnt++;
                                       
                                        //System.out.println("C");
                                        break;
                            }
                        
                        }
                    }//endif
                    k++;
                }//end k while
                j++;
            }//end j while
             System.out.println(i+"\t"+cnt+"\t"+"\t"+note[i]+""+ noterow[i]+"\t"+a[i]);
            i++;
        } //end i while         
       str=contour_string();
       return str;
    }  
    
    
   
    
    String contour_string()
    {
        //String ch=null;
        int s=0,dif;
        contour="";
        int[] col=new int[1000];
        while(note[s]!=null)
        { 
            
            switch(note[s])
            {
                case "C":
                    col[s]=0;
                break;
                case "C#":
                    col[s]=1;
                break;
               case "D":
                    col[s]=2;
                break;
                case "Eb":
                    col[s]=3;
                break;
                case "E":
                    col[s]=4;
                break;
                case "F":
                    col[s]=5;
                break;
                case "F#":
                    col[s]=6;
                break;    
                case "G":
                    col[s]=7;
                break;
                case "G#":
                    col[s]=8;
                break;
                case "A":
                    col[s]=9;
                break;
                case "Bb":
                    col[s]=10;
                break;
                case "B":
                    col[s]=11;
                break;
                    
            }
       // System.out.println("\n col"+col[s]);
        //System.out.println("\n row"+noterow[s]);
         s++;
        
        }     
        
        int r=0;
        int c=0;
        while(note[r]!=null)
        { 

         if(noterow[r]==noterow[r+1]  )
         {
             contour =contour+" "+(col[r+1]-col[r]);
         }
         else
         {
             if(col[r]==col[r+1] )
             {      
                dif=noterow[r+1]-noterow[r];
                contour=contour+" "+((12*dif)-1);
             }
             if(col[r]!=col[r+1])
             {
                dif=noterow[r+1]-noterow[r];
                contour=contour+" "+(((12*dif)-1)+(col[r+1]-col[r]));
                
             }
         }
        
        r++;        } System.out.println("\n"+contour);
        return contour;
    }//end of countrer_string
}
