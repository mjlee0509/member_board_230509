package com.icia.mjuniverse.dto;

import lombok.Data;

@Data
public class MemberProfileDTO {

    private Long id;
    private String originalFileName;
    private String storedFileName;
    private Long memberId;

}
