package com.spring.javagreenS_jmk.service;


import java.util.List;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javagreenS_jmk.pagination.PageVO;
import com.spring.javagreenS_jmk.vo.OrderVO;
import com.spring.javagreenS_jmk.vo.ProductReplyVO;
import com.spring.javagreenS_jmk.vo.ProductVO;
import com.spring.javagreenS_jmk.vo.UserVO;
import com.spring.javagreenS_jmk.vo.reportVO;

public interface ProductService {

	public void imgCheck(String content);

	public void setProductInput(MultipartHttpServletRequest file, ProductVO vo);

	public List<ProductVO> getProductList(int startIndexNo, int pageSize);

	public ProductVO getContent(int idx);

	public void imgDelete(String content);

	public ProductVO getProductIdx(int idx);

	public void imgCheckUpdate(String content);

	public void setProductUpdate(MultipartHttpServletRequest mfile, ProductVO vo);

	public ProductVO checkLikes(int idx, int sIdx);

	public void insertLikes(int idx, int sIdx);

	public void deleteLikes(int idx, int sIdx);

	public int getLikes(int idx);

	public List<ProductReplyVO> getProductReply(int idx);

	public void setProductReply(ProductReplyVO vo);

	public void deleteReply(ProductReplyVO vo);

	public void deleteParentReply(ProductReplyVO vo);

	public List<ProductVO> getProductSearch(int startIndexNo, int pageSize, String searchString, String type);

	public void setBlockProject(int idx, String text);

	public List<ProductVO> getProductByCategory(int lCategory, int mCategory, int sCategory);

	public void setReplyReport(reportVO vo);

	public void setProductReport(reportVO vo);

	public void setReadCount(int sIdx, int idx);

}
