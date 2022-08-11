package com.spring.javagreenS_jmk.service;

import com.spring.javagreenS_jmk.vo.OrderVO;

public interface OrderService {

	public void setOrderProduct(OrderVO vo, int idx);

	public int getSellerIdx(int idx);

	public void updateDeliveryStatus(OrderVO vo);

	public void orderCancel(OrderVO vo);

	public OrderVO getOrderByIdx(OrderVO vo);
	
}
