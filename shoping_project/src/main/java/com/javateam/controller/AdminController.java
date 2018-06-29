package com.javateam.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.eclipse.jdt.internal.compiler.parser.ParserBasicInformation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.javateam.model.vo.BoardDTO;
import com.javateam.model.vo.BoardVO;
import com.javateam.service.BoardService;
import com.javateam.util.FileUploadUtil;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/admin")
public class AdminController {


	@Autowired
	private BoardService boardSvc;
	
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
	

	@RequestMapping(value="/updateAction.do")
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

}
