/**
 * 
 */
package com.javateam.controller;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.javateam.model.vo.CustomUser;
import com.javateam.model.vo.OrderListDTO;
import com.javateam.model.vo.OrderListVO;
import com.javateam.model.vo.PageInfo;
import com.javateam.model.vo.PaymentDTO;
import com.javateam.service.CustomProvider;
import com.javateam.service.OrderlistService;
import com.javateam.service.PaymentService;
import com.javateam.util.VOCountCalC;

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
	private PaymentService paymentSvc;

	@Autowired
	private OrderlistService orderlistSvc;
	
	@Autowired
	private CustomProvider customSvc;

	// 장바구니
	@RequestMapping(value = "/orderList/{page}")
	public String orderList(@PathVariable("page") int page, Model model, RedirectAttributes ra,
			HttpServletRequest request) {

		int limit = 0; // 쿼리문 뽑아오는 리미트 (상품 4개의 주문들의 총 갯수)
		int temp = 0;
		String username = request.getParameter("username");
		List<OrderListVO> orderArticleList = orderlistSvc.getList(username, "asc");
		VOCountCalC calc = new VOCountCalC();
		// Map에 역순 입력
		Map<Integer, Integer> map = calc.toMap(orderlistSvc.getList(username, "desc"));

		Iterator<Integer> keys = map.keySet().iterator();
		System.out.println("map.size() :" + map.size());

		while (keys.hasNext() && temp < 3) {
			int key = map.get(keys.next());
			limit += key;
			temp++;
		}

		System.out.println("allcalc size: " + calc.toMap(orderArticleList).size());
		System.out.println("allcalc : " + calc.toMap(orderArticleList));

		page = page != 0 ? page : 1; // page 설정

		int listCount = orderlistSvc.getListCount(username);
		System.out.println("orderlistcount : " + listCount);
		System.out.println("limit : " + limit);
		orderArticleList = orderlistSvc.getArticleList(page, limit, username);
		System.out.println("장바구니 게시판 :  " + orderArticleList);
		System.out.println("username  :  " + username);

		System.out.println("calc size: " + calc.toMap(orderArticleList).size());
		System.out.println("calc : " + calc.toMap(orderArticleList));

		// 총 페이지 수.
		int maxPage = (int) ((double) listCount / limit + 0.95); // 0.95를 더해서 올림
																	// 처리.
		// 현재 페이지에 보여줄 시작 페이지 수 (1, 11, 21,...)
		int startPage = (((int) ((double) page / 10 + 0.9)) - 1) * 10 + 1;
		// 현재 페이지에 보여줄 마지막 페이지 수(10, 20, 30, ...)
		int endPage = startPage + 10 - 1;

		if (endPage > maxPage)
			endPage = maxPage;

		PageInfo pageInfo = new PageInfo();
		pageInfo.setEndPage(endPage);
		pageInfo.setListCount(listCount);
		pageInfo.setMaxPage(maxPage);
		pageInfo.setPage(page);
		pageInfo.setStartPage(startPage);

		model.addAttribute("boardNumMap", calc.toMap(orderArticleList));
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("orderArticleList", orderArticleList);

		System.out.println("listBoard");

		return "user/orderList";
	}

	// 장바구니 처리 액션
	@RequestMapping(value = "/orderListAction.do")
	public String writeAction(@Valid @ModelAttribute("orderlist") OrderListDTO orderlistDTO, HttpServletRequest request,
			RedirectAttributes ra) {

		System.out.println("장바구니 처리");
		System.out.println("장바구니 : " + orderlistDTO);

		OrderListVO orderlistVO = new OrderListVO(orderlistDTO);

		System.out.println("oderlistVO : " + orderlistVO);

		orderlistSvc.insertBoard(orderlistVO);

		int boardNum = orderlistVO.getBoardNum();
		String nowPage = request.getParameter("nowPage");
		String flag = request.getParameter("flag");
		System.out.println("flag : " + flag);
		// 결과 메시지 생성
		// model.addAttribute("msg", "게시글을 성공적으로 저장하였습니다");
		/* ra.addAttribute("msg", "게시글"); */
		/* listBoard(1,model);// 메시지 페이지 */
		/*
		 * return "board/mouseBoard";
		 */
		ra.addAttribute("username", orderlistVO.getUsername());
		if (flag.equals("1")) {
			return "redirect:/user/orderList/1";
		} else {
			return "redirect:/board/boardDetail.do/boardNum/" + boardNum + "/page/" + nowPage;
		}
	} //

	// 장바구니 수량 업데이트
	@RequestMapping("update/ordercount/{orderNum}/{orderCount}/{page}")
	public String boardDetail(@PathVariable("orderNum") int orderNum, @PathVariable("orderCount") int orderCount,
			@PathVariable("page") String page, RedirectAttributes ra) {
		System.out.println("update Controller !!! update.ordercount : " + orderNum);

		OrderListVO orderlist = new OrderListVO(new OrderListDTO());

		orderlist.setOrderNum(orderNum);
		orderlist.setOrderCount(orderCount);

		orderlistSvc.updateOrderlist(orderlist);

		orderlist = orderlistSvc.getArticle(orderNum);

		System.out.println("orderlist : " + orderlist);

		ra.addAttribute("username", orderlist.getUsername());

		return "redirect:/user/orderList/1";
	} //

	@RequestMapping(value = "/deleteAction.do/orderNum/{orderNum}/page/{page}")
	public String deleteAction(@PathVariable("orderNum") int orderNum, @PathVariable("page") int page,
			RedirectAttributes ra) {

		System.out.println("장바구니 삭제 처리");
		System.out.println("장바구니 번호 : " + orderNum);
		log.info("현재 페이지 : {}", page);

		OrderListVO orderlist = orderlistSvc.getArticle(orderNum);

		ra.addAttribute("username", orderlist.getUsername());

		// 게시글 삭제
		if (orderlistSvc.deleteOrderlist(orderNum)) {

			log.info("orderlist delete fail!");

			return "redirect:/user/orderList/" + page;
		} //

		return "redirect:/user/orderList/" + page;
	} //
	
	@RequestMapping(value = "/allDeleteAction.do/{username}")
	public String allDeleteAction(@PathVariable("username") String username,RedirectAttributes ra) {

		System.out.println("모든 장바구니 삭제 처리");

		ra.addAttribute("username", username);
		
		// 게시글 삭제
		if (orderlistSvc.allDeleteOrderlist(username)) {

			log.info("orderlist all delete fail!");

			return "redirect:/user/orderList/1";
		} //

		return "redirect:/user/orderList/1";
	} //


	/**
	 * @param boardNum
	 */
	@RequestMapping("/orderPage/{boardNum}/{username}")
	public String orderPage(@PathVariable("boardNum") String boardNum, @PathVariable("username") String username,
			Model model) {
		
		StringTokenizer st = new StringTokenizer(boardNum, ",");
		int[] boardNumList = new int[st.countTokens()];

		for (int i = 0; i < boardNumList.length; i++) {
			boardNumList[i] = Integer.parseInt(st.nextToken());
		}

		List<List<OrderListVO>> orderArticleListD = orderlistSvc.getList(username, boardNumList, "asc");

		System.out.println("orderArticleListD : " + orderArticleListD);

		List<OrderListVO> orderArticleList = new ArrayList<>();

		//List<List<>> 를 List<>에 다시 넣음
		for (int i = 0; i < orderArticleListD.size(); i++) {
			for (int j = 0; j < orderArticleListD.get(i).size(); j++) {
				orderArticleList.add(orderArticleListD.get(i).get(j));
			}
		}

		int temp = 0;
		VOCountCalC calc = new VOCountCalC();
		
		// Map에 역순 입력
		Map<Integer, Integer> map = calc.toMap(orderArticleList);

		Iterator<Integer> keys = map.keySet().iterator();
		System.out.println("map.size() :" + map.size());

		while (keys.hasNext() && temp < 3) {
			int key = map.get(keys.next());
			temp++;
		}
		
		CustomUser user = customSvc.loadUserByUsername(username);
		System.out.println("user : "+user);
		
		model.addAttribute("user",user);
		model.addAttribute("boardNumMap", calc.toMap(orderArticleList));
		model.addAttribute("orderArticleList", orderArticleList);

		return "user/orderPage";
	}
	
	
	@RequestMapping("/orderComplete")
	public String orderComplete() {
		
		return "/user/orderComplete";
	}
	
	@RequestMapping(value="/paymentAction.do",method=RequestMethod.POST, produces="application/json; charset=UTF-8")
	public String paymentAction(@RequestParam Map<String,String> map) {
		
		System.out.println("=============================================");
		map.keySet().forEach(x->System.out.println(x+","+map.get(x)));
		System.out.println("=============================================");
		
		Iterator<String> keys = map.keySet().iterator();
		
		PaymentDTO payment = new PaymentDTO();
		
		
		
		if(map.get("flag")!=null) {
			System.out.println("### flag = 1 ###");
			payment.setPaymentAddress(map.get("paymentAddress"));
			payment.setPaymentMethod(map.get("paymentMethod"));
			payment.setPaymentAmount(Integer.parseInt(map.get("paymentAmount")));
			payment.setPaymentName(map.get("paymentName"));
			payment.setPaymentPhone(map.get("paymentPhone"));
			
			System.out.println("!!!!!!!!payment :"+payment);
		} 
		
		if(map.get("flag2")!=null){
			System.out.println("### flag2 = 2 ###");
		}
	
	
		
		return "/user/orderComplete";
	}
	
}
