/**
 * 
 */
package com.javateam.service.deprecated;

import java.util.List;

import com.javateam.model.vo.BoardVO;
import com.javateam.model.vo.OrderListVO;
import com.javateam.model.vo.PaymentVO;


/**
 * @author oracle
 *
 */
public interface JpaDAO {
	
	void insert(BoardVO board);
	void insert(OrderListVO orderlist);
	List<BoardVO> list();
	List<OrderListVO> orderlist(String username);
	void update(BoardVO board);
	void update(OrderListVO orderlist);
	boolean delete(int boardNum);
	boolean deleteOrderList(int orderNum);
	boolean allDeleteOrderlist(String username);
	BoardVO get(int boardNum);
	OrderListVO getorder(int orderNum);
	List<BoardVO> getListByPageAndLimit(int page, int limit);
	List<OrderListVO> getListByPageAndLimit(int page,int limit,String username);
	List<OrderListVO> getList(String username,String sc);
	List<List<OrderListVO>> getList(String username,int[] boardNumList,String sc);
	void updateReadCount(int boardNum);
	void insert(PaymentVO payment);
	
}