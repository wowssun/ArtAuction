package org.artauc.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.artauc.domain.NewsVO;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/news/*")
public class NewsController {


	@GetMapping("list")
    public void newslist(Model model) {

        log.info("News Controller List!");
        
        List<NewsVO> newList = null;

        try {
        	newList = new ArrayList<NewsVO>();
             
             String baseUrl = "https://www.mhns.co.kr/news/articleList.html?page="; //문화뉴스페이지
             String pageType = "&total=3189&box_idxno=&sc_section_code=&sc_sub_section_code=S2N87&sc_serial_code=&sc_area=&sc_level=&sc_article_type=&sc_view_level=&sc_sdate=&sc_edate=&sc_serial_number=&sc_word=&sc_multi_code=&sc_is_image=&sc_is_movie=&sc_user_name=&sc_order_by=E&view_type=sm";

            for (int currentPage = 1; currentPage <= 2 ; currentPage++) { //페이지 for문
                String url = baseUrl + currentPage + pageType;
                Document doc = Jsoup.connect(url).get();
                Elements newsDiv = doc.select("div#user-section"); //리스트 전체(페이징포함)
                Elements newsUL = newsDiv.eq(0).select("section#section-list ul.type2"); 
               
               
                for (int i = 0; i < newsUL.size(); i++) { // ul for문
                	
               	      Elements li = newsUL.eq(i).select("li");

               	      //log.info(li.size());

                for (int j = 0; j < li.size(); j++) { // ul 안에 li for문
                    	        	    	String newsImg = li.eq(j).select("a.thumb img").attr("src");
                    	        	    	String title = li.eq(j).select("div.view-cont h4.titles").text();
                    	        	    	String script = li.eq(j).select("div.view-cont p.lead").text();
                    	        	        String genre = li.eq(j).select("span.byline em:nth-child(1)").text();
                    	        	        String writer = li.eq(j).select("span.byline em:nth-child(2)").text();       	        	  
                    	        	        String updateDate = li.eq(j).select("span.byline em:nth-child(3)").text();
                    	        	        String newsUrl  = "https://www.mhns.co.kr/" + li.eq(j).select("div.view-cont p.lead a").attr("href");
//                    	        	        String[] hrefSplit = li.eq(j).select("a").attr("href").split("pSeq=");
//                    	        	        String[] pRoSplit = li.eq(j).select("a").attr("href").split("pRo=");
//                    	        	        if (hrefSplit.length > 1 || pRoSplit.length > 1 ) {
//                    	        	            pSeq = hrefSplit[1].split("&")[0].trim();
//                    	        	            pRo = pRoSplit[1].trim();
//                    	        	        } else {
//                    	        	            continue; // pSeq, pRo가 없으면 현재 반복문 건너뛰기
//                    	        	        } //이렇게 안 하면 상세주소 pSeq, pRo 값이 null인게 안 걸러짐
                    	        	        
//                    	        	        String exhDetail = "https://www.mcst.go.kr/kor/s_culture/culture/cultureView.jsp?pSeq="+pSeq+"&pRo="+pRo+"&pCurrentPage="+currentPage+pageType;
//                    	        	        System.out.println("exhDetail~ "+exhDetail);
//                    	        	        Document detaildoc = Jsoup.connect(exhDetail).get();
//                    	        	        Elements tdetailDiv = detaildoc.select("div.contentWrap");
//                    	        	        Elements detailDiv = detaildoc.select("div.board_detail");
//                    	        	        String field = detailDiv.select("dl dt:contains(분야) + dd").text();
//                    	        	        String exhTime = detailDiv.select("dl dt:contains(시간) + dd").text();
//                    	        	        String charge = detailDiv.select("dl dt:contains(요금) + dd").text();
//                    	        	        String homeurl = detailDiv.select("dl dt:contains(바로가기) + dd").text();
//                    	        	        String exhIntro = tdetailDiv.select("div.view_con p").text();
                    	        	        

                    	        	        System.out.println("-----------------------------");
                    	        	        System.out.println(newsImg);
                    	        	        System.out.println(title);
                    	        	        System.out.println(script);
                    	        	        System.out.println(genre);
                    	        	        System.out.println(writer);
                    	        	        System.out.println(updateDate);
                    	        	        System.out.println(newsUrl);
                    	        	        System.out.println("-----------------------------");

                    	        	        NewsVO nvo = new NewsVO();
                    	        	        nvo.setNewsImg(newsImg);
                    	        	        nvo.setTitle(title);
                    	        	        nvo.setScript(script);
                    	        	        nvo.setGenre(genre);
                    	        	        nvo.setWriter(writer);
                    	        	        nvo.setUpdateDate(updateDate);
                    	        	        nvo.setNewsUrl(newsUrl);
                    	        	        

                    	        	        newList.add(nvo);
                }//end for
            }//end for
           }//end for
        } catch (IOException e) {
            e.printStackTrace();
        }
        model.addAttribute("list", newList);
    }
}
