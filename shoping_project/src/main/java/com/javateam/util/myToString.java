/**
 * 
 */
package com.javateam.util;

/**
 * @author ss
 *
 */
public class myToString {
	
	  public String ObjToString(Object p){
		  
		   String strRef = "";
	
		   if (p == null)
		   {
		    strRef = "";
		   }
		   else
		   {
		    strRef = p.toString();
		   }
	
		   return strRef;
	  }


}
