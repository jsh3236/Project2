package com.javateam.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.javateam.model.vo.BoardVO;
import com.javateam.model.vo.PageInfo;
import com.javateam.service.BoardService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/board")
public class BoardController {

	@Autowired
	private BoardService boardSvc;

    @RequestMapping("/mouse/{page}")
    public String listBoard(@PathVariable("page") int page,
                          Model model) {
    	
      int limit = 4; // 페이지당 글수
      List<BoardVO> articleList;
     
      page = page!=0 ? page : 1; // page 설정
     
      int listCount = boardSvc.getListCount();
     
      articleList= boardSvc.getArticleList(page, limit);
     
      //총 페이지 수.
      int maxPage=(int)((double)listCount/limit+0.95); //0.95를 더해서 올림 처리.
      // 현재 페이지에 보여줄 시작 페이지 수 (1, 11, 21,...)
      int startPage = (((int) ((double)page / 10 + 0.9)) - 1) * 10 + 1;
      //현재 페이지에 보여줄 마지막 페이지 수(10, 20, 30, ...)
      int endPage = startPage+10-1;
     
      if (endPage> maxPage) endPage= maxPage;
     
      PageInfo pageInfo = new PageInfo();
      pageInfo.setEndPage(endPage);
      pageInfo.setListCount(listCount);
      pageInfo.setMaxPage(maxPage);
      pageInfo.setPage(page);
      pageInfo.setStartPage(startPage);
     
      model.addAttribute("pageInfo", pageInfo);
      model.addAttribute("articleList", articleList);
     
      System.out.println("listBoard");
      
      return "board/mouseBoard";
  } // 
    
    @RequestMapping("boardDetail.do/boardNum/{boardNum}/page/{page}")
    public String boardDetail(@PathVariable("boardNum") int boardNum,
                              @PathVariable("page") int page,
                              Model model) {
        log.info("boardDetail");
        model.addAttribute("nowPage", page);
        model.addAttribute("article", boardSvc.getArticle(boardNum));
        // 조회수 업데이트
        boardSvc.updateReadCount(boardNum);
        // return boardSvc.getArticle(boardNum);
        return "/board/mouseBoard_view";
    } //
   
	

	@RequestMapping("/keyBoardwrite")
	public void keyBoard() {
	}

	@RequestMapping("/headBoardwrite")
	public void headBoard() {
	}

	@RequestMapping("/monitorBoardwrite")
	public void monitorBoard() {
	}

}
