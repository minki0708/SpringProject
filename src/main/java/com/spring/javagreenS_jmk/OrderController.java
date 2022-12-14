package com.spring.javagreenS_jmk;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javagreenS_jmk.pagination.PageProcess;
import com.spring.javagreenS_jmk.service.AdminService;
import com.spring.javagreenS_jmk.service.OrderService;
import com.spring.javagreenS_jmk.service.ProductService;
import com.spring.javagreenS_jmk.service.UserService;

import com.spring.javagreenS_jmk.vo.OrderVO;
import com.spring.javagreenS_jmk.vo.ProductVO;
import com.spring.javagreenS_jmk.vo.UserVO;

@Controller
@RequestMapping("/order")
public class OrderController {
	
	@Autowired
	AdminService adminService;
	
	@Autowired
	ProductService productService;
	
	@Autowired
	UserService userService;
	
	@Autowired
	OrderService orderService;
	
	@Autowired
	PageProcess pageProcess;
	
	@GetMapping("/payment")
	public String payment(int idx, int sIdx, Model model) {
		ProductVO pVo = productService.getProductIdx(idx);
		UserVO uVo = userService.getUserInfoByIdx(sIdx);	
		String[] address = uVo.getAddress().split("/");
		
		model.addAttribute("sIdx" , sIdx);
		model.addAttribute("address" , address);
		model.addAttribute("pVo",pVo);
		model.addAttribute("uVo",uVo);
		return "order/payment";
	}

	@PostMapping("/paymentOk")
	public String payment(OrderVO vo, HttpSession session,
			Model model) {
		session.setAttribute("vo",vo);
		vo.setSellerIdx(orderService.getSellerIdx(vo.getProductIdx()));
		model.addAttribute("vo",vo);
		return "order/paymentOk";
	}
	
	// ??????????????? ????????????(????????? ????????????) - API??????
	// ?????? ????????? ??????????????? '???????????????(dbOrder)??? ??????
	// ??????????????? ?????? ????????? ???????????? ??????(????????????,????????????,?????????)?????? model??? ????????? ??????????????? ????????????.
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/paymentResult", method=RequestMethod.GET)
	public String paymentResultGet(HttpSession session,OrderVO receivePayMentVo, Model model) {
		// ???????????? dbOrder/dbBaesong ???????????? ????????????(????????? ???????????? ???????????? ????????????.)
		OrderVO vo = (OrderVO) session.getAttribute("vo");
		orderService.setOrderProduct(vo,vo.getProductIdx());
		
//		vo.setImp_uid(receivePayMentVo.getImp_uid());
//		vo.setMerchant_uid(receivePayMentVo.getMerchant_uid());
//		vo.setPaid_amount(receivePayMentVo.getPaid_amount());
//		vo.setApply_num(receivePayMentVo.getApply_num());
	
		return "redirect:/msg/paymentResultOk";
	}
	
	@ResponseBody
	@PostMapping("/updateDeliveryStatus")
	public String updateDeliveryStatus(OrderVO vo) {
			orderService.updateDeliveryStatus(vo);			
		return "";
	}
	
	@ResponseBody
	@PostMapping("/orderCancel")
	public String orderCancel(OrderVO vo) {
		String reason = vo.getReason();
		vo = orderService.getOrderByIdx(vo);
		vo.setReason(reason);
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
		LocalDateTime date = LocalDateTime.parse(vo.getOrderDate(),formatter);		
		LocalDateTime now = LocalDateTime.now();
		long days = ChronoUnit.SECONDS.between(date, now);
		
		if(days < (60 * 60 * 24 * 7) && vo.getDeliveryStatus().equals("???????????????")) {
			orderService.orderCancel(vo);
			return "1";
		}
		else if(vo.getDeliveryStatus().equals("????????????")) {
			return "2";
		}
		return "";
	}

	@ResponseBody
	@PostMapping("/orderRefund")
	public String orderRefund(OrderVO vo) {
		String reason = vo.getReason();
		vo = orderService.getOrderByIdx(vo);
		vo.setReason(reason);
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
		LocalDateTime date = LocalDateTime.parse(vo.getOrderDate(),formatter);		
		LocalDateTime now = LocalDateTime.now();
		long days = ChronoUnit.SECONDS.between(date, now);
		
		if(days < (60 * 60 * 24 * 7) && vo.getDeliveryStatus().equals("???????????????")) {
			orderService.orderCancel(vo);
			return "1";
		}
		else if(vo.getDeliveryStatus().equals("????????????")) {
			return "2";
		}
		return "";
	}
	
}
