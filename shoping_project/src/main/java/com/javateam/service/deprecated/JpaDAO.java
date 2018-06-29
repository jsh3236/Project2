/**
 * 
 */
package com.javateam.service.deprecated;

import java.util.List;

import com.javateam.model.vo.BoardVO;
import com.javateam.model.vo.OrderListVO;


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
	BoardVO get(int boardNum);
	OrderListVO get(int boardNum,String username);
	List<BoardVO> getListByPageAndLimit(int page, int limit);
	List<OrderListVO> getListByPageAndLimit(int page,int limit,String username);
	List<OrderListVO> getList(String username);
	void updateReadCount(int boardNum);
}