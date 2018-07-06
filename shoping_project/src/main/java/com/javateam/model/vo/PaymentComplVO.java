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
	    name = "PAYMENTCOMPL_SEQ_GENERATOR",
	    sequenceName = "PAYMENTCOMPL_SEQ",
	    initialValue = 1,
	    allocationSize = 1)
/**
 * @author ss
 *
 */
@Entity
@Table(name="paymentCompl_tbl")
@Data
public class PaymentComplVO{
	
	@Id
	@Column(name="compl_num")
	@GeneratedValue(generator="PAYMENTCOMPL_SEQ_GENERATOR", strategy = GenerationType.AUTO) 
	private int complNum; // 장바구니 주문번호
	
	@Column(name="order_option", nullable=false)
	private String orderOption; // 주문 옵션
	
	@Column(name="order_count", nullable=false)
	private int orderCount; // 주문 수량
	
	@Column(name="payment_num", nullable=false)
	private int paymentNum; // payment_tbl의 외래키 
	
	@Column(name="board_price", nullable=false)
	private int boardPrice; // 주문 가격
	
	@Column(name="board_subject", nullable=false)
	private String boardSubject; // 상품 제목
	
	@Column(name="board_file", nullable=false)
	private String boardFile; // 첨부 파일
	
	@Column(name="username", nullable=false)
	private String username; // 유저 이름
	
	@Column(name="compl_name", nullable=false)
	private String complName; // 유저 이름
	
	@Column(name="board_num", nullable=false)
	private int boardNum; // board_tbl 외래키
	
	// paymentComplDTO -> paymentComplVO
    public PaymentComplVO(PaymentComplDTO payment) {
        this.complNum = payment.getComplNum();
        this.orderOption = payment.getOrderOption();
        this.orderCount = payment.getOrderCount();
        this.paymentNum = payment.getPaymentNum();
        this.boardPrice = payment.getBoardPrice();
        this.boardSubject = payment.getBoardSubject();
        this.boardFile = payment.getBoardFile();
        this.username = payment.getUsername();
        this.complName = payment.getComplName();
        this.boardNum = payment.getBoardNum();
    }
	
}
