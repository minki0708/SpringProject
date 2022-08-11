package com.spring.javagreenS_jmk.service;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.javagreenS_jmk.dao.OrderDAO;

import com.spring.javagreenS_jmk.vo.OrderVO;


@Service
public class OrderServiceImpl implements OrderService {
	
	@Autowired
	OrderDAO orderDAO;

	@Transactional
	@Override
	public void setOrderProduct(OrderVO vo,int idx) {
		orderDAO.setOrderProduct(vo);
		orderDAO.updateSellCount(idx);
	}

	@Override
	public int getSellerIdx(int idx) {
		return orderDAO.getSellerIdx(idx);
	}

	@Override
	public void updateDeliveryStatus(OrderVO vo) {
		if(!vo.getDeliveryStatus().equals("배송완료")) {
			orderDAO.updateDeliveryStatus(vo);
		}
		else {
			orderDAO.deliveryComplete(vo);				
		}
	}
	
	@Transactional
	@Override
	public void orderCancel(OrderVO vo) {
		orderDAO.orderCancel(vo);
		orderDAO.insertCancleReason(vo);
		orderDAO.updateSellCount(vo.getProductIdx());
	}
	
	
	@Override
	public OrderVO getOrderByIdx(OrderVO vo) {
		return orderDAO.getOrderByIdx(vo);
	}
	
}
