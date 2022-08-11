package com.spring.javagreenS_jmk.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.javagreenS_jmk.dao.AdminDAO;
import com.spring.javagreenS_jmk.vo.AdminVO;
import com.spring.javagreenS_jmk.vo.CategoryVO;
import com.spring.javagreenS_jmk.vo.OrderVO;
import com.spring.javagreenS_jmk.vo.ProductVO;
import com.spring.javagreenS_jmk.vo.UserVO;

@Service
public class AdminServiceImpl implements AdminService {
	
	@Autowired
	AdminDAO adminDAO;

	@Override
	public CategoryVO checkCategory(CategoryVO vo) {
		return adminDAO.checkCategory(vo);
	}

	@Override
	public void insertCategory(CategoryVO vo) {
		adminDAO.insertCategory(vo);
	}

	@Override
	public List<CategoryVO> getLCategories() {
		return adminDAO.getLCategories();
	}

	@Override
	public List<CategoryVO> getCategories(CategoryVO vo) {
		return adminDAO.getCategories(vo);
	}

	@Override
	public void updateCategory(CategoryVO vo) {
		// 중분류 업데이트
		if(vo.getMidiumIdx() != 0) {
			adminDAO.updateCategory2(vo);
		}// 소분류 업데이트
		else if(vo.getSmallIdx() != 0){
			adminDAO.updateCategory3(vo);
		}// 대분류 업데이트
		else {
			adminDAO.updateCategory(vo);
		}
	}

	@Override
	public void deleteCategory(CategoryVO vo) {
		adminDAO.deleteCategory(vo);
	}

	@Override
	public List<UserVO> getUserList() {
		return adminDAO.getUserList();
	}

	@Override
	public List<CategoryVO> categoryList(CategoryVO vo) {
		return adminDAO.categoryList(vo);
	}

	@Override
	public List<ProductVO> getBlockedProduct() {
		return adminDAO.getBlockedProduct();
	}

	@Override
	public void productDelete(int idx) {
		adminDAO.productDelete(idx);
	}

	@Override
	public void productReturn(int idx) {
		adminDAO.productReturn(idx);
	}

	@Override
	public List<AdminVO> getOrderList() {
		return adminDAO.getOrderList();
	}
	
	@Transactional
	@Override
	public List<AdminVO> getChartData(String datepicker1, String datepicker2) {
		return adminDAO.getChartData(datepicker1, datepicker2);
	}

	@Override
	public List<AdminVO> getReportList(String type) {
		return adminDAO.getReportList(type);
	}

	@Override
	public void cancleReportProduct(int idx) {
		adminDAO.cancleReportProduct(idx);
	}

	@Override
	public void removeReportedProduct(int idx) {
		adminDAO.removeReportedProduct(idx);
	}

	@Override
	public void cancleReportReply(int idx) {
		adminDAO.cancleReportReply(idx);
	}

	@Override
	public void removeReportedReply(int idx) {
		adminDAO.removeReportedReply(idx);
	}
}
