/**
 * 
 */
package com.javateam.model.vo;


import lombok.Data;


/**
 * @author ss
 *
 */
@Data
public class PaymentResultVO{
	
	private int num; // 
	private String subject;
	private int payment;
    
	public PaymentResultVO(Object o) {
		String arr [] = o.toString()
                .replace('[',' ')
                .replace(']',' ')   
                .trim()
                .split(",");
		
		this.num = new Integer(arr[0]);
		this.subject = arr[1];
		this.payment = new Integer(arr[2]);
	}
	
}
