/**
 * 
 */
package com.javateam.model.vo;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

/**
 * @author ss
 *
 */
@Entity
@Table(name="orderlist_tbl")
@Data
public class OrderListVO {
	
	@Id
	@Column(name="order_num")
	@GeneratedValue(strategy = GenerationType.AUTO) 
	private int orderNum; // 장바구니 주문번호
	
	@Column(name="order_option", nullable=false)
	private String orderOption; // 주문 옵션
	
	@Column(name="order_count", nullable=false)
	private String orderCount; // 주문 수량
	
	@Column(name="board_num", nullable=false)
	private int boardNum; // board_tbl의 외래키 
	
	@Column(name="username", nullable=false)
	private int userName; // users의 외래키
	
	
	// BoardDTO -> BoardVO
    public OrderListVO(OrderListDTO orderlist) {
        this.boardNum = orderlist.getBoardNum();
        this.orderOption = orderlist.getOrderOption();
        this.orderCount = orderlist.getOrderCount();
        this.userName = orderlist.getUserName();
    }
	
}
