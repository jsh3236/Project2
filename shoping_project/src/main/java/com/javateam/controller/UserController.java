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
import com.javateam.model.vo.PaymentComplDTO;
import com.javateam.model.vo.PaymentComplVO;
import com.javateam.model.vo.PaymentDTO;
import com.javateam.model.vo.PaymentVO;
import com.javateam.service.CustomProvider;
import com.javateam.service.OrderlistService;
import com.javateam.service.PaymentComplService;
import com.javateam.service.PaymentService;
import com.javateam.util.VOCountCalC;

import lombok.extern.java.Log;
import lombok.extern.slf4j.Slf4j;
import oracle.net.aso.s;

/**
 * @author ss
 *
 */
@Controller
@Log
@RequestMapping("/user")
public class UserController {
	
	@Autowired
	private PaymentService paymentSvc;
	
	@Autowired
	private PaymentComplService complSvc;

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
		
		System.out.println("##########################################################################");
		System.out.println("orderlistSvc.getList(username, desc) : "+ orderlistSvc.getList(username, "desc"));
		System.out.println("orderlistSvc.getList(username, asc) : "+orderlistSvc.getList(username, "asc"));
		System.out.println("map : "+map);
		System.out.println("##########################################################################");
		
		Iterator<Integer> keys = map.keySet().iterator();
		System.out.println("map.size() :" + map.size());

		while (keys.hasNext() && temp < 3) {
			int key = map.get(keys.next());
			limit += key;
			temp++;
		}

		page = page != 0 ? page : 1; // page 설정

		int listCount = orderlistSvc.getListCount(username);
		
		limit = 10000;
		orderArticleList = orderlistSvc.getArticleList(page, limit, username);

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
		log.info("현재 페이지 : "+ page);

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
	//orderPage
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

		//List<List<>> 를 List<>에 다시 넣음 ( * 역순 * )
		for (int i = 0; i < orderArticleListD.size(); i++) {
			for (int j = 0; j < orderArticleListD.get(i).size(); j++) {
				orderArticleList.add(orderArticleListD.get(i).get(j));
			}
		}

		VOCountCalC calc = new VOCountCalC();
		
		
		CustomUser user = customSvc.loadUserByUsername(username);
		System.out.println("user : "+user);
		
		model.addAttribute("user",user);
		model.addAttribute("boardNumMap", calc.toMap(orderArticleList));
		model.addAttribute("orderArticleList", orderArticleList);

		return "user/orderPage";
	}
	
	
	//orderComplete
	@RequestMapping(value="/paymentAction.do",method=RequestMethod.POST, produces="application/json; charset=UTF-8")
	public String paymentAction(@RequestParam Map<String,String> map,Model model) {
		
		System.out.println("=============================================");
		map.keySet().forEach(x->System.out.println(x+","+map.get(x)));
		System.out.println("=============================================");
		
		PaymentDTO payment = new PaymentDTO();
		
		StringTokenizer st = null;
		StringTokenizer st2 = null;
		
		// payment insert()
		if(map.get("flag")!=null) {
			log.info("### flag = 1 ###");
			payment.setPaymentAddress(map.get("paymentAddress"));
			payment.setPaymentMethod(map.get("paymentMethod"));
			payment.setPaymentAmount(Integer.parseInt(map.get("paymentAmount")));
			payment.setPaymentName(map.get("paymentName"));
			payment.setPaymentPhone(map.get("paymentPhone"));
			
			System.out.println("!!!!!!!!payment :"+payment);
			
			PaymentVO paymentVO = new PaymentVO(payment);
			
			paymentSvc.insertPayment(paymentVO);
			
			st = new StringTokenizer(map.get("order"), ",");
			st2 = new StringTokenizer(map.get("boardNum"), ",");
		} 
		
		if(map.get("flag2")!=null){
			log.info("### flag2 = 2 ###");
			
			String address = map.get("postcode")+", "+map.get("address")+", "+map.get("address2");
			String phone = map.get("phone")+"-"+map.get("phone2")+"-"+map.get("phone3");
			
			payment.setPaymentAddress(address);
			payment.setPaymentMethod(map.get("paymentMethod2"));
			payment.setPaymentAmount(Integer.parseInt(map.get("paymentAmount")));
			payment.setPaymentName(map.get("paymentName"));
			payment.setPaymentPhone(phone);
			
			System.out.println("!!!!!!!!payment :"+payment);
			
			PaymentVO paymentVO = new PaymentVO(payment);
			
			paymentSvc.insertPayment(paymentVO);
			
			st = new StringTokenizer(map.get("order2"), ",");
			st2 = new StringTokenizer(map.get("boardNum2"), ",");
		}
		
		
		// paymentCopl insert()
		int paymentNum = paymentSvc.getNew().getPaymentNum();
		String complName = paymentSvc.getNew().getPaymentName();
		
		while(st.hasMoreTokens()) {
			
			int num = Integer.parseInt(st.nextToken());
			
			OrderListVO orderlist = orderlistSvc.getArticle(num);
			
			PaymentComplDTO compl = new PaymentComplDTO();
			
			compl.setPaymentNum(paymentNum);
			compl.setBoardFile(orderlist.getBoardFile());
			compl.setBoardPrice(orderlist.getBoardPrice());
			compl.setBoardSubject(orderlist.getBoardSubject());
			compl.setOrderCount(orderlist.getOrderCount());
			compl.setOrderOption(orderlist.getOrderOption());
			compl.setUsername(orderlist.getUsername());
			compl.setComplName(complName);
			compl.setBoardNum(orderlist.getBoardNum());
			
			complSvc.insertPaymentCompl(new PaymentComplVO(compl));
			
		}
		
		// compl list addAttrribute
		log.info("#################compl list attrribute#####################");
		
		// 중복 값 빼기
		List<String> data = new ArrayList<>();
		while(st2.hasMoreTokens()){
			data.add(st2.nextToken());
		}
		List<String> num = new ArrayList<>();
		
		for(int i=0; i<data.size(); i++) {
            if (!num.contains(data.get(i))) {
            	num.add(data.get(i));
            }
        }
		System.out.println("num : "+num);
		
		int[] boardNumList = new int[num.size()];
		for(int i=0; i<boardNumList.length; i++) {
			boardNumList[i]=Integer.parseInt(num.get(i));
		}
		
		System.out.println("==getComplList==");
		
		
		List<List<PaymentComplVO>> complListD = complSvc.getComplList(complSvc.getComplNew().getPaymentNum(), boardNumList, "asc");
		System.out.println("##############################");
		System.out.println("complListD : "+complListD);
		System.out.println("##############################");
		
		List<PaymentComplVO> complList = new ArrayList<>();
		

		//List<List<>> 를 List<>에 다시 넣음 ( * 역순 * )
		for (int i = 0; i < complListD.size(); i++) {
			for (int j = 0; j < complListD.get(i).size(); j++) {
				complList.add(complListD.get(i).get(j));
			}
		}
		
		VOCountCalC calc = new VOCountCalC();
		
		model.addAttribute("boardNumMap", calc.toMap2(complList));
		model.addAttribute("complArticleList", complList);
		
		return "/user/orderComplete";
	}
	
	
	//myPageComplete
	@RequestMapping("/paymentComplete/{username}/{page}")
	public String paymentAction(@PathVariable("username") String username,@PathVariable("page") int page, Model model) {
		
		int limit = 0; // 쿼리문 뽑아오는 리미트 (상품 4개의 주문들의 총 갯수)
		int temp = 0;
		
		page = page!=0 ? page : 1; // page 설정
		
		log.info("마이페이지 -> 구매목록");
		
		List<PaymentComplVO> paymentArticleList = complSvc.getList(username, "asc");
		
		// Map에 역순 입력
		VOCountCalC calc = new VOCountCalC();
		
		Map<Integer, Integer> map = calc.toMap3(complSvc.getList(username, "desc"));
		
		System.out.println("##########################################################################");
		System.out.println("complSvc.getList(username, asc) : "+ paymentArticleList);
		System.out.println("complSvc.getList(username, desc) : "+ complSvc.getList(username, "desc"));
		System.out.println("map : "+map);
		System.out.println("##########################################################################");
		
		Iterator<Integer> keys = map.keySet().iterator();
		
		while (keys.hasNext() && temp < 4) {
			int key = map.get(keys.next());
			limit += key;
			temp++;
		}

		int listCount = complSvc.getListCount(username);
		System.out.println("listCount : "+listCount);
		System.out.println("limit : "+limit);
		
		
		paymentArticleList = complSvc.getArticleList(page, limit, username);

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
		
		model.addAttribute("boardNumMap", calc.toMap3(paymentArticleList));
		model.addAttribute("complArticleList", paymentArticleList);
		model.addAttribute("pageInfo", pageInfo);
		
		return "/user/myPageComplete";
	}
	
	@RequestMapping("/complDetail")
	public void complDetail(HttpServletRequest request,Model model) {
		
		int paymentNum = Integer.parseInt(request.getParameter("paymentNum"));
		
		PaymentVO payment = paymentSvc.get(paymentNum);
		
		model.addAttribute("payment", payment);
		
		
	}
	
}
