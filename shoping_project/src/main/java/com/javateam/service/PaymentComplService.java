/**
 * 
 */
package com.javateam.service;

import java.util.List;
import java.util.Map;

import com.javateam.model.vo.PaymentComplVO;


/**
 * @author ss
 *
 */
public interface PaymentComplService {
	
	void insertPaymentCompl(PaymentComplVO payment);
	
	PaymentComplVO getComplNew();
	
	List<PaymentComplVO> getCompl(String sc);
	
	List<PaymentComplVO> getPaymentList();
	
	int getListCount(String username);
	
	int getListCount();
	
	List<PaymentComplVO> getArticleList(int page, int limit,String username);
	
	List<List<PaymentComplVO>> getArticleList(int page, Map paging,String username);
	
	List<List<PaymentComplVO>> getArticleList(int page, Map paging);
	
	List<PaymentComplVO> getList(String username,String sc);
	
	List<List<PaymentComplVO>> getComplList(int complNum,int[] boardNumList,String sc);
	
}
