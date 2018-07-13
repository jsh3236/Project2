/**
 * 
 */
package com.javateam.service.deprecated;

import java.util.List;
import java.util.Map;

import com.javateam.model.vo.BoardVO;
import com.javateam.model.vo.OrderListVO;
import com.javateam.model.vo.PaymentComplVO;
import com.javateam.model.vo.PaymentVO;
import com.javateam.model.vo.ReviewVO;


/**
 * @author oracle
 *
 */
public interface JpaDAO {
	
	void insert(BoardVO board);
	void insert(OrderListVO orderlist);
	void insert(PaymentVO payment);
	void insert(PaymentComplVO payment);
	void insert(ReviewVO review);
	
	List<BoardVO> list();
	List<OrderListVO> orderlist(String username);
	List<PaymentComplVO> complList(String usrename);
	List<PaymentComplVO> getCompl(String sc);
	List<Object> getPayment();
	
	void update(BoardVO board);
	void update(OrderListVO orderlist);
	void update(PaymentComplVO payment);
	
	boolean delete(int boardNum);
	boolean deleteOrderList(int orderNum);
	boolean allDeleteOrderlist(String username);
	
	BoardVO get(int boardNum);
	PaymentComplVO getCompl(int complNum);
	PaymentVO getPay(int paymentNum);
	PaymentVO getNew();
	PaymentComplVO getComplNew();
	OrderListVO getorder(int orderNum);
	List<ReviewVO> getReview(int boardNum);
	
	
	List<BoardVO> getListByPageAndLimit(int page, int limit);
	List<OrderListVO> getListByPageAndLimit(int page,int limit,String username);
	List<PaymentComplVO> getListByPageAndLimit2(int page,int limit,String username);
	List<PaymentComplVO> getListByPageAndLimit2(int page,int limit);
	List<List<PaymentComplVO>> getListByPageAndpaymentNum(int page,Map paging,String username);
	List<List<PaymentComplVO>> getListByPageAndpaymentNum(int page,Map paging);
	
	List<OrderListVO> getList(String username,String sc);
	List<PaymentComplVO> getList2(String username,String sc);
	List<List<OrderListVO>> getList(String username,int[] boardNumList,String sc);
	List<List<PaymentComplVO>> getComplList(int complNum,int[] boardNumList,String sc);
	
	void updateReadCount(int boardNum);
	
	boolean hasReview(int complNum,String username);
	
	
}