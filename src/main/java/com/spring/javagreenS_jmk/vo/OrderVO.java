package com.spring.javagreenS_jmk.vo;

import lombok.Data;

public @Data class OrderVO {
	private int idx;
	private int productIdx;
	private int sellerIdx;
	private int buyerIdx;
	private String productName;
	private String orderDate;
	private String address;
	private String email;
	private String postcode;
	private String tel;
	private int price;
	private String deliveryStatus;
	private String deliveryRequire;
	private String deliveryDate;
		
	private String name;
	private String reason;
	private String priceShown;
	private String sellerName;
	private String buyerName;
	private String exchange;
	private String state;
	private String fSName;
	private String title;
	private String imp_uid;				// 고유ID
	private String merchant_uid;	// 상점 거래 ID
	private String paid_amount;		// 결제 금액
	private String apply_num;			// 카드 승인번호

}
