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
public class PaymentComplDTO {
	private int complNum; // 결제완료 주문번호
	private String orderOption; // 주문 옵션
	private int orderCount; // 주문 수량
	private int boardPrice; // 주문 가격
	private String boardSubject; // 상품 제목
	private String boardFile; // 첨부 파일
	private int paymentNum; //payment_tbl의 외래키
	private String username; // 유저 이름
	private String complName; // 유저 아이디
	private int boardNum; //board_tbl의 외래키
}
