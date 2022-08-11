package com.spring.javagreenS_jmk;


import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javagreenS_jmk.pagination.PageProcess;
import com.spring.javagreenS_jmk.pagination.PageVO;
import com.spring.javagreenS_jmk.service.AdminService;
import com.spring.javagreenS_jmk.service.ProductService;
import com.spring.javagreenS_jmk.vo.CategoryVO;
import com.spring.javagreenS_jmk.vo.OrderVO;
import com.spring.javagreenS_jmk.vo.ProductVO;

@Controller
public class HomeController {

	@Autowired
	ProductService productService;
	
	@Autowired
	AdminService adminService;
	
	@Autowired
	PageProcess pageProcess;
	
	@RequestMapping(value = {"/","/main"}, method = RequestMethod.GET)
	public String home(Model model,
			HttpSession session, 
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "18", required = false) int pageSize) {
		int sAuthority = session.getAttribute("sAuthority")==null ? 2 : (int) session.getAttribute("sAuthority");
		PageVO pageVo = pageProcess.totRecCnt(pag, pageSize, "product", "", "");
		List<ProductVO> vos = productService.getProductList(pageVo.getStartIndexNo(), pageSize);
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
		 
		for (ProductVO vo : vos) {	
			LocalDateTime date = LocalDateTime.parse(vo.getDate(),formatter);		
			LocalDateTime now = LocalDateTime.now();
			long second = ChronoUnit.SECONDS.between(date, now);
			
			if(second < 60) {
				vo.setDate(second+"초 전");
			}
			else if(second < (60*60)) {
				vo.setDate((second/60)+"분 전");
			}
			else if(second < (60*60*24)) {
				vo.setDate((second/60/60)+"시간 전");
			}
			else if(second < (60*60*24*7)) {
				vo.setDate((second/60/60/24)+"일 전");
			}
			else if(second < (60*60*24*7*4)) {
				vo.setDate((second/60/60/24/7)+"주 전");
			}
			else if(second < (60*60*24*7*4*12)) {
				vo.setDate((second/60/60/24/7/4)+"달 전");
			}
		}
		model.addAttribute("sAuthority", sAuthority);
		model.addAttribute("pageVo", pageVo);
		model.addAttribute("vos", vos);
		
		return "user/main";
	}
	
	@ResponseBody
	@RequestMapping(value="/nav", produces = "application/json", method = RequestMethod.POST)
	public List<CategoryVO> nav(Model model) {
		List<CategoryVO> categoryVO = adminService.getLCategories();

		return categoryVO;
	}

//
//	@GetMapping("/nav")
//	public String payment(Model model) {
//		List<CategoryVO> categoryVO = adminService.getLCategories();
//		System.out.println("nav" + categoryVO);
//		model.addAttribute("categoryVO",categoryVO);
//		return "";
//	}
}
