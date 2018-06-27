/**
 * 
 */
package com.javateam.controller;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.javateam.model.vo.OrderListDTO;
import com.javateam.model.vo.OrderListVO;
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
	
	@RequestMapping(value="/orderList")
	public void orderList() {	
		
	}
	
	@RequestMapping(value="/orderListAction.do")
	public String writeAction(@Valid @ModelAttribute("orderlist") OrderListDTO orderlistDTO, HttpServletRequest request) {
		
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
	/*	return "board/mouseBoard"; */
		if (flag.equals("1")) {
			return "/user/orderList";
		}
		else {
			return "redirect:/board/boardDetail.do/boardNum/"+boardNum+"/page/"+nowPage;
		}
	} //
	
}
