package com.javateam.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.sql.Date;
import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.javateam.model.vo.BoardDTO;
import com.javateam.model.vo.BoardVO;
import com.javateam.service.deprecated.BoardService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/admin")
public class BoardController {

	@Autowired
	private FileSystemResource uploadDirResource; // 업로드 파일 처리

	@Autowired
	private BoardService boardSvc;
	
	@RequestMapping("/mouseBoardwrite")
	public String mouseBoard(Model model) {

		log.info("게시판 글쓰기");
		model.addAttribute("board", new BoardDTO());

		return "/admin/writing";
	} //

	@RequestMapping(value="/writeAction.do",method={RequestMethod.POST,RequestMethod.GET},
			produces="text/plain; charset=UTF-8")
	public String writeAction(@Valid @ModelAttribute("board") BoardDTO boardDTO, BindingResult result, Model model) {
		
		System.out.println("게시판 글쓰기 처리");
		System.out.println("게시글 : "+ boardDTO);

		if (result.hasErrors()) { // 폼 유효성 점검

			log.info("form invalid !");

			return "/admin/writing";
		} //

		MultipartFile file = boardDTO.getBoardFile(); // 업로드 파일
		FileOutputStream fos = null;
		BoardVO boardVO = new BoardVO(boardDTO); // DTO -> VO

		// 업로드 파일 처리
		if (!boardDTO.getBoardFile().isEmpty() && file != null) { // 파일 유효성 점검

			String fileName = file.getOriginalFilename();

			// 파일 저장소(E:\\lsh\\fileupload) 에 저장
			try {
				byte[] bytes = file.getBytes();

				File outFileName = new File(uploadDirResource.getPath() + fileName);
				fos = new FileOutputStream(outFileName);

				fos.write(bytes);

			} catch (IOException e) {
				log.info("BoardController save File writing error ! ");
				e.printStackTrace();
			} finally {
				try {
					if (fos != null)
						fos.close();
				} catch (IOException e) {
					log.info("BoardController save IOE : ");
					e.printStackTrace();
				}
				log.info("File upload success! ");
			} // try

		} // 업로드 파일 처리

		// 게시글 등록일
		// boardVO.setBoardDate(new Date(System.currentTimeMillis()));

		String dateString = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date(System.currentTimeMillis()))
				.toString();

		log.info("등록일 {}", dateString);
		boardVO.setBoardDate(dateString);

		log.info("등록일 {}", boardVO.getBoardDate());

		// 게시글 저장
		boardSvc.insertBoard(boardVO);

		// 결과 메시지 생성
		model.addAttribute("msg", "게시글을 성공적으로 저장하였습니다");

		 return "/admin/msg"; // 메시지 페이지
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
