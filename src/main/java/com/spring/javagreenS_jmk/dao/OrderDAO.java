package com.spring.javagreenS_jmk.dao;

import org.apache.ibatis.annotations.Param;

import com.spring.javagreenS_jmk.vo.OrderVO;

public interface OrderDAO {

	public void setOrderProduct(@Param("vo") OrderVO vo);

	public int getSellerIdx(@Param("idx") int idx);

	public int totRecCnt(@Param("part") String part,@Param("searchString") String searchString);

	public void updateSellCount(@Param("idx") int idx);

	public void updateDeliveryStatus(@Param("vo") OrderVO vo);

	public void orderCancel(@Param("vo") OrderVO vo);

	public OrderVO getOrderByIdx(@Param("vo") OrderVO vo);

	public void insertCancleReason(@Param("vo") OrderVO vo);

	public void deliveryComplete(@Param("vo") OrderVO vo);

}
