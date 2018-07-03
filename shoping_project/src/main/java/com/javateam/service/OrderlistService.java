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
	
	void updateOrderlist(OrderListVO orderlistVO);
	
	void updateReadCount(int orderNum);
	
	 public OrderListVO getArticle(int orderNum);
	 
	 List<OrderListVO> getArticleList(int page, int limit,String username);
	 
	 List<OrderListVO> getList(String username,String sc);
	 
	 List<List<OrderListVO>> getList(String username,int[] boardNumList,String sc);

	boolean deleteOrderlist(int orderNum);
}
