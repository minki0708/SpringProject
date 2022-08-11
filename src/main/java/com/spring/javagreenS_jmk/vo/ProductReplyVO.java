package com.spring.javagreenS_jmk.vo;

import lombok.Data;

public @Data class ProductReplyVO {
	private int idx;
	private int productIdx;
	private int userIdx;
	private int parentIdx;
	private String rDate;
	private String hostIp;
	private String content;
	private int deleteSwitch;
	
	private String nickName;
	private int level;
}
