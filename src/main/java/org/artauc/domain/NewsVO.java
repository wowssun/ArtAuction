package org.artauc.domain;

import lombok.Data;

@Data
public class NewsVO {
	private String title;
	private String script;
	private String genre;
	private String writer;
	private String updateDate;
	private String newsImg;
	private String newsUrl;

}
