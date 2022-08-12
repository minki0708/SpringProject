package com.spring.javagreenS_jmk.vo;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotBlank;

import lombok.Data;

public @Data class UserVO {
	private int idx;
	
	@NotBlank
	@Pattern(regexp ="/^[a-zA-Z][a-zA-z0-9]{4,16}$/g")
	private String mid;
	
	@NotBlank
	@Size(min=4, max=20, message="비밀번호는 최소 4글자 이상 20글자 이하로 작성하세요")
	private String pwd;
	
	@NotBlank(message = "이름을 입력해주세요")
	private String name;
	
	@NotBlank(message = "닉네임을 입력해주세요")
	private String nickName;
	
	@NotBlank(message = "연락처를 입력해주세요")
	private String tel;	
	
	@Email(message = "이메일 형식에 맞지 않습니다")
	@NotBlank(message= "이메일을 입력해주세요")
	private String email;
	
	@NotBlank(message = "주소를 입력해주세요")
	private String address;
	
	private String joinday;
	private int authority;
	private String photo;
	private String content;
	
	private String productName;
	private String reason;
	private String oDate;
	private String modiDate;
	private int outCount;
}
