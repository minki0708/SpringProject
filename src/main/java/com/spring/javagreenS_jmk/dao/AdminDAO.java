package com.spring.javagreenS_jmk.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javagreenS_jmk.vo.AdminVO;
import com.spring.javagreenS_jmk.vo.CategoryVO;
import com.spring.javagreenS_jmk.vo.OrderVO;
import com.spring.javagreenS_jmk.vo.ProductVO;
import com.spring.javagreenS_jmk.vo.UserVO;

public interface AdminDAO {

	public CategoryVO checkCategory(@Param("vo") CategoryVO vo);

	public void insertCategory(@Param("vo") CategoryVO vo);

	public List<CategoryVO> getLCategories();

	public List<CategoryVO> getCategories(@Param("vo") CategoryVO vo);

	public void updateCategory(@Param("vo") CategoryVO vo);

	public void updateCategory2(@Param("vo") CategoryVO vo);
	
	public void updateCategory3(@Param("vo") CategoryVO vo);

	public void deleteCategory(@Param("vo") CategoryVO vo);

	public int totRecCnt();

	public List<UserVO> getUserList();

	public List<CategoryVO> categoryList(@Param("vo") CategoryVO vo);

	public List<ProductVO> getBlockedProduct();

	public void productDelete(@Param("idx") int idx);

	public void productReturn(@Param("idx") int idx);

	public List<AdminVO> getOrderList();

	public List<AdminVO> getChartData(@Param("datepicker1") String datepicker1,@Param("datepicker2") String datepicker2);

	public List<AdminVO> getReportList(@Param("type") String type);

	public void cancleReportProduct(@Param("idx") int idx);

	public void removeReportedProduct(@Param("idx") int idx);

	public void cancleReportReply(@Param("idx") int idx);

	public void removeReportedReply(@Param("idx") int idx);	
}
