/**
 * 
 */
package com.javateam.controller;

import java.util.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
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

import com.javateam.model.vo.BoardVO;
import com.javateam.model.vo.CustomUser;
import com.javateam.model.vo.OrderListDTO;
import com.javateam.model.vo.OrderListVO;
import com.javateam.model.vo.PageInfo;
import com.javateam.model.vo.PaymentComplDTO;
import com.javateam.model.vo.PaymentComplVO;
import com.javateam.model.vo.PaymentDTO;
import com.javateam.model.vo.PaymentVO;
import com.javateam.service.BoardService;
import com.javateam.service.CustomProvider;
import com.javateam.service.OrderlistService;
import com.javateam.service.PaymentComplService;
import com.javateam.service.PaymentService;
import com.javateam.service.ReviewService;
import com.javateam.util.VOCountCalC;

import lombok.extern.java.Log;

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
	private BoardService boardSvc;
	
	@Autowired
	private CustomProvider customSvc;
	
	@Autowired
	private ReviewService reviewSvc;

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
	//orderPage (orderList -> 전체구매, 선택상품구매ㅛㅛ)
	@RequestMapping("/orderPage/{boardNum}/{username}")
	public String orderPage(@PathVariable("boardNum") String boardNum, @PathVariable("username") String username,
			Model model) {
		
		System.out.println("boardNum :"+boardNum);
		
		StringTokenizer st = new StringTokenizer(boardNum, ",");
		int[] boardNumList = new int[st.countTokens()];
		
		System.out.println("boardNumList : "+boardNumList);

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
		model.addAttribute("flag",0);

		return "user/orderPage";
	}
	
	//directOrderPage (mouseBoard_view -> 구매하기 버튼)
		@RequestMapping("/directOrderPage.do")
	public String directOrderPage(@Valid @ModelAttribute("orderlist") OrderListDTO orderlistDTO, Model model) {
			
			
			System.out.println("장바구니 처리");

			OrderListVO orderlistVO = new OrderListVO(orderlistDTO);

			
			List<OrderListVO> orderArticleList = new ArrayList<>();
			
			orderArticleList.add(orderlistVO);

			
			VOCountCalC calc = new VOCountCalC();
			
			CustomUser user = customSvc.loadUserByUsername(orderlistDTO.getUsername());
			System.out.println("user : "+user);
			
			model.addAttribute("user",user);
			model.addAttribute("boardNumMap", calc.toMap(orderArticleList));
			model.addAttribute("orderArticleList", orderArticleList);
			model.addAttribute("flag",1);

			return "user/orderPage";
		}
	
	
	//orderComplete
	@RequestMapping(value="/paymentAction.do/{flag}",method=RequestMethod.POST, produces="application/json; charset=UTF-8")
	public String paymentAction(@PathVariable("flag") int flag,@RequestParam Map<String,String> map,Model model) {
		
		System.out.println("=============================================");
		map.keySet().forEach(x->System.out.println(x+","+map.get(x)));
		System.out.println("=============================================");
		
		PaymentDTO payment = new PaymentDTO();
		
		StringTokenizer st = null;
		StringTokenizer st2 = null;
		
		 String date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
		                .format(new Date(System.currentTimeMillis()));
		
		 
		// payment insert()
		if(map.get("flag")!=null) {
			log.info("### flag = 1 ###");
			payment.setPaymentAddress(map.get("paymentAddress"));
			payment.setPaymentMethod(map.get("paymentMethod"));
			payment.setPaymentAmount(Integer.parseInt(map.get("paymentAmount")));
			payment.setPaymentName(map.get("paymentName"));
			payment.setPaymentDate(date);
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
			payment.setPaymentDate(date);
			
			
			System.out.println("!!!!!!!!payment :"+payment);
			
			PaymentVO paymentVO = new PaymentVO(payment);
			
			paymentSvc.insertPayment(paymentVO);
			
			
			st = new StringTokenizer(map.get("order2"), ",");
			st2 = new StringTokenizer(map.get("boardNum2"), ",");
		}
		
		
		// paymentCopl insert()
		
		int paymentNum = paymentSvc.getNew().getPaymentNum();
		String complName = paymentSvc.getNew().getPaymentName();
		
		// 장바구니에서 구매할 경우
		System.out.println("장바구니에서 구매할 경우 아닌경우 :"+flag);
		if(flag==0) {
			
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
				compl.setComplProgress("결제완료");
				
				complSvc.insertPaymentCompl(new PaymentComplVO(compl));
				
			}
		} else if(flag==1) { // 바로 구매한 경우
			
			PaymentComplDTO compl = new PaymentComplDTO();
			
			BoardVO board = boardSvc.getArticle(paymentNum);
			
			compl.setPaymentNum(paymentNum);
			compl.setBoardFile(board.getBoardFile());
			compl.setBoardPrice(board.getBoardPrice());
			compl.setBoardSubject(board.getBoardSubject());
			compl.setOrderCount(Integer.parseInt(map.get("orderCount")));
			compl.setOrderOption(map.get("orderOption"));
			compl.setUsername(map.get("username"));
			compl.setComplName(complName);
			compl.setBoardNum(board.getBoardNum());
			compl.setComplProgress("결제완료");
			
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
	
	@RequestMapping("/cancel.do/{orderNum}")
	public String Cancel(@PathVariable("orderNum") int orderNum) {
		
		orderlistSvc.deleteOrderlist(orderNum);
		
		return "redirect:history.go(-1)";
	}
	
	//myPageComplete
	@RequestMapping("/paymentComplete/{username}/{page}")
	public String paymentAction(@PathVariable("username") String username,@PathVariable("page") int page, Model model) {
		
		page = page!=0 ? page : 1; // page 설정
		
		log.info("마이페이지 -> 구매목록");
		
		List<PaymentComplVO> paymentArticleList = complSvc.getList(username, "asc");
		
		// Map에 역순 입력
		VOCountCalC calc = new VOCountCalC();
		
		Map<Integer, Integer> map = calc.toMap3(paymentArticleList);
		
		Iterator<Integer> keys = map.keySet().iterator();
		
		int[] key = new int[map.size()];
		
		for(int i=0; i<key.length; i++) {
			key[i] = keys.next();
		}
		
		Map<Integer, Integer> pageMap = calc.paging(key);

		List<List<PaymentComplVO>> allList = complSvc.getArticleList(page, pageMap, username);
		
		paymentArticleList.clear(); // List<PaymentComplVO> 초기화 후 재사용
		
		//List<List<>> 를 List<>에 다시 넣음 ( * 역순 * )
		for (int i = 0; i < allList.size(); i++) {
			for (int j = 0; j < allList.get(i).size(); j++) {
				paymentArticleList.add(allList.get(i).get(j));
			}
		}
		
		//compl에 맞는 payment 불러오기
		List<PaymentVO> paymentlist = new ArrayList<>();
		for(int i=0; i<key.length; i++){
			paymentlist.add(paymentSvc.get(key[i]));
		}
				

		
		int listCount = complSvc.getListCount(username);
		
		// 총 페이지 수.
		int maxPage = (int) Math.ceil(listCount/4); //  큰 정수 중 가장 가까운 정수 찾기
																	
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
		
		model.addAttribute("paymentlist",paymentlist);
		model.addAttribute("boardNumMap", calc.toMap3(paymentArticleList));
		model.addAttribute("complArticleList", paymentArticleList);
		model.addAttribute("pageInfo", pageInfo);
		
		return "/user/myPageComplete";
	}
	
	@RequestMapping("/complDetail/{paymentNum}")
	public String complDetail(@PathVariable("paymentNum") int paymentNum,Model model) {
		
		PaymentVO payment = paymentSvc.get(paymentNum);
		
		model.addAttribute("payment", payment);
		
		
		return "/user/complDetail";
	}
	
	@RequestMapping("/review/{paymentNum}")
	public String review(@PathVariable("paymentNum") int paymentNum, Model model) {
		
		PaymentVO payment = paymentSvc.get(paymentNum);
		
		model.addAttribute("payment",payment);
		
		return "/user/myPageReview";
	}
	
	@RequestMapping("/reviewWriteAction.do")
	public String reviewWrite(@RequestParam Map<String,String> map) {
		
		System.out.println("##########################");
		System.out.println("map :"+map);
		System.out.println("##########################");

		
/*		ReviewVO review = new ReviewVO(reviewDTO);
		
		reviewSvc.insertReview(review); */
		
		int boardNum = 0;
		
		return "redirect:/board/boardDetail.do/boardNum/"+boardNum;
	}
	
}
