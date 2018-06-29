/**
 * 
 */
package com.javateam.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javateam.model.vo.BoardVO;
import com.javateam.model.vo.OrderListVO;
import com.javateam.service.deprecated.JpaDAO;

import lombok.extern.slf4j.Slf4j;

/**
 * @author ss
 *
 */
@Service
@Slf4j
public class OrderlistServiceImpl implements OrderlistService {

	@Autowired
	private JpaDAO dao;

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.javateam.service.deprecated.BoardService#insertBoard(com.javateam.
	 * model.vo.BoardVO)
	 */
	@Override
	public void insertBoard(OrderListVO orderlist) {

		log.info("장바구니 추가");
		dao.insert(orderlist);

	}

	@Override
	public int getListCount(String username) {

		log.info("getListCount");
		return dao.orderlist(username).size();
	} //


	@Override
	public void updateReadCount(int orderNum) {
		log.info("updateReadCount");
        // dao.updateReadCount(boardNum);
       dao.updateReadCount(orderNum);

	}


	@Override
	public boolean deleteBoard(int orderNum) {
		log.info("deleteBoard");
		
        return dao.delete(orderNum);
	}

	@Override
	public void updateBoard(OrderListVO orderlistVO) {
		log.info("updateBoard");
		
        dao.update(orderlistVO);
	}
	
	@Override
	public OrderListVO getArticle(int boardNum, String username) {
		log.info("getArticle");
        return dao.get(boardNum,username);
	}

	@Override
	public List<OrderListVO> getArticleList(int page, int limit,String username) {
		log.info("getArticleList");
		return dao.getListByPageAndLimit(page, limit, username);
	}

	@Override
	public List<OrderListVO> getList(String username) {
		log.info("getList");
		return dao.getList(username);
	}


}
