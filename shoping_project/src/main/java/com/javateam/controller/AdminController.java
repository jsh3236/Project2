package com.javateam.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.javateam.model.vo.BoardDTO;
import com.javateam.model.vo.BoardVO;
import com.javateam.service.BoardService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/admin")
public class AdminController {

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
	
	@RequestMapping("/test")
	@ResponseBody
	public String test(HttpServletRequest request) {
		
		for(int i = 0; true; i++)
        {
		String image = "g903.jpg";
		image = image.substring(0, image.indexOf('.'));
	  	image =  image + "_" + i+".jpg";
	  	
	  	return image;
        }
		
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

		MultipartFile file = boardDTO.getBoardFile(); // 업로드 파일
		MultipartFile file2 = boardDTO.getBoardFileContent();
		BoardVO boardVO = new BoardVO(boardDTO); // DTO -> VO
		
		boardVO.setBoardFile(fileUpload(file, boardDTO, request,boardVO));
		boardVO.setBoardFileContent(fileUpload(file2, boardDTO, request,boardVO));

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
		//model.addAttribute("msg", "게시글을 성공적으로 저장하였습니다");
		/*ra.addAttribute("msg", "게시글");*/
	/*	listBoard(1,model);// 메시지 페이지*/
	/*	return "board/mouseBoard"; */
		
		return "redirect:/board/mouse/1";
	} //
	
	public String fileUpload(MultipartFile file, BoardDTO boardDTO, HttpServletRequest request,BoardVO boardVO) {
		FileOutputStream fos = null;

		// 업로드 파일 처리
		if (file != null) { // 파일 유효성 점검

			String image = file.getOriginalFilename();

			// 파일 저장소에 저장
			try {
				byte[] bytes = file.getBytes();

				//File imageFile = new File(uploadDirResource.getPath() + image);
				File imageFile = new File(request.getRealPath(uploadDirResource.getPath()) + image);
				
				 // 같은 이름의 파일이름 처리
	            if(imageFile.exists())
	            {
	                  for(int i = 0; true; i++)
	                  {
	                	  	image = image.substring(0, image.indexOf('.'));
	                	  	image =  image + "_" + i+".jpg";
	                	  	System.out.println("image 값 : "+image);
	                        imageFile = new File(request.getRealPath(uploadDirResource.getPath()), image);
	    
	                        if(!imageFile.exists())
	                        {
	                              image = image + "_" + i;
	                              break;
	                        }
	                  }
	            }
	            System.out.println("imageFile 값 : "+imageFile);
	            fos = new FileOutputStream(imageFile);
				fos.write(bytes);
				
				
				
				log.info("파일 업로드 성공");
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
			
			return image;
		} // 
		return null;
		
	}
	


}
