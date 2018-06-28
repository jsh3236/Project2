/**
 * 
 */
package com.javateam.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.javateam.model.vo.BoardVO;
import com.javateam.model.vo.OrderListDTO;
import com.javateam.model.vo.OrderListVO;
import com.javateam.model.vo.PageInfo;
import com.javateam.service.OrderlistService;

import lombok.extern.slf4j.Slf4j;

/**
 * @author ss
 *
 */
@Controller
@Slf4j
@RequestMapping("/user")
public class UserController {
	
	@Autowired
	private OrderlistService orderlistSvc;
	
	@RequestMapping(value="/orderList/{page}")
	public String orderList(@PathVariable("page") int page, Model model,RedirectAttributes ra,HttpServletRequest request) {	
		
		
		 int limit = 10; // 페이지당 글수
	      List<OrderListVO> orderArticleList;
	     
	      page = page!=0 ? page : 1; // page 설정
	      String username = request.getParameter("username");
	      int listCount = orderlistSvc.getListCount(username);
	     System.out.println("orderlistcount : "+listCount);
	      orderArticleList= orderlistSvc.getArticleList(page, limit, username);
	      System.out.println("장바구니 게시판 :  "+orderArticleList);
	      System.out.println("username  :  "+ username);
	      
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
	      model.addAttribute("orderArticleList", orderArticleList);
	     
	      System.out.println("listBoard");
	      
	      return "user/orderList";
	}
	
	@RequestMapping(value="/orderListAction.do")
	public String writeAction(@Valid @ModelAttribute("orderlist") OrderListDTO orderlistDTO, HttpServletRequest request, RedirectAttributes ra) {
		
		System.out.println("장바구니 처리");
		System.out.println("장바구니 : "+ orderlistDTO);
		
		OrderListVO orderlistVO = new OrderListVO(orderlistDTO); 
		
		System.out.println("oderlistVO : "+orderlistVO);
		
		orderlistSvc.insertBoard(orderlistVO);
		
		int boardNum = orderlistVO.getBoardNum();
		String nowPage = request.getParameter("nowPage");
		String flag = request.getParameter("flag");
		System.out.println("flag : "+flag);
		// 결과 메시지 생성
		//model.addAttribute("msg", "게시글을 성공적으로 저장하였습니다");
		/*ra.addAttribute("msg", "게시글");*/
	/*	listBoard(1,model);// 메시지 페이지*/
	/*	
	 * return "board/mouseBoard"; */
		ra.addAttribute("username", orderlistVO.getUsername());
		if (flag.equals("1")) {
			return "redirect:/user/orderList/1";
		}
		else {
			return "redirect:/board/boardDetail.do/boardNum/"+boardNum+"/page/"+nowPage;
		}
	} //
	
}
