/**
 * 
 */
package com.javateam.service;

import java.util.List;

import com.javateam.model.vo.BoardVO;
import com.javateam.model.vo.OrderListVO;


/**
 * @author ss
 *
 */
public interface OrderlistService {
	void insertBoard(OrderListVO orderlistVO);
	
	
	int getListCount(String username);
	
	void updateBoard(OrderListVO orderlistVO);
	
	void updateReadCount(int orderNum);
	
	 public OrderListVO getArticle(int orderNum,String username);
	 
	 List<OrderListVO> getArticleList(int page, int limit,String username);

	boolean deleteBoard(int orderNum);
}
