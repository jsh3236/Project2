/**
 * 
 */
package com.javateam.service.deprecated;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javateam.model.vo.BoardVO;

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
	
	/* (non-Javadoc)
	 * @see com.javateam.service.deprecated.BoardService#insertBoard(com.javateam.model.vo.BoardVO)
	 */
	@Override
	public void insertBoard(BoardVO board) {
		   
		log.info("게시글 저장");
		dao.insert(board);

	}

}
