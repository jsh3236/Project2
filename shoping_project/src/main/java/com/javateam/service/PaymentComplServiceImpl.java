/**
 * 
 */
package com.javateam.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javateam.model.vo.PaymentComplVO;
import com.javateam.service.deprecated.JpaDAO;

import lombok.extern.java.Log;

/**
 * @author ss
 *
 */
@Service
@Log
public class PaymentComplServiceImpl implements PaymentComplService{
	
	@Autowired
	private JpaDAO dao;
	
	/* (non-Javadoc)
	 * @see com.javateam.service.PaymentService#insertBoard(com.javateam.service.PaymentService)
	 */
	@Override
	public void insertPaymentCompl(PaymentComplVO payment) {
		log.info("장바구니 추가");
		
		dao.insert(payment);
	}

	@Override
	public List<List<PaymentComplVO>> getComplList(int complNum, int[] boardNumList, String sc) {
		log.info("getComplList >>");
		
		return dao.getComplList(complNum, boardNumList, sc);
	}

	@Override
	public PaymentComplVO getComplNew() {
		log.info("getComplNew() >>");
		
		return dao.getComplNew();
	}

	@Override
	public List<PaymentComplVO> getList(String username, String sc) {
		
		log.info("List<PaymentComplVO> getList() >>");
		
		return dao.getList2(username, sc);
	}

	@Override
	public int getListCount(String username) {

		log.info("Compl getListCount >>");
		
		return dao.complList(username).size();
	}
	
	@Override
	public List<PaymentComplVO> getArticleList(int page, int limit,String username) {
		
		log.info("PaymentComplVO getArticleList");
		
		return dao.getListByPageAndLimit2(page, limit, username);
	}

	@Override
	public List<List<PaymentComplVO>> getArticleList(int page, Map paging, String username) {
		
		log.info("PaymentComplVO getArticleList2");
		
		return dao.getListByPageAndpaymentNum(page, paging, username);
	}
	
	@Override
	public List<List<PaymentComplVO>> getArticleList(int page, Map paging) {
		
		log.info("PaymentComplVO getArticleList2");
		
		return dao.getListByPageAndpaymentNum(page, paging);
	}

	@Override
	public List<PaymentComplVO> getCompl(String sc) {
		
		log.info("PaymentComplVO getArticleList2");
		
		return dao.getCompl(sc);
	}

	@Override
	public List<Object> getPaymentList() {
		
		log.info("PaymentComplVO getPayment");
		
		return dao.getPayment();
	}

	@Override
	public int getListCount() {
		
		log.info("Compl getListCount >>");
		
		return dao.getCompl("desc").size();
	}

	@Override
	public PaymentComplVO get(int complNum) {

		log.info("Compl get >>");

		return dao.getCompl(complNum);
	}

	@Override
	public void updatePaymentCompl(PaymentComplVO payment) {

		log.info("Compl update >>");

		dao.update(payment);
		
	}


}
