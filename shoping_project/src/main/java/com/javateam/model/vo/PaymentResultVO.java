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
	
	private int num; // complNum
	private String subject; // cmoplSubject
	private int payment; // sum(order_count*board_price)
    
	
}
