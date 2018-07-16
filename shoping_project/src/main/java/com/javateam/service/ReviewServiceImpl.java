package com.javateam.service;

import java.util.List;

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

	@Override
	public boolean hasReview(int complNum, String username) {
		log.info("insertReview ##");
		
		return dao.hasReview(complNum,username);
	}

	@Override
	public List<ReviewVO> getReview(int boardNum) {

		log.info("getReview ##");
		
		return dao.getReview(boardNum);
	}

	@Override
	public int getCount(int boardNum) {
		
		log.info("getCount ##");
		
		return dao.getReview(boardNum).size();
	}

	@Override
	public List<ReviewVO> getAllReview() {
		
		log.info("getAllReview ##");
		
		return dao.getAllReview();
	}

}
