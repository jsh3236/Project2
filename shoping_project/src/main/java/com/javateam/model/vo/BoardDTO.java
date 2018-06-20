
/**
 * 
 */

package com.javateam.model.vo;

import javax.validation.constraints.Size;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
 
/**
 * @author oracle
 *
 */
@Data
public class BoardDTO {
	
    private int boardNum; // 글 번호
    
    @Size(min=1, max=50, message="글 제목을 입력하십시오")
    private String boardSubject; // 글 제목
    
    @Size(min=1, max=2000, message="글 내용을 입력하십시오")
    private String boardContent; // 글 내용
    
    @Size(min=1, max=200, message="금액을 입력하십시오")
    private int boardPrice;
    
    private MultipartFile boardFile; // 첨부 파일
    private int boardReRef; // 관련글 번호
    private int boardReLev; // 답글 레벨
    private int boardReSeq; // 관련글 중 출력 순서
    private int boardReadCount = 0; // 조회수
    private String boardDate; // 작성일
    
}