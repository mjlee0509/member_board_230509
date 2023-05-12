package com.icia.mjuniverse.dto;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

@Data
public class BoardFileDTO {
    private Long id;
    private String originalFileName;
    private String storedFileName;
    private Long boardId;
}
