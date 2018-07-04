/**
 * 
 */
package com.javateam.model.vo;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import lombok.Data;
@SequenceGenerator(
	    name = "PAYMENT_SEQ_GENERATOR",
	    sequenceName = "PAYMENT_SEQ",
	    initialValue = 1,
	    allocationSize = 1)
/**
 * @author ss
 *
 */
@Entity
@Table(name="payment_tbl")
@Data
public class PaymentVO{
	
	@Id
	@Column(name="payment_num")
	@GeneratedValue(generator="PAYMENT_SEQ_GENERATOR", strategy = GenerationType.AUTO) 
	private int paymentNum; // 결제 번호
	
	@Column(name="payment_name", nullable=false)
	private String paymentName; // 결제자 이름
	
	@Column(name="payment_address", nullable=false)
	private String paymentAddress; // 배송 주소
	
	@Column(name="payment_phone", nullable=false)
	private String paymentPhone; // board_tbl의 외래키 
	
	@Column(name="payment_method", nullable=false)
	private String paymentMethod; // users의 외래키
	
	@Column(name="payment_amount", nullable=false)
	private int paymentAmount; // 주문 가격
	
	@Column(name="order_num", nullable=false)
	private int orderNum; // 상품 제목
	
	
    // PaymentDTO -> PaymentVO
	public PaymentVO(PaymentDTO payment) {
		super();
		this.paymentNum = payment.getPaymentNum();
		this.paymentName = payment.getPaymentName();
		this.paymentAddress = payment.getPaymentAddress();
		this.paymentPhone = payment.getPaymentPhone();
		this.paymentMethod = payment.getPaymentMethod();
		this.paymentAmount = payment.getPaymentAmount();
		this.orderNum = payment.getOrderNum();
	}
	
}
