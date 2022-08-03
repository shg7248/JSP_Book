package com.movie.util;

public class Paging {

    private int pageSize;
    private int pageBlock;
    private int currentPage;
    private int boardSize;
    private int pageCount;

    public Paging(int pageSize, int pageBlock) {
        this(pageSize, pageBlock, 1);
    }

    public Paging(int pageSize, int pageBlock, int currentPage) {
        this.pageSize = pageSize;
        this.pageBlock = pageBlock;
        this.currentPage = currentPage;
    }

    public int getStart() {
        return (currentPage - 1) * pageSize + 1;
    }

    public int getEnd() {
        return currentPage * pageSize;
    }

    public void setBoardSize(int boardSize) {
        this.boardSize = boardSize;
        setPageCount();
    }

    private void setPageCount() {
    	pageCount = (boardSize / pageSize) + boardSize % pageSize == 0 ? 0 : 1;
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
}
