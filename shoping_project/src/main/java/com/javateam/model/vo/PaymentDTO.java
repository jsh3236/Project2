/**
 * 
 */
package com.javateam.model.vo;

import java.util.Date;

import lombok.Data;

/**
 * @author ss
 *
 */
@Data
public class PaymentDTO {
	private int paymentNum;
	private String paymentName;
	private String paymentAddress;
	private String paymentPhone;
	private String paymentMethod;
	private int paymentAmount;
	private String paymentDate; // 주문일
}
