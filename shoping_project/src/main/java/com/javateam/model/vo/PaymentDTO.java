/**
 * 
 */
package com.javateam.model.vo;

import javax.persistence.Column;

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
	private int orderNum;
}
