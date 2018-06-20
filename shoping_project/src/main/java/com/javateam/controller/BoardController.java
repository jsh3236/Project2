package com.javateam.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import com.javateam.model.vo.BoardDTO;
import com.javateam.model.vo.BoardVO;
import com.javateam.model.vo.PageInfo;
import com.javateam.service.BoardService;

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

			String image = file.getOriginalFilename();

			// 파일 저장소(E:\\lsh\\fileupload) 에 저장
			try {
				byte[] bytes = file.getBytes();

				File imageFile = new File(uploadDirResource.getPath() + image);
				
				
				 // 같은 이름의 파일이름 처리
	            if(imageFile.exists())
	            {
	                  for(int i = 0; true; i++)
	                  {
	                        imageFile = new File("C:\\test", image + "_" + i);
	    
	                        if(!imageFile.exists())
	                        {
	                              image = image + "_" + i;
	                              break;
	                        }
	                  }
	            }
	            
	            fos = new FileOutputStream(imageFile);
				fos.write(bytes);
				
				// 썸네일 이미지 생성
/*	            File destFile = new File("C:\\test", image + ".small.jpg");
	           ImageUtil.resize(imageFile, destFile, 50, ImageUtil.RATIO);*/


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
	

    @RequestMapping("/list/{page}")
    public String listBoard(@PathVariable("page") int page,
                          Model model) {
    	
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
