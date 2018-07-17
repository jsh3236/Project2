/**
 * 
 */
package com.javateam.service;

import java.util.List;

import com.javateam.model.vo.ReviewVO;

/**
 * @author ss
 *
 */
public interface ReviewService {
	
	void insertReview(ReviewVO review);
	
	boolean hasReview(int complNum,String username);
	
	List<ReviewVO> getReview(int boardNum);
	
	List<ReviewVO> getAllReview();
	
	int getCount(int boardNum);
	
	List<Object> getReviewAvgScore();
	
}
