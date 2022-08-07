package com.movie.util;

import com.movie.dao.Dao;

public class Paging {

	private Dao dao;
	
	private String condition;
	private String value;
	
    private int pageSize;
    private int pageBlock;
    private int currentPage;
    private int boardSize;
    private int pageCount;

    public Paging(int pageSize, int pageBlock, Dao dao, String currentPage, String condition, String value) {
        this.pageSize = pageSize;
        this.pageBlock = pageBlock;
        this.dao = dao;
        this.currentPage = currentPage == null? 1: Integer.parseInt(currentPage);
        this.condition = condition == null? "1": condition;
        this.value = value == null? "1": value;
        setBoardSize();
        setPageCount();
    }

    public int getStart() {
        return (currentPage - 1) * pageSize + 1;
    }

    public int getEnd() {
        return currentPage * pageSize;
    }
    
    public int getNextBlock() {
    	return getStartBlock() + pageBlock;
    }
    
    public int getprevBlock() {
    	return getStartBlock() - 1;
    }
    
    private void setBoardSize() {
    	this.boardSize = dao.getCount(this);
    }
    
    public String getCondition() {
    	return condition;
    }
    
    public String getValue() {
    	return value;
    }

    private void setPageCount() {
    	pageCount = (boardSize / pageSize) + (boardSize % pageSize == 0 ? 0 : 1);
    }
    
    // 전체 페이지
    public int getPageCount() {
        return pageCount;
    }

    // 시작 블록 숫자
    public int getStartBlock() {
        return ((currentPage - 1) / pageBlock) * pageBlock + 1;
    }

    // 끝 블록 숫자
    public int getEndBlock() {
        int end = getStartBlock() + (pageBlock - 1);
        if(end > pageCount)
            end = pageCount;
        return end;
    }

    // 몇번부터 시작
    public int getStartNum() {
        return boardSize - ((currentPage - 1) * pageSize);
    }
    
    public boolean isFirstPage() {
    	return getStartBlock() != 1;
    }
    
    public boolean isLastPage() {
    	return getEndBlock() != pageCount;
    }
    
    public int getCurrentPage() {
    	return currentPage;
    }
    
    public String getNextURL() {
    	String str = null;
    	if(value.equals("1")) {
    		str = "currentPage=" + getNextBlock();
    	}
    	else {
    		str = "currentPage=" + getNextBlock() + "&condition=" + condition + "&value=" + value; 
    	}
    	return str;
    }
    
    public String getPrevURL() {
    	String str = null;
    	if(value.equals("1")) {
    		str = "currentPage=" + getprevBlock();
    	}
    	else {
    		str = "currentPage=" + getprevBlock() + "&condition=" + condition + "&value=" + value; 
    	}
    	return str;
    }
    
    public String getURL() {
    	String str = "";
    	if(!value.equals("1")) {
    		str = "&condition=" + condition + "&value=" + value; 
    	}
    	return str;    	
    }
    
    public String getInputValue() {
    	String str = "";
    	if(!value.equals("1")) {
    		str += value;
    	}
    	return str;  	
    }
}
