/**
 * 
 */
package com.javateam.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javateam.model.vo.PaymentVO;
import com.javateam.service.deprecated.JpaDAO;

import lombok.extern.slf4j.Slf4j;

/**
 * @author ss
 *
 */
@Service
@Slf4j
public class PaymentServiceImpl implements PaymentService {
	
	@Autowired
	private JpaDAO dao;
	
	/* (non-Javadoc)
	 * @see com.javateam.service.PaymentService#insertBoard(com.javateam.service.PaymentService)
	 */
	@Override
	public void insertPayment(PaymentVO payment) {
		log.info("장바구니 추가");
		
		dao.insert(payment);
	}

	@Override
	public PaymentVO getNew() {
		
		log.info("최신 값 리턴");
		
		return dao.getNew();
	}

}
