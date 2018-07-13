package com.javateam.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.web.multipart.MultipartFile;

import com.javateam.model.vo.BoardDTO;
import com.javateam.model.vo.BoardVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class FileUploadUtil {
	
	public String fileUpload(MultipartFile file, BoardDTO boardDTO, HttpServletRequest request,BoardVO boardVO) {
		FileOutputStream fos = null;
		/*String path = "D:\\jsh-work\\used-image\\";*/
		String path = "C:\\Users\\jsh32\\git\\Project2\\shoping_project\\src\\main\\webapp\\resources\\used-image\\";
		
		// 업로드 파일 처리
		if (file != null) { // 파일 유효성 점검
			String image = file.getOriginalFilename();
			String regex = "\\S+_+[0-9]+\\.[a-z]+";
			
			// 파일 저장소에 저장
			try {
				byte[] bytes = file.getBytes();

				//File imageFile = new File(uploadDirResource.getPath() + image);
				File imageFile = new File(path+image);
				 // 같은 이름의 파일이름 처리
	            if(imageFile.exists())
	            {
	                  for(int i = 0; ; i++)
	                  {
		          			
		        			if(image.matches(regex)) image = image.substring(0, image.indexOf('.')-2);
		        			else if(i>=10) image = image.substring(0, image.indexOf('.')-(i-7)); // _ 늘어나는 버그패치 06/26
		        			else image = image.substring(0, image.indexOf('.'));
		        		  	image =  image + "_" + i+".jpg";
	                	  	System.out.println("### 1: image 값 : "+image);
	                        imageFile = new File(path+image);
	    
	                        if(!imageFile.exists())
	                        {
	                        	System.out.println("6");
	                			if(image.matches(regex)) image = image.substring(0, image.indexOf('.')-2);
	                			else image = image.substring(0, image.indexOf('.'));
	                		  	image =  image + "_" + i+".jpg";
	                        	System.out.println("### 2: image 값 : "+image);
	                            break;
	                        }
	                  }
	            }
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
