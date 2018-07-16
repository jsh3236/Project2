package com.javateam.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;

import org.hibernate.mapping.Array;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.javateam.model.vo.BoardVO;
import com.javateam.model.vo.PageInfo;
import com.javateam.model.vo.ReviewVO;
import com.javateam.service.BoardService;
import com.javateam.service.ReviewService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/board")
public class BoardController {

	@Autowired
	private BoardService boardSvc;
	
	@Autowired
	private ReviewService reviewSvc;

    @RequestMapping("/mouse/{page}")
    public String listBoard(@PathVariable("page") int page,
                          Model model , HttpServletRequest request) {
    	
      int limit = 10; // 페이지당 글수
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
    
    @RequestMapping("boardDetail.do/boardNum/{boardNum}")
    public String boardDetail(@PathVariable("boardNum") int boardNum, Model model) {
    	
        log.info("boardDetail");
        
        String option = boardSvc.getArticle(boardNum).getBoardOption();
        
        StringTokenizer st = new StringTokenizer(option,",");
        
        int countTok = st.countTokens();
        model.addAttribute("optionLength", countTok);
        
        List<String> optionList = new ArrayList<String>();
        
        for(int i=0; i<countTok; i++) {
        	optionList.add(st.nextToken());
        }
        
        // 리뷰 리스트 얻어오기
        List<ReviewVO> review = reviewSvc.getReview(boardNum);
        
        // 리뷰 데이트 모양 바꾸기
        List<String> reviewDate = new ArrayList<>();
        SimpleDateFormat s = new SimpleDateFormat("yyyy-MM-dd");
        
        // 리뷰 총 점수 얻기
        int totalScore = 0;
        
        for(ReviewVO r: review) {
        	reviewDate.add(s.format(r.getReviewDate()));
        	totalScore += r.getReviewScore();
        }
        
        if(!review.isEmpty()) totalScore = (int) Math.floor(totalScore/review.size());
        
        // 리뷰 리스트 갯수 얻기
        int reviewCount = reviewSvc.getCount(boardNum);
        
        model.addAttribute("totalScore", totalScore);
        model.addAttribute("reviewCount", reviewCount);
        model.addAttribute("reviewDate",reviewDate);
        model.addAttribute("review", review);
        model.addAttribute("optionList", optionList);
        model.addAttribute("article", boardSvc.getArticle(boardNum));
        
        
        // 조회수 업데이트
        boardSvc.updateReadCount(boardNum);
        // return boardSvc.getArticle(boardNum);
        return "/board/mouseBoard_view";
    } //
   
	

	@RequestMapping("/keyBoardwrite")
	public void keyBoard() {
	}
	
	@RequestMapping("/mouseBoard2")
	public void mouseBoard2() {
	}

	@RequestMapping("/headBoardwrite")
	public void headBoard() {
	}

	@RequestMapping("/monitorBoardwrite")
	public void monitorBoard() {
	}

}
