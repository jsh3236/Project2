/**
 * 
 */
package com.javateam.service;

import java.util.List;

import com.javateam.model.vo.OrderListVO;
import com.javateam.model.vo.PaymentComplVO;


/**
 * @author ss
 *
 */
public interface PaymentComplService {
	
	void insertPaymentCompl(PaymentComplVO payment);
	
	PaymentComplVO getComplNew();
	
	int getListCount(String username);
	
	List<PaymentComplVO> getArticleList(int page, int limit,String username);
	
	List<PaymentComplVO> getList(String username,String sc);
	
	List<List<PaymentComplVO>> getComplList(int complNum,int[] boardNumList,String sc);
	
}
