/**
 * 
 */
package com.javateam.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javateam.model.vo.BoardVO;
import com.javateam.service.deprecated.JpaDAO;

import lombok.extern.slf4j.Slf4j;

/**
 * @author ss
 *
 */
@Service
@Slf4j
public class BoardServiceImpl implements BoardService {

	@Autowired
	private JpaDAO dao;

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.javateam.service.deprecated.BoardService#insertBoard(com.javateam.
	 * model.vo.BoardVO)
	 */
	@Override
	public void insertBoard(BoardVO board) {

		log.info("게시글 저장");
		dao.insert(board);

	}

	@Override
	public int getListCount() {

		log.info("getListCount");
		return dao.list().size();
	} //

	@Override
	public List<BoardVO> getArticleList(int page, int limit) {

		log.info("getArticleList");
		return dao.getListByPageAndLimit(page, limit);
	} //

	@Override
	public void updateReadCount(int boardNum) {
		log.info("updateReadCount");
        // dao.updateReadCount(boardNum);
       dao.updateReadCount(boardNum);

	}

	@Override
	public BoardVO getArticle(int boardNum) {
		log.info("getArticle");
        return dao.get(boardNum);
	}

	@Override
	public boolean deleteBoard(int boardNum) {
		log.info("deleteBoard");
		
        return dao.delete(boardNum);
	}

	@Override
	public void updateBoard(BoardVO board) {
		log.info("updateBoard");
		
        dao.update(board);
	}

}
