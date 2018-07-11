package com.javateam.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javateam.model.vo.ReviewVO;
import com.javateam.service.deprecated.JpaDAO;

import lombok.extern.java.Log;

/**
 * 
 * @author ss
 *
 */
@Service
@Log
public class ReviewServiceImpl implements ReviewService {

	@Autowired
	private JpaDAO dao;
	
	@Override
	public void insertReview(ReviewVO review) {
		
		log.info("insertReview ##");
			
		dao.insert(review);
	}

}
