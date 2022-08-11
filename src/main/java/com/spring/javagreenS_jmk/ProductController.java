package com.spring.javagreenS_jmk;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.mysql.cj.Session;
import com.spring.javagreenS_jmk.pagination.PageProcess;
import com.spring.javagreenS_jmk.pagination.PageVO;
import com.spring.javagreenS_jmk.service.AdminService;
import com.spring.javagreenS_jmk.service.ProductService;
import com.spring.javagreenS_jmk.service.UserService;
import com.spring.javagreenS_jmk.vo.CategoryVO;
import com.spring.javagreenS_jmk.vo.OrderVO;
import com.spring.javagreenS_jmk.vo.ProductReplyVO;
import com.spring.javagreenS_jmk.vo.ProductVO;
import com.spring.javagreenS_jmk.vo.UserVO;
import com.spring.javagreenS_jmk.vo.reportVO;

@Controller
@RequestMapping("/product")
public class ProductController {
	
	@Autowired
	ProductService productService;
	
	@Autowired
	AdminService adminService;
	
	@Autowired
	UserService userService;
	
	@Autowired
	PageProcess pageProcess;
	
	// 카테고리 중분류 소분류 목록
	@ResponseBody
	@PostMapping("/selectCategory")
	public List<CategoryVO> selectCategory(CategoryVO vo) {
		return adminService.getCategories(vo);
	}
	
	// 업로드 페이지와 대분류
	@GetMapping("/upload")
	public String boInputGet(Model model, HttpSession session) {
		String nickName = (String) session.getAttribute("sNickName");
		List<CategoryVO> vos = adminService.getLCategories();
		
		model.addAttribute("nickName",nickName);
		model.addAttribute("vos", vos);
		return "product/upload";
	}
    
	@PostMapping(value = "/upload")
	public String boInputPost(ProductVO vo, String nickName, MultipartHttpServletRequest file) {
		UserVO userVO = userService.getNickName(nickName);
		vo.setUserIdx(userVO.getIdx());
		// 만약에 content에 이미지가 저장되어 있다면, 저장된 이미지만을 /resources/data/ckeditor/board/ 폴더에 저장시켜준다.
		productService.imgCheck(vo.getContent());
		
		// 이미지 복사작업이 끝나면, board폴더에 실제로 저장된 파일명을 DB에 저장시켜준다.
		vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/ckeditor/repository/"));
		productService.setProductInput(file, vo);
		return "redirect:/msg/uploadSuccess";
	}
	
	@ResponseBody
	@RequestMapping("/imageUpload")
	public void imageUploadGet(HttpServletRequest request, HttpServletResponse response,
			MultipartFile upload) throws Exception {
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String originalFilename = upload.getOriginalFilename();
		
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
		originalFilename = sdf.format(date) + "_" + originalFilename;
		
		byte[] bytes = upload.getBytes();
		
		// ckeditor에서 올린(전송한) 파일을, 서버 파일시스템에 실제로 파일을 저장시킨다.
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/");
		OutputStream outStr = new FileOutputStream(new File(uploadPath + originalFilename));
		outStr.write(bytes);
		
		// 서버 파일시스템에 저장된 파일을 화면에 보여주기위한 작업.
		PrintWriter out = response.getWriter();
		String fileUrl = request.getContextPath() + "/data/ckeditor/" + originalFilename;
		/* {"atom":"12.jpg","변수":1,~~~~} */
		out.println("{\"originalFilename\":\""+originalFilename+"\",\"uploaded\":1,\"url\":\""+fileUrl+"\"}");
		
		out.flush();
		outStr.close();
	}
	
	@GetMapping("/content")
	public String ContentGet(int idx, Model model, HttpSession session
			,@RequestParam(name="mode", defaultValue = "user", required = false) String mode
			) {
		int sIdx = session.getAttribute("sIdx")== null ? 0 : (int) session.getAttribute("sIdx");
		if(sIdx != 0) {
			productService.setReadCount(sIdx,idx);
		}
		ProductVO vo = productService.getContent(idx);
		int likes = productService.getLikes(idx);
		List<ProductReplyVO> replyVos = productService.getProductReply(idx);
		UserVO userVo = userService.getUserInfoByIdx(vo.getUserIdx());
		
		model.addAttribute("userVo", userVo);
		model.addAttribute("vo", vo);
		model.addAttribute("sIdx", sIdx);
		model.addAttribute("likes", likes);
		model.addAttribute("replyVos", replyVos);
		model.addAttribute("mode", mode);
		return "product/content";
	}

	@GetMapping("/update")
	public String UpdateGet(int idx, Model model, HttpSession session) {
		//	유저idx와 프로덕트vo에 저장된 userIdx가 다를시 메인으로 보냄 (인터셉터로 로그인안했을시 거르기)
		int sIdx = (int) session.getAttribute("sIdx");
		ProductVO vo2 = productService.getProductIdx(idx);
		if(vo2.getUserIdx() != sIdx && sIdx != 1) return "redirect:/main";
		
		ProductVO vo = productService.getContent(idx);
		List<CategoryVO> vos = adminService.getLCategories();
		
		model.addAttribute("vo", vo);
		model.addAttribute("vos", vos);
		return "product/update";
	}
	
	@PostMapping("/update")
	public String UpdatePost(ProductVO vo, Model model, HttpSession session, MultipartHttpServletRequest file) {

		// 수정창으로 들어올때 원본파일에 그림파일이 존재한다면, 현재폴더(board)의 그림파일을 ckeditor폴더로 복사시켜둔다.
		ProductVO oriVo = productService.getContent(vo.getIdx()); 
		// content안에서 내용의 수정이 없을시는 아래작업을 처리할 필요가 없다.
		if(!oriVo.getContent().equals(vo.getContent()))	{

			// 수정버튼을 클릭하고 post 호출시에는 기존의 board폴더의 사진파일들을 모두 삭제처리한다.
			if(oriVo.getContent().indexOf("src=\"/") != -1) productService.imgDelete(oriVo.getContent());
			
			// 파일복사전에 원본파일의 위치가 'ckeditor/board'폴더였던것을 'ckeditor'폴더로 변경시켜두어야 한다.
			vo.setContent(vo.getContent().replace("/data/ckeditor/repository/", "/data/ckeditor/"));
			
			// 앞의 준비작업이 완료되면, 수정된 그림(복사된그림)을 다시 board폴더에 속사처리한다.(/data/ckeditor/ -> /data/ckeditor/board/)
			// 이 작업은 처음 게시글을 올릴때의 파일복사 작업과 동일한 작업이다.
			productService.imgCheck(vo.getContent());
			
			// 다시 ckeditor에 있는 그림파일의 경로를 ckeditor/board폴더로 변경시켜준다.
			vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/ckeditor/repository/"));
		}
		
		// 잘 정비된 vo를 DB에 저장시켜준다.
		productService.setProductUpdate(file,vo);
		
//		model.addAttribute("flag", "?pag="+pag+"&pageSize="+pageSize);

		return "redirect:/msg/updateSuccess?flag="+vo.getIdx();
	}
	
	@ResponseBody
	@RequestMapping(value = "/like",method = RequestMethod.POST)
	public String like(int idx, HttpSession session) {
		int sIdx = (int) session.getAttribute("sIdx");
			ProductVO vo = productService.checkLikes(idx,sIdx);		
			
			if(vo == null) {
				productService.insertLikes(idx,sIdx);
				return "1";
			}
			else{
				productService.deleteLikes(idx,sIdx);
				return "2";
			}	
	}
	
	@ResponseBody
	@PostMapping("/productReplyInput")
	public String productReplyInput(ProductReplyVO vo,HttpSession session) {
		int sIdx = session.getAttribute("sIdx")== null? 0 : (int) session.getAttribute("sIdx");

		vo.setUserIdx(sIdx);
		productService.setProductReply(vo);			
		
		return "1";
	}
	
	@ResponseBody
	@PostMapping("/replyDelete")
	public String replyDelete(ProductReplyVO vo,HttpSession session) {
		int sIdx = session.getAttribute("sIdx")== null? 0 : (int) session.getAttribute("sIdx");
		System.out.println("vo"+vo);
		vo.setUserIdx(sIdx);
		if(vo.getParentIdx() != 0) {
			productService.deleteReply(vo);			
		}
		else {
			productService.deleteParentReply(vo);
		}
		return "1";
	}
	
	@GetMapping("/report")
	public String report(int idx, Model model, HttpSession session) {
		return "product/update";
	}
	
	@GetMapping("/productSearch")
	public String productSearch(String searchString,
			String type,
			Model model,			
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "15", required = false) int pageSize
			) {
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "product", "", searchString);
		List<ProductVO> vos = productService.getProductSearch(pageVO.getStartIndexNo(), pageSize, searchString, type);			
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		return "product/search";
	}
	
	@GetMapping("/categoryProduct")
	public String categoryProduct(Model model, String type,			
			@RequestParam(name="lCategory", defaultValue = "0", required = false) int lCategory,
			@RequestParam(name="mCategory", defaultValue = "0", required = false) int mCategory,
			@RequestParam(name="sCategory", defaultValue = "0", required = false) int sCategory,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "15", required = false) int pageSize
			) {
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "product", "", "");
		List<ProductVO> vos = productService.getProductByCategory(lCategory,mCategory,sCategory);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		return "product/search";
	}
	
	@ResponseBody
	@PostMapping("/blockProduct")
	public String blockProduct(int idx, String text) {
		productService.setBlockProject(idx, text);
		return "1";
	}
	
	@ResponseBody
	@PostMapping("/reportReply")
	public String reportReply(reportVO vo) {
		productService.setReplyReport(vo);
		return "1";
	}
	
	@ResponseBody
	@PostMapping("/reportProduct")
	public String reportProduct(reportVO vo) {
		productService.setProductReport(vo);
		return "1";
	}
	
	
		
}
