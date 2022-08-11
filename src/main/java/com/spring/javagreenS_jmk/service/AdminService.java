package com.spring.javagreenS_jmk.service;

import java.util.List;

import com.spring.javagreenS_jmk.vo.AdminVO;
import com.spring.javagreenS_jmk.vo.CategoryVO;
import com.spring.javagreenS_jmk.vo.OrderVO;
import com.spring.javagreenS_jmk.vo.ProductVO;
import com.spring.javagreenS_jmk.vo.UserVO;

public interface AdminService {

	public CategoryVO checkCategory(CategoryVO vo);

	public void insertCategory(CategoryVO vo);

	public List<CategoryVO> getLCategories();

	public List<CategoryVO> getCategories(CategoryVO vo);

	public void updateCategory(CategoryVO vo);

	public void deleteCategory(CategoryVO vo);

	public List<UserVO> getUserList();

	public List<CategoryVO> categoryList(CategoryVO vo);

	public List<ProductVO> getBlockedProduct();

	public void productDelete(int idx);	

	public void productReturn(int idx);

	public List<AdminVO> getOrderList();

	public List<AdminVO> getChartData(String datepicker1, String datepicker2);

	public List<AdminVO> getReportList(String type);

	public void cancleReportProduct(int idx);

	public void removeReportedProduct(int idx);

	public void cancleReportReply(int idx);

	public void removeReportedReply(int idx);

}
