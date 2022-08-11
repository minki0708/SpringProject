package com.spring.javagreenS_jmk.pagination;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javagreenS_jmk.dao.AdminDAO;
import com.spring.javagreenS_jmk.dao.OrderDAO;
import com.spring.javagreenS_jmk.dao.ProductDAO;

@Service
public class PageProcess {
	@Autowired
	AdminDAO adminDAO;
	
	@Autowired
	ProductDAO productDAO;

	@Autowired
	OrderDAO orderDAO;
	// 인자: 1.page번호, 2.page크기, 3.소속(예:게시판(board),회원(member),방명록(guest)..), 4.분류(part), 5.검색어(searchString)
	public PageVO totRecCnt(int pag, int pageSize, String section, String part, String searchString) {
		PageVO pageVO = new PageVO();
		
		int totRecCnt = 0;
		int blockSize = 3;
		
		// section에 따른 레코드 갯수를 구해오기
		if(section.equals("admin")) {
			totRecCnt = adminDAO.totRecCnt();
		}
		else if(section.equals("product") && searchString.equals("")) {
			totRecCnt = productDAO.totRecCnt();
		}
		else if(section.equals("product") && !searchString.equals("")) {
			totRecCnt = productDAO.totSearchRecCnt(searchString);
		}
		else if(section.equals("order")) {
				totRecCnt = orderDAO.totRecCnt(part, searchString);				
		}
		int totPage = (totRecCnt%pageSize)==0 ? totRecCnt/pageSize : (totRecCnt/pageSize)+1;
		int startIndexNo = (pag - 1) * pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage % blockSize)==0 ? (totPage / blockSize) - 1 : (totPage / blockSize);
		
		pageVO.setPag(pag);
		pageVO.setPageSize(pageSize);
		pageVO.setTotRecCnt(totRecCnt);
		pageVO.setTotPage(totPage);
		pageVO.setStartIndexNo(startIndexNo);
		pageVO.setCurScrStartNo(curScrStartNo);
		pageVO.setBlockSize(blockSize);
		pageVO.setCurBlock(curBlock);
		pageVO.setLastBlock(lastBlock);
		
		return pageVO;
	}
	
	
}
