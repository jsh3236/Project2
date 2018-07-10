/**
 * 
 */
package com.javateam.model.vo;

import java.util.Date;

import lombok.Data;

/**
 * @author ss
 *
 */
@Data
public class ReviewDTO {
	
	private int reviewNum;
	private int reviewScore;
	private String reviewContent;
	private String username;
	private Date reviewDate;
	private int orderNum;
	private int paymentNum;
	
}
