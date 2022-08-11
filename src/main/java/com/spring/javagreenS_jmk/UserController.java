package com.spring.javagreenS_jmk;

import java.text.DecimalFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.List;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javagreenS_jmk.pagination.PageProcess;
import com.spring.javagreenS_jmk.pagination.PageVO;
import com.spring.javagreenS_jmk.service.UserService;
import com.spring.javagreenS_jmk.vo.AdminVO;
import com.spring.javagreenS_jmk.vo.OrderVO;
import com.spring.javagreenS_jmk.vo.ProductVO;
import com.spring.javagreenS_jmk.vo.UserVO;

@Controller
@RequestMapping("/user")
public class UserController {
	
	@Autowired
	UserService userService;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@Autowired 
	JavaMailSender mailSender;
	
	@Autowired
	PageProcess pageProcess;

	@GetMapping(value = "/login")
	public String loginPageGet(HttpServletRequest request) {
		Cookie[] cookies = request.getCookies();
		String mid = "";
		for(int i=0; i<cookies.length; i++) {
			if(cookies[i].getName().equals("cMid")) {
				mid = cookies[i].getValue();
				request.setAttribute("mid", mid);
				break;
			}
		}
		return "user/login";
	}
	
	@PostMapping(value = "/login")
	public String loginPagePost(String mid,String pwd,
			HttpServletRequest request, HttpServletResponse response,
			@RequestParam(name="idRemember", defaultValue = "", required = false) String idRemember,
			HttpSession session) {
		UserVO vo = userService.searchById(mid);
		UserVO vo2 = userService.getUserOutInfo(vo.getIdx());
		if(vo != null && passwordEncoder.matches(pwd, vo.getPwd())) {
			if(vo2 != null) {
				return "redirect:/msg/userOutAlready";
			}
			
			session.setAttribute("sIdx", vo.getIdx());
			session.setAttribute("sNickName", vo.getNickName());
			session.setAttribute("sAuthority", vo.getAuthority());
			
			if(!idRemember.equals("")) {
				Cookie cookie = new Cookie("cMid", mid);
				cookie.setMaxAge(60*60*24*7);		// 쿠키의 만료시간을 7일로 정함(단위:초)
				response.addCookie(cookie);
			}
			else {
				Cookie[] cookies = request.getCookies();
				for(int i=0; i<cookies.length; i++) {
					if(cookies[i].getName().equals("cMid")) {
						cookies[i].setMaxAge(0);		// 기존에 저장된 현재 mid값을 삭제한다.
						response.addCookie(cookies[i]);
						break;
					}
				}
			}	
			return "redirect:/main";
		}
		else {
			return "redirect:/msg/loginFailed";
		}
	}
	
	@GetMapping(value = "/join")
	public String joginPageGet() {
		return "user/join";
	}
	
	@PostMapping(value = "/join")
	public String joinPagePost(@ModelAttribute @Valid UserVO vo, BindingResult result, Model model) {
		vo.setPwd(passwordEncoder.encode(vo.getPwd()));
		userService.joinProcess(vo);
		return "redirect:/msg/joinSuccess";
	}
	

	@ResponseBody
	@RequestMapping(value = "/duplicationCheckId",method = RequestMethod.POST)
	public String duplicationCheckId(String mid) {
		UserVO vo = userService.searchById(mid);
		String res = "0";
		if(vo != null) {
			res = "0";
		}	
		else {
			res = "1";
		}
		return res;
	}
	@ResponseBody
	@PostMapping(value = "/duplicationCheckNick")
	public String duplicationCheckNick(String nickName) {
		UserVO vo = userService.getNickName(nickName);
		String res = "0";
		if(vo != null) {
			res = "0";
		}	
		else {
			res = "1";
		}
		return res;
	}
		
	@GetMapping(value = "/logOut")
	public String logOut(HttpSession session) {
		session.invalidate();
		return "redirect:/main";
	}
	@GetMapping(value = "/forgetId")
	public String findIdPageGet() {
		return "user/forgetId";
	}
	@PostMapping(value = "/forgetId")
	public String findIdPagePost(String name, String tel,
			Model model) {
	
		UserVO vo = userService.searchNameTel(name,tel);		
		if(vo == null) {
			return "redirect:/msg/noIdInfo";
		}
		else {
			model.addAttribute("fmid",vo.getMid().replace(vo.getMid().substring(vo.getMid().length()-2,vo.getMid().length()),"**"));			
			return "user/findInfo";
		}
	}
	
	@GetMapping(value = "/forgetPwd")
	public String findPwdPageGet() {
		return "user/forgetPwd";
	}
	
	@PostMapping(value = "/forgetPwd")
	public String forgetPwdPost(String mid, String name, String tel) {
		UserVO vo = userService.searchForTempPwd(mid,name,tel);

		if(vo == null) {
			return "redirect:/msg/noPwdInfo";
		}
		else {
			return "user/findInfo";
		}		
	}
	
	@GetMapping(value = "/myPage")
	public String myPageGet(HttpSession session,Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "20", required = false) int pageSize){
		int idx = (int) session.getAttribute("sIdx");
	
		PageVO pageVo = pageProcess.totRecCnt(pag, pageSize, "product", "", "");
		List<ProductVO> vos = userService.getProductList(pageVo.getStartIndexNo(), pageSize, idx);
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
		List<ProductVO> vos2 = userService.getMyLikes(idx);
		UserVO uVo = userService.getUserInfoByIdx(idx);
		LocalDateTime joinDate = LocalDateTime.parse(uVo.getJoinday(),formatter);		
		LocalDateTime now = LocalDateTime.now();
		long DAYS = ChronoUnit.DAYS.between(joinDate, now);
		uVo.setJoinday(DAYS+"일 전");
		
		for (ProductVO vo : vos) {	
			LocalDateTime date = LocalDateTime.parse(vo.getDate(),formatter);		
			//LocalDateTime now = LocalDateTime.now();
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
		model.addAttribute("pageVo", pageVo);
		model.addAttribute("vos", vos);
		model.addAttribute("vos2", vos2);
		model.addAttribute("uVo", uVo);
		
		return "user/myPage";
	}
	
	@GetMapping(value = "/modifyInfo")
	public String myInfoGet(HttpSession session,Model model) {
		String nickName = (String) session.getAttribute("sNickName");
		UserVO vo = userService.getNickName(nickName);
		String[] address = vo.getAddress().split("/");
		
		model.addAttribute("vo" , vo);
		model.addAttribute("address" , address);
		return "user/modifyInfo";
	}
	
	@PostMapping(value = "/deleteContent")
	public String deleteContent(int idx) {
		userService.deleteContent(idx);
		return "1";
	}
	
	@GetMapping(value = "/myLikes")
	public String myLikes(HttpSession session,Model model) {
		int idx = (int) session.getAttribute("sIdx");
		
		return "user/myLikes";
	}

	@GetMapping(value = "/myOrder")
	public String myOrder(Model model,HttpSession session,
			@RequestParam(name="part", defaultValue = "total", required = false) String part,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "15", required = false) int pageSize) {
		int idx = (int) session.getAttribute("sIdx");
		List<OrderVO> vos = userService.getOrderList(idx, part);
		PageVO pageVo = pageProcess.totRecCnt(pag, pageSize, "order", part, "");	
		UserVO uVo = userService.getUserOrderInfo(idx);
		for(OrderVO vo : vos) {
			DecimalFormat decFormat = new DecimalFormat("###,###");
			vo.setPriceShown(decFormat.format(vo.getPrice()));
		}
		
		model.addAttribute("part", part);
		model.addAttribute("idx", idx);
		model.addAttribute("pageVo", pageVo);
		model.addAttribute("vos",vos);			

		return "user/myOrder";
	}

	@GetMapping(value = "/userOut")
	public String userOut(HttpSession session) {
		return "user/userOut";
	}

	@PostMapping(value = "/userOut")
	public String userOutSubmit(HttpSession session,
			String mid, String pwd, String reason) {
		int sIdx = (int) session.getAttribute("sIdx");
		String res = userService.signOutProcess(mid,pwd,reason,sIdx);
		
		return "redirect:/msg/userOutFailed";
	}
	
	@ResponseBody
	@PostMapping(value = "/account")
	public String account(HttpSession session, 
			String accountNumber,String bank) {
		int idx = (int) session.getAttribute("sIdx");
		userService.setBankDetail(idx,accountNumber,bank);
		return "";
	}
	
}
