package com.spring.javagreenS_jmk.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mysql.cj.Session;
import com.spring.javagreenS_jmk.dao.UserDAO;
import com.spring.javagreenS_jmk.vo.AdminVO;
import com.spring.javagreenS_jmk.vo.OrderVO;
import com.spring.javagreenS_jmk.vo.ProductVO;
import com.spring.javagreenS_jmk.vo.UserVO;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	UserDAO userDAO;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@Autowired 
	JavaMailSender mailSender;
	
	@Override
	public UserVO searchById(String mid) {
		return userDAO.searchById(mid);
	}

	@Override
	public UserVO getNickName(String nickName) {
		return userDAO.getNickName(nickName);
	}

	@Override
	public void joinProcess(UserVO vo) {
		userDAO.joinProcess(vo);
	}

	@Override
	public UserVO searchNameTel(String name, String tel) {
		return userDAO.searchNameTel(name,tel);
	}

	@Override
	public UserVO searchForTempPwd(String mid, String name, String tel) {	
		UserVO vo = userDAO.searchForTempPwd(mid, name, tel);
	
		if(vo != null) {
			UUID uid = UUID.randomUUID();
			String pwd = uid.toString().substring(0,8);
			String content = "";

			userDAO.setTempPwd(mid, passwordEncoder.encode(pwd));
			try {
				MimeMessage message = mailSender.createMimeMessage();
				MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
				
				messageHelper.setTo(vo.getEmail());
				messageHelper.setSubject("천둥장터 임시 비밀번호 발급.");
				messageHelper.setText(content);
				
				// 메세지 보관함의 내용을 편집해서 다시 보관함에 담아둔다.
				content = "<hr>신규 비밀번호는 : <font color='red'><b>" + pwd + "</b></font>";
				content += "<br><hr>아래 주소로 다시 로그인하셔서 비밀번호를 변경하시기 바랍니다.<hr><br>";
//				content += "<p><img src=\"cid:main.jpg\" width='500px'></p><hr>";
				content += "<p>방문하기 : <a href='http://192.168.50.105:9090/javagreenS_jmk/user/login'>천 둥 장 터</a></p>";
				content += "<hr>";
				messageHelper.setText(content, true);
				
				// 본문에 기재된 그림파일의 경로를 따로 표시시켜준다.
//				FileSystemResource file = new FileSystemResource("D:\\JavaGreen\\springframework\\works\\javagreenS\\src\\main\\webapp\\resources\\images\\main.jpg");
//				messageHelper.addInline("main.jpg", file);
				
				// 메일 전송하기
				mailSender.send(message);
				System.out.println("message"+message);
			} catch (MessagingException e) {
				e.printStackTrace();
			}
		}
		return vo;
	}

	@Override
	public void updateInfo(UserVO vo) {
		// 패스워드 변경 안했을시에 업데이트
		if(vo.getPwd().equals("********")) {
			userDAO.updateInfo2(vo);
		}
		else { 
			// 패스워드 변경 했을시에 업데이트
			vo.setPwd(passwordEncoder.encode(vo.getPwd()));
			userDAO.updateInfo(vo);
		}
	}

	@Override
	public void deleteContent(int idx) {
		userDAO.deleteContent(idx);
	}

	@Override
	public List<ProductVO> getProductList(int startIndexNo, int pageSize, int idx) {
		return userDAO.getProductList(startIndexNo, pageSize, idx);
	}

	@Override
	public List<ProductVO> getMyLikes(int idx) {
		return userDAO.getMyLikes(idx);
	}

	@Override
	public UserVO getUserInfoByIdx(int sIdx) {
		return userDAO.getUserInfoByIdx(sIdx);
	}

	@Override
	public List<OrderVO> getOrderList(int idx, String part) {
		return userDAO.getOrderList(idx, part);
	}

	@Override
	public void setBankDetail(int idx, String accountNumber, String bank) {
		userDAO.setBankDetail(idx, accountNumber, bank);
	}

	@Override
	public String signOutProcess(String mid, String pwd, String reason,int sIdx) {
		UserVO vo = userDAO.searchById(mid);
		System.out.println("sIdx"+sIdx);
		System.out.println("vo"+vo);
		String res = "";
		//&& passwordEncoder.matches(pwd, vo.getPwd())
		if(sIdx == vo.getIdx() && mid == vo.getMid() ) {			
			userDAO.signOutProcess(mid, pwd, reason,sIdx);
			res = "userOutSuccess";
		}
		else {
			res = "userOutFailed";
		}
		return res;
	}

	@Override
	public UserVO getUserOutInfo(int idx) {
		return userDAO.getUserOutInfo(idx);
	}

	@Override
	public int getTotalOrderCnt(int idx) {
		return userDAO.getTotalOrderCnt(idx);
	}

	@Override
	public int getCheckOrderCnt(int idx) {
		return userDAO.getCheckOrderCnt(idx);
	}

	@Override
	public int getDeliveryCnt(int idx) {
		return userDAO.getDeliveryCnt(idx);
	}

	@Override
	public int getDeliveryComplCnt(int idx) {
		return userDAO.getDeliveryComplCnt(idx);
	}





}
