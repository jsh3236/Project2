/**
 * 
 */
package com.javateam.service;

import com.javateam.model.vo.ReviewVO;

/**
 * @author ss
 *
 */
public interface ReviewService {
	
	void insertReview(ReviewVO review);
	
	boolean hasReview(int complNum,String username);
	
}
