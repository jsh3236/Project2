/**
 * 
 */
package com.javateam.util;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * @author ss
 *
 */
public class myToString {
	
	public List<Object[]> toList(Object[] arr) {
	       
	        List<Object[]> list = new ArrayList<>();
	       
	        String temp = Arrays.deepToString(arr);
	        Object[] objArr = temp.split("\\],");
	        String [] tempArr = new String[arr.length];
	       
	        for (int i=0; i<arr.length; i++) {
	            tempArr[i] = objArr[i].toString();
	           
	            Object[] obj = tempArr[i].replaceAll("\\[", "")
	                                     .replaceAll("\\]", "")
	                                     .trim()
	                                     .split("\\,");
	            list.add(obj);
	        } // for
	       
	        return list;
	    } //

}
