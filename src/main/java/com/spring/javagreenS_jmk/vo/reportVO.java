package com.spring.javagreenS_jmk.vo;

import lombok.Data;

public @Data class reportVO {
	private int idx;
	private int userIdx;
	private int productIdx;
	private int reporterIdx;
	private int replyIdx;
	private String rDate;
	private String reportType;
	private String detail;
}
