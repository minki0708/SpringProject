package com.spring.javagreenS_jmk.vo;

import lombok.Data;

public @Data class ProductVO {
	private int largeIdx;
	private int midiumIdx;
	private int smallIdx;
	private int userIdx;
	private int idx;
	private String fName;
	private String fSName;
	private String title;
	private String content;
	private String date;
	private String strdate;
	private int sell;
	private int likes;
	private String address;
	private int price;
	private String hostIp;
	private String exchange;
	private String state;
	
	private int readCount;
	private String bContent; // 블락내용
	private String bDate; // 블락 일시
	private int getList; // 0 메인 1 검색기
	private int tradeCheck; // 0이면 판매완료 1이면 판매중
	private String lName;
	private String mName;
	private String sName;
	
}
