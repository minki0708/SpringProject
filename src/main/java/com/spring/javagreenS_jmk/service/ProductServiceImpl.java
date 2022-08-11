package com.spring.javagreenS_jmk.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javagreenS_jmk.dao.ProductDAO;
import com.spring.javagreenS_jmk.pagination.PageVO;
import com.spring.javagreenS_jmk.vo.OrderVO;
import com.spring.javagreenS_jmk.vo.ProductReplyVO;
import com.spring.javagreenS_jmk.vo.ProductVO;
import com.spring.javagreenS_jmk.vo.UserVO;
import com.spring.javagreenS_jmk.vo.reportVO;

@Service
public class ProductServiceImpl implements ProductService {
	
	@Autowired
	ProductDAO productDAO;

	// ckeditor에 저장되어있는 파일을 폴더로 복사처리
	@Override
	public void imgCheck(String content) {
		//      		  1         2         3         4         5         6
		//      012345678901234567890123456789012345678901234567890123456789012345678901234567890
		// <img src="/javagreenS_jmk/data/ckeditor/220622152246_map.jpg" style="height:838px; width:1489px" /></p>
		
		// 이 작업은 content안에 그림파일(img src="/)가 있을때만 수행한다.
		if(content.indexOf("src=\"/") == -1) return;
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/");
		
//		int position = 31;
		int position = 35;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
			String oriFilePath = uploadPath + imgFile;
			String copyFilePath = uploadPath + "repository/" + imgFile;
			
			fileCopyCheck(oriFilePath, copyFilePath);	// board폴더에 파일을 복사처리한다.
			
			if(nextImg.indexOf("src=\"/") == -1) {
				sw = false;
			}
			else {
				nextImg =nextImg.substring(nextImg.indexOf("src=\"/") + position);
			}
		}
		
	} 
	
	// 실제 서버(ckeditor)에 저장되어 있는 파일을 board폴더로 복사처리한다. 
	private void fileCopyCheck(String oriFilePath, String copyFilePath) {
		File oriFile = new File(oriFilePath);
		File copyFile = new File(copyFilePath);
		
		try {
			FileInputStream fis = new FileInputStream(oriFile);
			FileOutputStream fos = new FileOutputStream(copyFile);
			
			byte[] buffer = new byte[2048];
			int count = 0;
			while((count = fis.read(buffer)) != -1) {
				fos.write(buffer, 0, count);
			}
			fos.flush();
			fos.close();
			fis.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	//	썸네일 사진과 상품 정보 입력
	@Override
	public void setProductInput(MultipartHttpServletRequest mfile, ProductVO vo) {
		try {
			List<MultipartFile> fileList = mfile.getFiles("file");
			String oFileNames = "";
			String sFileNames = "";

			
			for(MultipartFile file : fileList) {
				String oFileName = file.getOriginalFilename();
				String sFileName = saveFileName(oFileName);	// 서버에 저장될 파일명을 결정해준다.
				
				writeFile(file, sFileName);		// 서버에 파일 저장처리하기
				
				oFileNames += oFileName + "/";
				sFileNames += sFileName + "/";

			}
			vo.setFName(oFileNames);
			vo.setFSName(sFileNames);
			
			productDAO.setProductInput(vo);		// 서버에 파일 저장완료후 DB에 내역을 저장시켜준다.
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	// 썸네일 사진 업로드
	private void writeFile(MultipartFile file, String sFileName) throws IOException {
		byte[] data = file.getBytes();
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/pds/");
		
		FileOutputStream fos = new FileOutputStream(uploadPath + sFileName);
		fos.write(data);
		fos.close();
	}

	// 저장되는 파일명의 중복을 방지하기위해 새로 파일명을 만들어준다.
	private String saveFileName(String oFileName) {
		String fileName = "";
		
		Calendar cal = Calendar.getInstance();
		fileName += cal.get(Calendar.YEAR);
		fileName += cal.get(Calendar.MONTH);
		fileName += cal.get(Calendar.DATE);
		fileName += cal.get(Calendar.HOUR);
		fileName += cal.get(Calendar.MINUTE);
		fileName += cal.get(Calendar.SECOND);
		fileName += cal.get(Calendar.MILLISECOND);
		fileName += "_" + oFileName;
		
		return fileName;
	}

	@Override
	public List<ProductVO> getProductList(int startIndexNo, int pageSize) {
		return productDAO.getProductList(startIndexNo, pageSize);
	}

	@Override
	public ProductVO getContent(int idx) {
		ProductVO vo = productDAO.getContent(idx);
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
			LocalDateTime date = LocalDateTime.parse(vo.getDate(),formatter);		
			LocalDateTime now = LocalDateTime.now();
			long second = ChronoUnit.SECONDS.between(date, now);
			
			if(second < 60) {
				vo.setStrdate(second+"초 전");
			}
			else if(second < (60*60)) {
				vo.setStrdate((second/60)+"분 전");
			}
			else if(second < (60*60*24)) {
				vo.setStrdate((second/60/60)+"시간 전");
			}
			else if(second < (60*60*24*7)) {
				vo.setStrdate((second/60/60/24)+"일 전");
			}
			else if(second < (60*60*24*7*4)) {
				vo.setStrdate((second/60/60/24/7)+"주 전");
			}
			else if(second < (60*60*24*7*4*12)) {
				vo.setStrdate((second/60/60/24/7/4)+"달 전");
			}
			
		return vo;
	}
	
	// 게시판(board)의 ckeditor에서 올린 이미지파일을 삭제처리한다.
	@Override
	public void imgDelete(String content) {
		//      0         1         2         3         4         5         6
		//      012345678901234567890123456789012345678901234567890123456789012345678901234567890
		// <img src="/javagreenS/data/ckeditor/board/220622152246_map.jpg" style="height:838px; width:1489px" /></p>
		
		if(content.indexOf("src=\"/") == -1) return;
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/board/");
		
		int position = 37;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		int cnt = 0;
		while(sw) {
			System.out.println("cnt  : " + cnt);
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
			String oriFilePath = uploadPath + imgFile;
			
			fileDelete(oriFilePath);	// board폴더에 존재하는 파일을 삭제처리한다.
			
			if(nextImg.indexOf("src=\"/") == -1) {
				sw = false;
			}
			else {
				nextImg =nextImg.substring(nextImg.indexOf("src=\"/") + position);
			}
		}
	}

	// 원본이미지를 삭제처리한다.(resources/data/ckeditor/board 폴더에서 삭제처리)
	private void fileDelete(String oriFilePath) {
		File delFile = new File(oriFilePath);
		if(delFile.exists()) delFile.delete();
	}

	@Override
	public void imgCheckUpdate(String content) {
		//      0         1         2         3         4         5         6
		//      012345678901234567890123456789012345678901234567890123456789012345678901234567890
		// <img src="/javagreenS/data/ckeditor/repository/220622152246_map.jpg" style="height:838px; width:1489px" /></p>
		
		if(content.indexOf("src=\"/") == -1) return;
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/repository/");
		
		int position = 42;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
			String oriFilePath = uploadPath + imgFile;
			String copyFilePath = request.getRealPath("/resources/data/ckeditor/" + imgFile);
			
			fileCopyCheck(oriFilePath, copyFilePath);	
			
			if(nextImg.indexOf("src=\"/") == -1) {
				sw = false;
			}
			else {
				nextImg =nextImg.substring(nextImg.indexOf("src=\"/") + position);
			}
		}		
	}

	@Override
	public void setProductUpdate(MultipartHttpServletRequest mfile,ProductVO vo) {
		try {
			List<MultipartFile> fileList = mfile.getFiles("file");
			String oFileNames = "";
			String sFileNames = "";

			
			for(MultipartFile file : fileList) {
				String oFileName = file.getOriginalFilename();
				String sFileName = saveFileName(oFileName);	// 서버에 저장될 파일명을 결정해준다.
				
				writeFile(file, sFileName);		// 서버에 파일 저장처리하기
				
				oFileNames += oFileName + "/";
				sFileNames += sFileName + "/";

			}
			vo.setFName(oFileNames);
			vo.setFSName(sFileNames);
			
			productDAO.setProductUpdate(vo);		// 서버에 파일 저장완료후 DB에 내역을 저장시켜준다.
		} catch (IOException e) {
			e.printStackTrace();
		}		
	}

	@Override
	public ProductVO getProductIdx(int idx) {
		return productDAO.getProductIdx(idx);
	}

	@Override
	public ProductVO checkLikes(int idx, int sIdx) {
		return productDAO.checkLikes(idx,sIdx);
	}

	@Override
	public void insertLikes(int idx, int sIdx) {
		productDAO.insertLikes(idx,sIdx);
	}

	@Override
	public void deleteLikes(int idx, int sIdx) {
		productDAO.deleteLikes(idx, sIdx);
	}

	@Override
	public int getLikes(int idx) {
		return productDAO.getLikes(idx);
	}

	@Override
	public List<ProductReplyVO> getProductReply(int idx) {
		return productDAO.getProductReply(idx);
	}

	@Override
	public void setProductReply(ProductReplyVO vo) {
		productDAO.setProductReply(vo);
	}

	@Override
	public void deleteReply(ProductReplyVO vo) {
		productDAO.deleteReply(vo);
	}

	@Override
	public void deleteParentReply(ProductReplyVO vo) {
		productDAO.deleteParentReply(vo);
	}

	@Override
	public List<ProductVO> getProductSearch(int startIndexNo, int pageSize, String searchString, String type) {
		return productDAO.getProductSearch(startIndexNo,pageSize,searchString,type);
	}

	@Override
	public void setBlockProject(int idx, String text) {
		productDAO.setBlockProject(idx, text);
	}

	@Override
	public List<ProductVO> getProductByCategory(int lCategory, int mCategory, int sCategory) {
		return productDAO.getProductByCategory(lCategory, mCategory, sCategory);
	}

	@Override
	public void setReplyReport(reportVO vo) {
		productDAO.setReplyReport(vo);	
	}

	@Override
	public void setProductReport(reportVO vo) {
		productDAO.setProductReport(vo);
	}

	@Override
	public void setReadCount(int sIdx, int idx) {
		int count = productDAO.getReadCount(sIdx, idx);
		if(count == 0) {
			productDAO.setReadCount(sIdx, idx);			
		}
		else {
			return;
		}
	}

}
