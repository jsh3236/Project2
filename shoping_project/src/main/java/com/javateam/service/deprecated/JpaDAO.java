/**
 * 
 */
package com.javateam.service.deprecated;

import java.util.List;

import com.javateam.model.vo.BoardVO;


/**
 * @author oracle
 *
 */
public interface JpaDAO {
	
	void insert(BoardVO board);
	List<BoardVO> list();
	void update(BoardVO board);
	boolean delete(int boardNum);
	BoardVO get(int boardNum);
}