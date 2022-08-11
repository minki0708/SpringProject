package com.spring.javagreenS_jmk.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javagreenS_jmk.vo.OrderVO;
import com.spring.javagreenS_jmk.vo.ProductReplyVO;
import com.spring.javagreenS_jmk.vo.ProductVO;
import com.spring.javagreenS_jmk.vo.reportVO;


public interface ProductDAO {

	public int totRecCnt();

	public void setProductInput(@Param("vo") ProductVO vo);

	public List<ProductVO> getProductList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public ProductVO getContent(@Param("idx") int idx);

	public void updateReadNum();

	public ProductVO getProductIdx(@Param("idx") int idx);

	public void setProductUpdate(@Param("vo") ProductVO vo);

	public ProductVO checkLikes(@Param("idx") int idx, @Param("sIdx") int sIdx);

	public void insertLikes(@Param("idx") int idx, @Param("sIdx") int sIdx);

	public void deleteLikes(@Param("idx") int idx, @Param("sIdx") int sIdx);

	public int getLikes(@Param("idx") int idx);

	public List<ProductReplyVO> getProductReply(@Param("idx") int idx);

	public void setProductReply(@Param("vo") ProductReplyVO vo);

	public void deleteReply(@Param("vo") ProductReplyVO vo);

	public void deleteParentReply(@Param("vo") ProductReplyVO vo);

	public int totSearchRecCnt(@Param("searchString") String searchString);

	public List<ProductVO> getProductSearch(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("searchString") String searchString, @Param("type")  String type);

	public void setBlockProject(@Param("idx") int idx,@Param("text") String text);

	public List<ProductVO> getProductByCategory(@Param("lCategory") int lCategory, @Param("mCategory") int mCategory, @Param("sCategory") int sCategory);

	public void setReplyReport(@Param("vo") reportVO vo);

	public void setProductReport(@Param("vo") reportVO vo);

	public void setReadCount(@Param("sIdx") int sIdx, @Param("idx") int idx);

	public int getReadCount(@Param("sIdx") int sIdx, @Param("idx") int idx);

}
