/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
//package Mine;

import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.util.Arrays;

/**
 *
 * @author USER
 */
public class FreqCount {

    public static void main(String[] args) {
        try {
            String str = "6 -15 18 -73 ";
            String strLine;
            String data = "";
            FileInputStream fstream1 = new FileInputStream("C:/Users/windows/Desktop/eclipseface/New folder/New folder/data.txt");   // Get the object of FileInputStream
            DataInputStream in1 = new DataInputStream(fstream1);               // Get the object of DataInputStream
            @SuppressWarnings("resource")
            BufferedReader br1 = new BufferedReader(new InputStreamReader(in1));    // Get the object of BufferedReader

            while ((strLine = br1.readLine()) != null) { //Till not end Line
                data += strLine + "\n";
            }
            String[] strsplit = str.split(" ");
            /*for (int i = 0; i < strsplit.length; i++) {
             System.out.println(strsplit[i]);                
             }*/
            

            String[] datas = data.split("\n");
            int freq[][] = new int[datas.length][strsplit.length];
            int iarr[]= new int[datas.length];
            int iarr1[]= new int[datas.length];
            int co[]=new int [datas.length];
            for (int i = 0; i < datas.length; i++) {
                System.out.println(datas[i]); 
                String[] datassplit = datas[i].split(" ");
                for (int j = 0; j < datassplit.length; j++) {
                    //System.out.println(datassplit[j]);
                    for (int k = 0; k < strsplit.length; k++) {
                        if (datassplit[j].equals(strsplit[k])) {
                            freq[i][k]++;
                            co[i]++;
                        }
                    }
                    
                }
            }
            int count=0;
            System.out.println("======================");
            System.out.println(Arrays.toString(strsplit));
            for (int i = 0; i < freq.length; i++) {
                for (int j = 0; j < freq[0].length; j++) {
                    if (freq[i][j]>0) {
                        count++;
                    }
                    
                }
                iarr[i]=count;
                iarr1[i]=count;
                System.out.println(i+1+" "+Arrays.toString(freq[i])+" and count is "+iarr[i]+"   "+co[i]);
                count=0;
            }
            count=0;
            //int selected[]= new int[3];
            Arrays.sort(iarr);
            int temp=0;
           /* for (int i = iarr.length-1; i > 0; i--) {
                temp=iarr[i];
                if (count==3) {
                    break;
                }
                if (temp==iarr[i-1]) {
                    i--;
                    //System.out.println(iarr[i]);
                    selected[count]=iarr[i];
                    count++;
                }
                
            }*/
            for (int i = 0; i < iarr.length; i++) {
				System.out.println(iarr[i]);
			}
            /*System.out.println("==============");
            for (int i = 0; i < selected.length; i++) {
                System.out.println(selected[i]);
                System.out.println("::::::::::::::::::::::::::::::::::::::::");
                for (int j = 0; j < iarr.length; j++) {
                    if (selected[i]==iarr1[j]) {
                        System.out.println(datas[j]);
                    }
                }
                System.out.println("::::::::::::::::::::::::::::::::::::::::::::");
            }*/
            for (int i = iarr.length-1; i > iarr.length-10; i--) {
				for (int j = 0; j < iarr1.length; j++) {
					if (iarr[i]==iarr1[j]) {
						System.out.println(datas[j]);
					}
				}
			}
            
            

        } catch (Exception e) {
            System.out.println(e);
        }
    }
}
