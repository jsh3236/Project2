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
	void update(BoardVO board);
	boolean delete(int boardNum);
	BoardVO get(int boardNum);
	List<BoardVO> getListByPageAndLimit(int page, int limit);
	void updateReadCount(int boardNum);
}