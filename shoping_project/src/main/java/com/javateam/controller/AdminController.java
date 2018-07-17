package com.javateam.controller;

import java.io.File;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.hibernate.mapping.Array;
import org.rosuda.REngine.Rserve.RConnection;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.javateam.model.vo.BoardDTO;
import com.javateam.model.vo.BoardVO;
import com.javateam.model.vo.PageInfo;
import com.javateam.model.vo.PaymentComplVO;
import com.javateam.model.vo.PaymentResultVO;
import com.javateam.model.vo.PaymentVO;
import com.javateam.model.vo.ReviewVO;
import com.javateam.service.BoardService;
import com.javateam.service.CustomProvider;
import com.javateam.service.OrderlistService;
import com.javateam.service.PaymentComplService;
import com.javateam.service.PaymentService;
import com.javateam.service.ReviewService;
import com.javateam.util.FileUploadUtil;
import com.javateam.util.VOCountCalC;
import com.javateam.util.myToString;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	private BoardService boardSvc;
	
	@Autowired
	private PaymentService paymentSvc;
	
	@Autowired
	private PaymentComplService complSvc;
	
	@Autowired
	private ReviewService reviewSvc;
	
	@RequestMapping("/mouseBoardwrite")
	public String mouseBoard(Model model) {

		log.info("게시판 글쓰기");
		model.addAttribute("board", new BoardDTO());

		return "/admin/writing";
	} //
	
	@RequestMapping("/test")
	@ResponseBody
	public String test(HttpServletRequest request) {
		String image = "g903_0_1_1.jpg";
		String image2 = "g903_1.jpg";
		String regex = "^\\S+_+[0-9]+\\.[a-z]+$";
		
		for(int i = 0; i<10; i++)
        {
			System.out.println("image : "+image+", regex : "+regex);
			System.out.println("matches : "+image.matches(regex));
			System.out.println("matches2 : "+image2.matches(regex));
			
			
			if(image.matches(regex)) image = image.substring(0, image.indexOf('.')-2);
			else image = image.substring(0, image.indexOf('.'));
		  	image =  image + "_" + i+".jpg";
		  	
		  	System.out.println("for문 "+i+"번 돌아갔다");
	  	
        }
		
		return image;
		
	}

	@RequestMapping(value="/writeAction.do",method={RequestMethod.POST,RequestMethod.GET},
			produces="text/plain; charset=UTF-8")
	public String writeAction(@Valid @ModelAttribute("board") BoardDTO boardDTO, BindingResult result,
			Model model, RedirectAttributes ra, HttpServletRequest request) {
		
		System.out.println("게시판 글쓰기 처리");
		System.out.println("게시글 : "+ boardDTO);

		if (result.hasErrors()) { // 폼 유효성 점검

			log.info("form invalid !");

			return "/admin/writing";
		} //
		
		FileUploadUtil fu = new FileUploadUtil();
		MultipartFile file = boardDTO.getBoardFile(); // 업로드 파일
		MultipartFile file2 = boardDTO.getBoardFileContent();
		BoardVO boardVO = new BoardVO(boardDTO); // DTO -> VO
		
		boardVO.setBoardFile(fu.fileUpload(file, boardDTO, request,boardVO));
		boardVO.setBoardFileContent(fu.fileUpload(file2, boardDTO, request,boardVO));

		// 게시글 등록일
		// boardVO.setBoardDate(new Date(System.currentTimeMillis()));

		String dateString = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date(System.currentTimeMillis()))
				.toString();

		log.info("등록일 {}", dateString);
		boardVO.setBoardDate(dateString);
		

		log.info("등록일 {}", boardVO.getBoardDate());
		
		System.out.println("옵션 받기 : "+request.getParameter("boardOption"));
		String length = request.getParameter("inputLength");
		for(int i=0; i<Integer.parseInt(length);  i++) {
			System.out.println("셀렉트"+i+" : "+request.getParameter("option"+i));
		}
		
		String boardOption = request.getParameter("boardOption");
		for(int i=0; i<Integer.parseInt(length);  i++) {
			boardOption += ","+request.getParameter("option"+i);
		}
		
		boardVO.setBoardOption(boardOption);
		
		boardVO.setBoardDflag("0");
		boardVO.setBoardSale(0);
		
		// 게시글 저장
		boardSvc.insertBoard(boardVO);

		// 결과 메시지 생성
		//model.addAttribute("msg", "게시글을 성공적으로 저장하였습니다");
		/*ra.addAttribute("msg", "게시글");*/
	/*	listBoard(1,model);// 메시지 페이지*/
	/*	return "board/mouseBoard"; */
		
		return "redirect:/board/mouse/1";
	} //
	
	@RequestMapping(value="/deleteAction.do/boardNum/{boardNum}/page/{page}")
	public String deleteAction(@PathVariable("boardNum") int boardNum,@PathVariable("page") int page) {
		
		System.out.println("게시판 삭제 처리");
		System.out.println("게시글 번호 : "+ boardNum);
		log.info("현재 페이지 : {}",page);

		// 게시글 삭제
		if (boardSvc.deleteBoard(boardNum)) { 

			log.info("delete fail!");

			return "redirect:/board/mouse/1";
		} //

		return "redirect:/board/mouse/1";
	} //
	
	
	
	@RequestMapping("update/boardNum/{boardNum}")
    public String boardDetail(@PathVariable("boardNum") int boardNum, Model model) {
        log.info("update.boardNum : {}",boardNum);
        
        model.addAttribute("article", boardSvc.getArticle(boardNum));
        
        return "/admin/update";
    } //
	
	@RequestMapping(value="/updateAction.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String updateAction(@Valid @ModelAttribute("board") BoardDTO boardDTO, BindingResult result,
			Model model, RedirectAttributes ra, HttpServletRequest request) {
		
		System.out.println("게시판 수정 처리");
		System.out.println("게시글 : "+ boardDTO);

		if (result.hasErrors()) { // 폼 유효성 점검

			log.info("form invalid !");

			return "/admin/writing";
		} //
		
		FileUploadUtil fu = new FileUploadUtil();
		MultipartFile file = boardDTO.getBoardFile(); // 업로드 메인사진
		MultipartFile file2 = boardDTO.getBoardFileContent(); // 업로드 컨텐트사진
		BoardVO boardVO = new BoardVO(boardDTO); // DTO -> VO
		
		boardVO.setBoardFile(fu.fileUpload(file, boardDTO, request,boardVO));
		boardVO.setBoardFileContent(fu.fileUpload(file2, boardDTO, request,boardVO));

		// 게시글 업데이트
		boardSvc.updateBoard(boardVO);

		
		return "redirect:/board/mouse/1";
	} //
	
	
	//orderCompleteView
	@RequestMapping("/paymentComplete/{page}")
	public String paymentAction(@PathVariable("page") int page, Model model) {
		
		page = page!=0 ? page : 1; // page 설정
		
		log.info("마이페이지 -> 구매목록");
		
		List<PaymentComplVO> complArticleList = complSvc.getCompl("asc");
		
		// Map에 역순 입력
		VOCountCalC calc = new VOCountCalC();
		
		Map<Integer, Integer> map = calc.toMap3(complArticleList);
		
		Iterator<Integer> keys = map.keySet().iterator();
		
		int[] key = new int[map.size()];
		
		for(int i=0; i<key.length; i++) {
			key[i] = keys.next();
		}
		
		Map<Integer, Integer> pageMap = calc.paging(key);

		List<List<PaymentComplVO>> allList = complSvc.getArticleList(page, pageMap);
		
		complArticleList.clear(); // List<PaymentComplVO> 초기화 후 재사용
		
		//List<List<>> 를 List<>에 다시 넣음 ( * 역순 * )
		for (int i = 0; i < allList.size(); i++) {
			for (int j = 0; j < allList.get(i).size(); j++) {
				complArticleList.add(allList.get(i).get(j));
			}
		}
		
		//compl에 맞는 payment 불러오기
		List<PaymentVO> paymentlist = new ArrayList<>();
		for(int i=0; i<key.length; i++){
			paymentlist.add(paymentSvc.get(key[i]));
		}
		
		// payment에 맞는 user id,payment_name,date 구하기
		List<String> userID = new ArrayList<>();
		List<Integer> paymentNum = new ArrayList<>();
		List<String> datefront = new ArrayList<>();
		List<String> dateback = new ArrayList<>();
		
		for(int i=0; i<paymentlist.size(); i++) {
			for(int j=0; j<complArticleList.size(); j++ ) {
				if(complArticleList.get(j).getPaymentNum()==paymentlist.get(i).getPaymentNum()) {
					userID.add(complArticleList.get(j).getUsername());
					paymentNum.add(paymentlist.get(i).getPaymentNum());
					datefront.add(paymentlist.get(i).getPaymentDate().substring(0, 10));
					dateback.add(paymentlist.get(i).getPaymentDate().substring(11, 19));
					break;
				}
			}
		}
		
		System.out.println("userID:"+userID);
		
		int listCount = complSvc.getListCount();
		
		double maxpageCal = ((double)map.size())/4;
		
		// 총 페이지 수.
		int maxPage = (int) Math.ceil(maxpageCal); //  큰 정수 중 가장 가까운 정수 찾기
																	
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
		
		model.addAttribute("userID", userID);
		model.addAttribute("datefront",datefront);
		model.addAttribute("dateback",dateback);
		model.addAttribute("paymentNum",paymentNum);
		model.addAttribute("boardNumMap", calc.toMap3(complArticleList));
		model.addAttribute("complArticleList", complArticleList);
		model.addAttribute("pageInfo", pageInfo);
		
		return "/admin/orderComplView";
	}
	

	@RequestMapping("/progressAction.do/{complNum}")
	public String progress(@PathVariable("complNum") int complNum) {
		
		PaymentComplVO payment = complSvc.get(complNum);
		
		System.out.println("complVO :"+payment);
		
		if(payment.getComplProgress().equals("결제완료")) payment.setComplProgress("배송중");
		
		complSvc.updatePaymentCompl(payment);
		
		return "redirect:/admin/paymentComplete/1";
	}
	
	@RequestMapping("/management")
	public String management() {
		
		return "/admin/management";
	}
	
	

	@RequestMapping("/manage.do")
    public String testd(Model model) {
		
        String path = "C:\\Users\\jsh32\\git\\Project2\\shoping_project\\src\\main\\webapp\\resources\\used-image";
        String fileName = "avgManage.png";
        String fileName2 = "textmining.png";
        

        
        String name = "";
        String payment = "";
        
       
        
        myToString to = new myToString();
        
        List<Object> temp = complSvc.getPaymentList(); // DAO
        List<Object[]> list = to.toList(temp.toArray()); // custom 변환 메서드
        
        // 나열 출력
        for(int i=0; i<list.size(); i++) {
        	
        	for(int j=0; j<list.get(i).length; j++) {
        		if(j==1) {
        			name += "'"+(String)list.get(i)[j]+"',";
        		}
        		else if(j==2) {
        			payment += (String)list.get(i)[j]+",";
        		}
        		
        	}
        	
        }
        
        
        List<ReviewVO> review = reviewSvc.getAllReview();
        
        String reviewTxt = "";
        
        for(ReviewVO r : review) {
        	reviewTxt += r.getReviewContent()+" ";
        }
       
        System.out.println("reviewTxt : "+ reviewTxt);
        
        RConnection connection = null;
        
        // ggplot2
        
        try {
        	File file = null;
            file = new File(path + "/"+fileName);
            if( file.exists() ){
                if(file.delete()){
                    System.out.println(fileName+"파일삭제 성공");
                }else{
                    System.out.println(fileName+"파일삭제 실패");
                }
            }else{
                System.out.println(fileName+"파일이 존재하지 않습니다.");
            }
            
            connection = new RConnection();
            
            connection.eval("library(ggplot2)");
            connection.eval("require(ggplot2)");
//          connection.eval("name <- c('제닉스','제닉스2','g950','g340')");
//          connection.eval("count <- c(100,33,21,87)");
            connection.eval("name <- c("+name.substring(0, name.length()-1)+")");
            connection.eval("payment <- c("+payment.substring(0, payment.length()-1)+")");
            connection.eval("pp <- data.frame(이름=name,판매수입=payment)");
            connection.eval("pp$pos <- pp$판매수입>=mean(pp$판매수입)");
            connection.eval("png(filename='C:/Users/jsh32/git/Project2/shoping_project/src/main/webapp/resources/used-image/"+fileName+"',width=800,height=600)");
            connection.parseAndEval("print(ggplot(pp, aes(x = 이름, y = 판매수입, fill = pos)) + geom_col(size = .25) + scale_fill_manual(values = c('#F7756B', '#00BEFF')) +labs(fill='평균 이상')+ scale_y_continuous(labels = scales::comma)+theme(axis.title.y=element_text(size=20),axis.title.x=element_text(size=20)))");
            connection.parseAndEval("print(dev.off());");
            
            
            
            // textmining

            file = new File(path + "/"+fileName2);
            if( file.exists() ){
                if(file.delete()){
                    System.out.println(fileName2+"파일삭제 성공");
                }else{
                    System.out.println(fileName2+"파일삭제 실패");
                }
            }else{
                System.out.println(fileName2+"파일이 존재하지 않습니다.");
            }
            
            System.out.println("1");
            
            
            connection.eval("library(KoNLP)");
            connection.eval("require(KoNLP)");
            connection.eval("library(wordcloud)");
            connection.eval("require(wordcloud)");
            connection.eval("library(dplyr)");
            connection.eval("require(dplyr)");
            connection.eval("library(RColorBrewer)");
            connection.eval("require(RColorBrewer)");
            connection.eval("useSejongDic()");
            
            connection.eval("review <- ('"+reviewTxt+"')");
            connection.eval(" txt<- gsub('[~!@#$%&*()_+=?<>]','',txt)");
           /* connection.eval(" txt <- gsub('\\d+','',txt)");*/
           /* txt <- str_replace_all(txt, "\\W", " ")*/
            connection.eval("nouns <- extractNoun(review)");
            connection.eval("wordcount <- table(unlist(nouns))");
            connection.eval("df_word <- as.data.frame(wordcount, stringsAsFactors = F)");
            connection.eval("df_word <- rename(df_word,word = Var1,freq = Freq)");
            connection.eval("df_word <- filter(df_word, nchar(word) >= 2)");
            connection.eval("top_20 <- df_word %>% arrange(desc(freq)) %>% head(20)");
            connection.eval("pal <- brewer.pal(9,'Blues')[5:9]");
            connection.eval("palete <- brewer.pal(9,'Set1')");
            connection.eval("png(filename='C:/Users/jsh32/git/Project2/shoping_project/src/main/webapp/resources/used-image/"+fileName2+"',width=400,height=300)");
            connection.parseAndEval("print(wordcloud(words = df_word$word, freq=df_word$freq, scale=c(5,0.5), rot.per=0.25, min.freq=1, random.order=F, random.color=T, colors=pal))");
            connection.parseAndEval("print(dev.off());");
            
            connection.close();	
            
            //리뷰 평균 점수 얻기
            List<Object> reviewTemp = reviewSvc.getReviewAvgScore(); // DAO
            List<Object[]> reviewlist = to.toList(reviewTemp.toArray()); // custom 변환 메서드
            
            String a = "";
            String b = "";

            // 나열 출력
            for(int i=0; i<reviewlist.size(); i++) {
            	
            	for(int j=0; j<reviewlist.get(i).length; j++) {
            		if(j==0) {
            			a += (String)reviewlist.get(i)[j]+",";
            		}
            		else if(j==1) {
            			b += (String)reviewlist.get(i)[j]+",";
            		}
            		
            	}
            }
            
            a = a.substring(0, a.length()-1);
            b = b.substring(0, b.length()-1);
            
            StringTokenizer st = new StringTokenizer(a, ",");
            StringTokenizer st2 = new StringTokenizer(b, ",");
            int[] boardNumArray = new int[reviewlist.size()];
            double[] ScoreArray = new double[reviewlist.size()];
            int[] ScoreStarArray = new int[reviewlist.size()];
            int countToken = st.countTokens();
            System.out.println("countToken :"+countToken);
            for(int i=0; i<countToken; i++) {
            	
            	boardNumArray[i] = Integer.parseInt(st.nextToken().trim());
            	ScoreArray[i] = Double.parseDouble(st2.nextToken().trim());
            	ScoreStarArray[i] = (int)Math.floor(ScoreArray[i]);
            	
            }
            
            for(int i=0; i<countToken; i++) {
	            System.out.println("boardNumArray[i] : "+boardNumArray[i]);
	        	System.out.println("ScoreArray[i] : "+ScoreArray[i]);
	        	System.out.println("ScoreStarArray[i] : "+ScoreStarArray[i]);
            }
            
            
            String[] boardName = new String[countToken];
            //boardnum에 맞는 이름 가져오기
            for(int i=0; i<countToken; i++) {
            		System.out.println("boardSvc.getArticle(boardNumArray[i]).getBoardSubject() :" +boardSvc.getArticle(boardNumArray[i]).getBoardSubject());
            		boardName[i] = boardSvc.getArticle(boardNumArray[i]).getBoardSubject();
            }
            
            model.addAttribute("boardName", boardName);
            model.addAttribute("ScoreArray", ScoreArray);
            model.addAttribute("ScoreStarArray", ScoreStarArray);
            model.addAttribute("reviewText", fileName2);
            model.addAttribute("viewPage", fileName);
            
        } catch (Exception e) {
        	System.out.println("!! 에러 !!");
            System.out.println(e);
        }
        
        return "/admin/management";
	}
	
	

	@RequestMapping("/discount.do/{boardNum}")
	public String discount(@PathVariable("boardNum") int boardNum, HttpServletRequest request) {
		
		String disImage = request.getParameter("disImage"); // 할인 선택이냐 new 선택이냐
		int page = Integer.parseInt(request.getParameter("page")); //현재 페이지
		
		System.out.println("boardNum : " + boardNum);
		
		int price = 0;
		if(!request.getParameter("price").isEmpty()) {
			price = Integer.parseInt(request.getParameter("price"));
		}
		
		BoardVO board = boardSvc.getArticle(boardNum);
		board.setBoardDflag(disImage);
		board.setBoardSale(price);
		
		boardSvc.updateBoardSale(board);
		
		return "redirect:/board/mouse/"+page;
	}
	
}
