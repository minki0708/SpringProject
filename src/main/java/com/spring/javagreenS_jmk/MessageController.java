package com.spring.javagreenS_jmk;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MessageController {

	@RequestMapping(value="/msg/{msgFlag}", method=RequestMethod.GET)
	public String msgGet(@PathVariable String msgFlag, Model model,
			@RequestParam(value="flag", defaultValue = "", required=false) String flag) {
		if(msgFlag.equals("loginFailed")) {
			model.addAttribute("msg", "로그인 실패 아이디와 비밀번호를 다시 확인해주세요.");
			model.addAttribute("url", "user/login");
		}
		else if(msgFlag.equals("joinSuccess")) {
			model.addAttribute("msg", "환영합니다");
			model.addAttribute("url", "user/login");
		}
		else if(msgFlag.equals("noIdInfo")) {
			model.addAttribute("msg", "입력하신 정보와 일치하는 유저가 없습니다");
			model.addAttribute("url", "user/forgetId");
		}
		else if(msgFlag.equals("noPwdInfo")) {
			model.addAttribute("msg", "입력하신 정보와 일치하는 유저가 없습니다");
			model.addAttribute("url", "user/forgetPwd");
		}
		else if(msgFlag.equals("modifySuccess")) {
			model.addAttribute("msg", "수정완료");
			model.addAttribute("url", "user/myPage");
		}
		else if(msgFlag.equals("uploadSuccess")) {
			model.addAttribute("msg", "상품등록 완료");
			model.addAttribute("url", "/");
		}
		else if(msgFlag.equals("updateSuccess")) {
			model.addAttribute("msg", "상품수정 완료");
			model.addAttribute("url", "product/content?idx="+flag);
		}
		else if(msgFlag.equals("unLogin")) {
			model.addAttribute("msg", "로그인 후 이용해주세요");
			model.addAttribute("url", "user/login");
		}
		else if(msgFlag.equals("deny")) {
			model.addAttribute("msg", "관리자 전용입니다");
			model.addAttribute("url", "/");
		}
		else if(msgFlag.equals("paymentResultOk")) {
			model.addAttribute("msg", "결제완료");
			model.addAttribute("url", "user/myOrder");
		}
		else if(msgFlag.equals("userOutSuccess")) {
			model.addAttribute("msg", "회원탈퇴 완료");
			model.addAttribute("url", "user/main");
		}
		else if(msgFlag.equals("userOutFailed")) {
			model.addAttribute("msg", "회원탈퇴 실패 정보를 정확히 입력해주세요");
			model.addAttribute("url", "user/userOut");
		}
		else if(msgFlag.equals("infoLeft")) {
			model.addAttribute("msg", "모든 판매,구매 상품이 구매확정 시에 탈퇴하실 수 있습니다.");
			model.addAttribute("url", "user/myOrder");
		}
		else if(msgFlag.equals("userOutAlready")) {
			model.addAttribute("msg", "탈퇴처리된 아이디입니다");
			model.addAttribute("url", "user/myOrder");
		}

				
		return "include/message";
	}
	
}
