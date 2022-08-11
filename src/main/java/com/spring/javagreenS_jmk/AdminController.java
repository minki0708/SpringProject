package com.spring.javagreenS_jmk;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
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

import com.spring.javagreenS_jmk.pagination.PageProcess;
import com.spring.javagreenS_jmk.pagination.PageVO;
import com.spring.javagreenS_jmk.service.AdminService;
import com.spring.javagreenS_jmk.vo.AdminVO;
import com.spring.javagreenS_jmk.vo.CategoryVO;
import com.spring.javagreenS_jmk.vo.OrderVO;
import com.spring.javagreenS_jmk.vo.ProductVO;
import com.spring.javagreenS_jmk.vo.UserVO;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	AdminService adminService;
	
	@Autowired
	PageProcess pageProcess;
	
	@GetMapping("/adMenu")
	public String adMenuGet() {
		int memeberCount = 0;
		int productCount = 0;
		int orderCount = 0;
		int reportCount = 0;
		//회원수 상품수 주문수 신고수
		return "admin/adMenu";
	}
	
	@GetMapping("/adUserManage")
	public String adUserManage(Model model) {
		List<UserVO> vos = adminService.getUserList();
		
		model.addAttribute("vos",vos);
		return "admin/adUserManage";
	}
	
	@RequestMapping(value="/adList", method = RequestMethod.GET)
	public String adLeftGet() {
		return "admin/adList";
	}
	
	@RequestMapping(value="/adContent", method = RequestMethod.GET)
	public String adContentGet(Model model) {
		return "admin/adContent";
	}
	
	// 대분류 AND 페이지
	@GetMapping("/adCategory")
	public String adUpdateCategory(Model model) {
		List<CategoryVO> vos = adminService.getLCategories();
		model.addAttribute("vos", vos);
		return "admin/adCategory";
	}
	
	// 중분류 소분류 목록
	@ResponseBody
	@RequestMapping(value="/selectCategory", method = RequestMethod.POST)
	public List<CategoryVO> selectCategory(CategoryVO vo) {
		return adminService.getCategories(vo);
	}
	
	// 카테고리 등록
	@ResponseBody
	@PostMapping("/insertCategory")
	public String insertCategory(CategoryVO vo, Model model) {
		adminService.insertCategory(vo);
		return "1";
	}
	
	// 카테고리 수정
	@ResponseBody
	@PostMapping("/updateCategory")
	public String updateCategory(CategoryVO vo, Model model) {
		adminService.updateCategory(vo);
		return "1";
	}

	// 카테고리 삭제
	@ResponseBody
	@PostMapping("/deleteCategory")
	public String deleteCategory(CategoryVO vo, Model model) {
		adminService.deleteCategory(vo);
		return "1";
	}
	
	// 카테고리 목록
	@ResponseBody
	@PostMapping("/categoryList")
	public String categoryList(CategoryVO vo, Model model) {
		List<CategoryVO> vos = adminService.categoryList(vo);
		model.addAttribute("vos", vos);
		return "";
	}
	
	@GetMapping("/adBlockedProductList")
	public String adBlockProductList(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "15", required = false) int pageSize) {
		PageVO pageVo = pageProcess.totRecCnt(pag, pageSize, "product", "", "");
		List<ProductVO> vos = adminService.getBlockedProduct();
	
		model.addAttribute("pageVo", pageVo);
		model.addAttribute("vos", vos);
		return "admin/adBlockedProductList";
	}
	
	@ResponseBody
	@PostMapping("/productDelete")
	public String productDelete(int idx) {
		adminService.productDelete(idx);
		return "";
	}
	
	@ResponseBody
	@PostMapping("/productReturn")
	public String productReturn(int idx) {
		adminService.productReturn(idx);
		return "";
	}
	
	@GetMapping("/adOrderManage")
	public String adOrderManage(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "15", required = false) int pageSize) {
		List<AdminVO> vos = adminService.getOrderList();
		model.addAttribute("vos", vos);
		return "admin/adOrderManage";
	}
	
	@GetMapping("/adStatistics")
	public String adStatistics(Model model,HttpSession session,
			@RequestParam(name="datepicker1", defaultValue = "2022-08-02", required = false)String datepicker1,
			@RequestParam(name="datepicker2", defaultValue = "2022-08-02", required = false)String datepicker2,
			@RequestParam(name="period", defaultValue = "1", required = false)int period,
		@RequestParam(name="calDate", defaultValue = "1", required = false)int calDate){
		//DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");	
		List<AdminVO> vos = adminService.getChartData(datepicker1,datepicker2);
		LocalDateTime now = LocalDateTime.now();
		String year = now.toString().substring(2,4);
		String month = now.toString().substring(6,7);
		String days = now.toString().substring(9,10);
		model.addAttribute("vos", vos);
		model.addAttribute("sCalDate", calDate);
		model.addAttribute("mPeriod", period);
		model.addAttribute("year", year);
		model.addAttribute("month", month);
		model.addAttribute("days", days);
		return "admin/adStatistics";
	}
	
	@ResponseBody
	@PostMapping("/adStatistics")
	public List<AdminVO> period(Model model,
			HttpSession session,
			String datepicker1,String datepicker2,
			@RequestParam(name="calDate", defaultValue = "1", required = false)int calDate,
			@RequestParam(name="period", defaultValue = "1", required = false)int period){
		List<AdminVO> vos = adminService.getChartData(datepicker1,datepicker2);
		
		session.setAttribute("vos", vos);
		model.addAttribute("vos", vos);
		session.setAttribute("sCalDate", calDate);
		session.setAttribute("sPeriod", period);
		return vos;
	}
	
	@GetMapping("/adReportList")
	public String adReportList(Model model,HttpSession session,
			@RequestParam(name="type", defaultValue = "상품", required = false) String type,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "15", required = false) int pageSize) {
		List<AdminVO> vos = adminService.getReportList(type);	
		System.out.println("voi"+vos);
		model.addAttribute("type", type);
		model.addAttribute("vos", vos);
		return "admin/adReportList";
	}
	
	@ResponseBody
	@PostMapping("/reportProduct")
	public String reportProduct(String status, int idx){
		if(status.equals("문제없음")) {
			adminService.cancleReportProduct(idx);
		}
		else {
			adminService.removeReportedProduct(idx);
		}
		
		return "";
	}

	@ResponseBody
	@PostMapping("/reportReply")
	public String reportReply(String status, int idx){
		if(status.equals("문제없음")) {
			adminService.cancleReportReply(idx);
		}
		else {
			adminService.removeReportedReply(idx);
		}
		return "";
	}
	
	// 임시파일 삭제 메뉴 부르기
	@RequestMapping(value="/adFileDelete", method = RequestMethod.GET)
	public String imsiFileDeleteGet() {
		return "admin/adFileDelete";
	}
	
	// 임시폴더의 파일내역보기
	@SuppressWarnings("deprecation")
	@ResponseBody
	@RequestMapping(value="/tempFileLoad", method = RequestMethod.POST)
	public String[] tempFileLoadPost(HttpServletRequest request, String folderName) throws IOException {
		String realPath = request.getRealPath("/resources/");
		
		if(folderName.equals("ckeditor")) {
			realPath += "data/ckeditor/";
		}
		else if(folderName.equals("pds")) {
			realPath += "data/pds/";
		}
		String[] files = new File(realPath).list();
		
		return files;
	}

	 // 임시폴더에서 선택항목 삭제하기
	@SuppressWarnings("deprecation")
	@ResponseBody
	@RequestMapping(value="/imsiFileDelete", method = RequestMethod.POST)
	public String tempFileLoadPost(HttpServletRequest request, String folderName, String delItems) {
		delItems = delItems.substring(0, delItems.length()-1);
		String uploadPath = request.getRealPath("/resources/data/") + folderName + "/";
		
		String[] fileNames = delItems.split("/");
		for(String fileName : fileNames) {
			String realPathFile = uploadPath + fileName;
			new File(realPathFile).delete();
		}
		return "";
	}
		
}
