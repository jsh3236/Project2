package com.javateam.controller;

import java.sql.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.javateam.model.vo.BoardVO;
import com.javateam.service.deprecated.JpaDAO;

import lombok.extern.slf4j.Slf4j;

/**
 * Handles requests for the application home page.
 */
@Controller
@Slf4j
public class TestController {
	/*
	@Autowired 
	private JpaDAO dao;
	
	
	@RequestMapping(value="/insert",
					method = RequestMethod.GET,
					produces = "text/plain; charset=UTF-8")
	public String insert() {
		System.out.println("insert");
		
		log.info("insert");
		
		BoardVO board = new BoardVO();
		System.out.println("1");
		board.setBoardContent("자바 공부");
		System.out.println("2");
		board.setBoardDate(new Date(System.currentTimeMillis()));
		board.setBoardSubject("홍길동의 글");
		board.setBoardFile("helloworld.jsp");
		board.setBoardReLev(0);
		board.setBoardReRef(0);
		board.setBoardReSeq(0);
		board.setBoardReadCount(0);
		System.out.println("3");
		log.info("VO : {}", board);
		dao.insert(board);
		System.out.println("4");
		//return board.toString();
		
		return "writing";
	}
	
	@RequestMapping(value="/update/{boardNum}",
					method = RequestMethod.GET,
					produces = "text/plain; charset=UTF-8")
	@ResponseBody
	public String update(@PathVariable("boardNum") int boardNum) {
	
		log.info("update");
		
		BoardVO board = new BoardVO();
		board.setBoardContent("스프링 공부");
		board.setBoardDate(new Date(System.currentTimeMillis()));
		board.setBoardSubject("장길산의 글");
		board.setBoardFile("memberView.jsp");
		board.setBoardReLev(0);
		board.setBoardReRef(0);
		board.setBoardReSeq(0);
		board.setBoardReadCount(0);
		board.setBoardNum(boardNum);
			
		log.info("VO : {}", board);
		dao.update(board);
		
		return board.toString();
	}
	
	@RequestMapping(value="/delete/{boardNum}",
					method = RequestMethod.GET,
					produces = "text/plain; charset=UTF-8")
	@ResponseBody
	public String delete(@PathVariable("boardNum") int boardNum) {
	
		log.info("delete");
		
		return dao.delete(boardNum)==true ?
			   "삭제 성공" : "삭제 실패";
	}

    @RequestMapping(value = "/mouserBoard", 
    				method = RequestMethod.GET,
    				produces = "text/plain; charset=UTF-8")
    @ResponseBody
    public String listAllBoards(Model model) {

		log.info("listAllBoards : ");
		
		return dao.list().toString();
    }
    
    @RequestMapping(value="/get/{boardNum}",
					method = RequestMethod.GET,
					produces = "text/plain; charset=UTF-8")
	@ResponseBody
	public String get(@PathVariable("boardNum") int boardNum) {
		
		log.info("get");
		
		return dao.get(boardNum).toString();
	}*/
	
}
