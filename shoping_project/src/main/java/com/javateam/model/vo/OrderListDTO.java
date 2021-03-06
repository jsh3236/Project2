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
public class OrderListDTO {
	private int orderNum; // 장바구니 주문번호
	private String orderOption; // 주문 옵션
	private int orderCount; // 주문 수량
	private int boardNum; // board_tbl의 외래키 
	private String username; // users의 외래키
	private int boardPrice; // 주문 가격
	private String boardSubject; // 상품 제목
	private String boardFile; // 첨부 파일
}
