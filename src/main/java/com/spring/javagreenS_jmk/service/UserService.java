package com.spring.javagreenS_jmk.service;

import java.util.List;

import com.spring.javagreenS_jmk.vo.AdminVO;
import com.spring.javagreenS_jmk.vo.OrderVO;
import com.spring.javagreenS_jmk.vo.ProductVO;
import com.spring.javagreenS_jmk.vo.UserVO;

public interface UserService {

	public UserVO searchById(String mid);

	public UserVO getNickName(String nickName);

	public void joinProcess(UserVO vo);

	public UserVO searchNameTel(String name, String tel);

	public UserVO searchForTempPwd(String mid, String name, String tel);

	public void updateInfo(UserVO vo);

	public void deleteContent(int idx);

	public List<ProductVO> getProductList(int startIndexNo, int pageSize, int idx);

	public List<ProductVO> getMyLikes(int idx);

	public UserVO getUserInfoByIdx(int sIdx);

	public List<OrderVO> getOrderList(int idx, String part);

	public void setBankDetail(int idx, String accountNumber, String bank);

	public String signOutProcess(String mid, String pwd, String reason, int sIdx);

	public UserVO getUserOutInfo(int idx);

	public int getTotalOrderCnt(int idx);

	public int getCheckOrderCnt(int idx);

	public int getDeliveryCnt(int idx);

	public int getDeliveryComplCnt(int idx);


}
