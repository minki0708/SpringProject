package com.spring.javagreenS_jmk.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javagreenS_jmk.vo.AdminVO;
import com.spring.javagreenS_jmk.vo.OrderVO;
import com.spring.javagreenS_jmk.vo.ProductVO;
import com.spring.javagreenS_jmk.vo.UserVO;

public interface UserDAO {

	public UserVO searchById(@Param("mid") String mid);

	public UserVO getNickName(@Param("nickName") String nickName);

	public void joinProcess(@Param("vo") UserVO vo);

	public UserVO searchNameTel(@Param("name") String name,@Param("tel") String tel);
	
	public UserVO searchForTempPwd(@Param("mid") String mid, @Param("name") String name, @Param("tel") String tel);

	public void setTempPwd(@Param("mid") String mid, @Param("tempPwd") String tempPwd);

	public void updateInfo(@Param("vo") UserVO vo);

	public void updateInfo2(@Param("vo") UserVO vo);

	public void deleteContent(@Param("idx") int idx);

	public List<ProductVO> getProductList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("idx") int idx);

	public List<ProductVO> getMyLikes(@Param("idx") int idx);

	public UserVO getUserInfoByIdx(@Param("sIdx") int sIdx);

	public List<OrderVO> getOrderList(@Param("idx") int idx, @Param("part") String part);

	public void insertOutUserInfo(@Param("idx") int idx, @Param("reason") String reason);

	public UserVO getUserOutInfo(@Param("idx") int idx);

	public List<AdminVO> getUserOutCheck(@Param("idx") int idx);

	public void setBankDetail(@Param("idx") int idx, @Param("accountNumber") String accountNumber, @Param("bank") String bank);

	public String signOutProcess(@Param("idx") String idx, @Param("reason") String reason, String pwd, int sIdx);

	public int getTotalOrderCnt(@Param("idx") int idx);

	public int getCheckOrderCnt(@Param("idx")int idx);

	public int getDeliveryCnt(@Param("idx")int idx);

	public int getDeliveryComplCnt(@Param("idx")int idx);
	
}
