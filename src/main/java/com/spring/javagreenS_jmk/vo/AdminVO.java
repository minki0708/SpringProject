package com.spring.javagreenS_jmk.vo;
import lombok.Data;

public @Data class AdminVO {
	private int idx;
	private int userIdx;
	private int orderIdx;
	private int replyIdx;
	private int reporterIdx;
	private int productIdx;
	private int largeIdx;
	private int midiumIdx;
	private int smallIdx;
	
	private String mid;
	private String sellerMid;
	private String buyerMid;
	private String reporterMid;
	private String reportedMid;
	private String sellerName;
	private String buyerName;
	private String nickName;
	private String Name;
	private String tel;	
	private String sellerTel;	
	private String buyerTel;	
	private String email;
	private String sellerEmail;
	private String buyerEmail;
	private String joinday;
	private int authority;
	private String photo;
	private String fName;
	private String fSName;
	private String title;
	private String content;
	private String reason;
	private String date;
	private int sell;
	private int likes;
	private String address;
	private int price;
	private String hostIp;
	private String exchange;
	private String state;
	private String status;
	private String orderDate;
	private String deliveryStatus;
	private String deliveryRequire;
	private String rDate;
	private String reportType;
	private String detail;
	
	private int uc;
	private int pc;
	private int oc;
	private int rc;
}
