package com.spring.javagreenS_jmk.vo;

import lombok.Data;

public @Data class CategoryVO {
	private int largeIdx;
	private int midiumIdx;
	private int smallIdx;
	private String name;
	
	private String category; // 1 대분류 2 중분류 3 소분류
}
