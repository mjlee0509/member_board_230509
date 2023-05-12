package com.icia.mjuniverse.service;

import com.icia.mjuniverse.dto.BoardDTO;
import com.icia.mjuniverse.dto.BoardFileDTO;
import com.icia.mjuniverse.dto.PageDTO;
import com.icia.mjuniverse.repo.BoardRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class BoardService {
    @Autowired
    private BoardRepository boardRepository;

    public void save(BoardDTO boardDTO) throws IOException {
        if(boardDTO.getBoardFile().get(0).isEmpty()) {
            boardDTO.setFileAttached(0);
            boardRepository.save(boardDTO);
        } else {
            boardDTO.setFileAttached(1);
            BoardDTO dto = boardRepository.save(boardDTO);
            for (MultipartFile boardFile : boardDTO.getBoardFile()) {
                String originalFileName = boardFile.getOriginalFilename();
                String storedFileName = System.currentTimeMillis() + "-" + originalFileName;
                BoardFileDTO boardFileDTO = new BoardFileDTO();
                boardFileDTO.setOriginalFileName(originalFileName);
                boardFileDTO.setBoardId(dto.getId());
                boardFileDTO.setStoredFileName(storedFileName);
                String savePath = "D:\\springFramework_img\\mjuniverseMember\\" + storedFileName;
                boardFile.transferTo(new File(savePath));
                boardRepository.saveFile(boardFileDTO);
            }
        }
    }
    public List<BoardDTO> findAll() {
        List<BoardDTO> boardDTOList = boardRepository.findAll();
        return boardDTOList;
    }
    public List<BoardDTO> pagingList(int page) {
        int pageLimit = 5;
        int pageStart = (page-1) * pageLimit;
        Map<String, Integer> pagingParams = new HashMap<>();
        pagingParams.put("start", pageStart);
        pagingParams.put("limit", pageLimit);
        List<BoardDTO> boardDTOList = boardRepository.pagingList(pagingParams);
        return boardDTOList;
    }
    public PageDTO pagingParam(int page) {
        int pageLimit = 5;  // 한 페이지에 글 n개
        int blockLimit = 5;  // 한 페이지에 리스트 n개

        int boardCount  = boardRepository.boardCount(); // 전체 글 개수를 먼저 조회하고

        /*
            i. boardCount / 3 의 결과는 버림 처리된 int임
            ii. 그러므로 이것을 double로 형변환한 후
            iii. Math.ceil을 통해 올림처리 하고
            iv. int로 다시 형변환해주는 과정임
        */
        int maxPage = (int)(Math.ceil((double)boardCount/pageLimit)); // Tip. 뒤에서부터 써내려가보자

        // 위의 과정이랑 같은건데, 페이지블록 수를 한 페이지에 보여줄 페이지블록수로 나눈 것
        int startPage = (((int)(Math.ceil((double)page/blockLimit))) - 1) * blockLimit + 1; // blockLimit 뒷부분부터 이해X
        int endPage = startPage + blockLimit - 1; // 이해X

        if (endPage > maxPage) {
            endPage = maxPage;
        }

        PageDTO pageDTO = new PageDTO();
        pageDTO.setPage(page);
        pageDTO.setMaxPage(maxPage);
        pageDTO.setEndPage(endPage);
        pageDTO.setStartPage(startPage);
        return pageDTO;
    }
    public List<BoardDTO> searchList(int page, String type, String q) {
        int pageLimit = 5;
        int pagingStart = (page-1)*pageLimit;
        Map<String, Object> pagingParams = new HashMap<>();
        pagingParams.put("start", pagingStart);
        pagingParams.put("limit", pageLimit);
        pagingParams.put("q", q);
        pagingParams.put("type", type);
        List<BoardDTO> boardDTOList = boardRepository.searchList(pagingParams);
        return boardDTOList;
    }
    public PageDTO pagingSearchParam(int page, String type, String q) {
        int pageLimit = 5;
        int blockLimit = 5;
        Map<String, Object> pagingParams = new HashMap<>();
        pagingParams.put("q", q);
        pagingParams.put("type", type);
        int boardCount = boardRepository.boardSearchCount(pagingParams);
        int maxPage = (int)(Math.ceil((double)boardCount / pageLimit));
        int startPage = (((int)(Math.ceil((double) page / blockLimit))) - 1) * blockLimit + 1;
        int endPage = startPage + blockLimit - 1;
        if (endPage > maxPage) {
            endPage = maxPage;
        }
        PageDTO pageDTO = new PageDTO();
        pageDTO.setPage(page);
        pageDTO.setMaxPage(maxPage);
        pageDTO.setEndPage(endPage);
        pageDTO.setStartPage(startPage);
        return pageDTO;
    }

    public void updateHits(Long id) {
        boardRepository.updateHits(id);
    }

    public BoardDTO findById(Long id) {
        BoardDTO boardDTO = boardRepository.findById(id);
        return boardDTO;
    }

    public List<BoardFileDTO> findFile(Long id) {
        return boardRepository.findFile(id);
    }

    public void update(BoardDTO boardDTO) {
        boardRepository.update(boardDTO);

    }

    public void delete(Long id) {
        boardRepository.delete(id);
    }
}
