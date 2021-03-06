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
	    name = "ORDERLIST_SEQ_GENERATOR",
	    sequenceName = "ORDERLIST_SEQ",
	    initialValue = 1,
	    allocationSize = 1)
/**
 * @author ss
 *
 */
@Entity
@Table(name="orderlist_tbl")
@Data
public class OrderListVO{
	
	@Id
	@Column(name="order_num")
	@GeneratedValue(generator="ORDERLIST_SEQ_GENERATOR", strategy = GenerationType.AUTO) 
	private int orderNum; // 장바구니 주문번호
	
	@Column(name="order_option", nullable=false)
	private String orderOption; // 주문 옵션
	
	@Column(name="order_count", nullable=false)
	private int orderCount; // 주문 수량
	
	@Column(name="board_num", nullable=false)
	private int boardNum; // board_tbl의 외래키 
	
	@Column(name="username", nullable=false)
	private String username; // users의 외래키
	
	@Column(name="board_price", nullable=false)
	private int boardPrice; // 주문 가격
	
	@Column(name="board_subject", nullable=false)
	private String boardSubject; // 상품 제목
	
	@Column(name="board_file", nullable=false)
	private String boardFile; // 첨부 파일
	
	
	
	// BoardDTO -> BoardVO
    public OrderListVO(OrderListDTO orderlist) {
        this.boardNum = orderlist.getBoardNum();
        this.orderOption = orderlist.getOrderOption();
        this.orderCount = orderlist.getOrderCount();
        this.username = orderlist.getUsername();
        this.boardPrice = orderlist.getBoardPrice();
        this.boardSubject = orderlist.getBoardSubject();
        this.boardFile = orderlist.getBoardFile();
    }
	
}
