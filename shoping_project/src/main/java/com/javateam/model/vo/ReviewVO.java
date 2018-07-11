/**
 * 
 */
package com.javateam.model.vo;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import lombok.Data;
@SequenceGenerator(
	    name = "REVIEW_SEQ_GENERATOR",
	    sequenceName = "REVIEW_SEQ",
	    initialValue = 1,
	    allocationSize = 1)
/**
 * @author ss
 *
 */
@Entity
@Table(name="review_tbl")
@Data
public class ReviewVO{
	
	@Id
	@Column(name="review_num")
	@GeneratedValue(generator="REVIEW_SEQ_GENERATOR", strategy = GenerationType.AUTO) 
	private int reviewNum; // 리뷰 번호
	
	@Column(name="review_score", nullable=false)
	private int reviewScore; // 상품 점수
	
	@Column(name="review_subject", nullable=false)
	private String reviewSubject; // 리뷰 제목
	
	@Column(name="review_content", nullable=false)
	private String reviewContent; // 리뷰 내용
	
	@Column(name="review_username", nullable=false)
	private String username; // 유저 아이디
	
	@Column(name="payment_num", nullable=false)
	private int paymentNum; // payment_tbl의 외래키
	
	@Column(name="review_date", nullable=false)
	private Date reviewDate; // 주문일
	
    // ReviewDTO -> ReviewVO
	public ReviewVO(ReviewDTO review) {
		
		this.reviewNum = review.getReviewNum();
		this.reviewScore = review.getReviewScore();
		this.reviewContent = review.getReviewContent();
		this.username = review.getUsername();
		this.reviewDate = review.getReviewDate();
		this.paymentNum = review.getPaymentNum();
		this.reviewSubject = review.getReviewSubject();
		
	}
	
}
