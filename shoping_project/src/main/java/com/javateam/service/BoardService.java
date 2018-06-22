/**
 * 
 */
package com.javateam.service;

import java.util.List;

import com.javateam.model.vo.BoardVO;

/**
 * @author ss
 *
 */
public interface BoardService {
	void insertBoard(BoardVO boardVO);
	
	
	int getListCount();
	
	void updateBoard(BoardVO board);
	
	void updateReadCount(int boardNum);
	
	 public BoardVO getArticle(int boardNum);

	List<BoardVO> getArticleList(int page, int limit);

	boolean deleteBoard(int boardNum);
}
