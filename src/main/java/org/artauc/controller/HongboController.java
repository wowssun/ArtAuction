package org.artauc.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.artauc.domain.HongboVO;
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
@RequestMapping("/hongbo/*")
public class HongboController {


	@GetMapping("list")
    public void hongbolist(Model model) {

        log.info("Hongbo Controller List!");
        
        List<HongboVO> exhList = null;

        try {
             exhList = new ArrayList<HongboVO>();
             
             String baseUrl = "https://www.mcst.go.kr/kor/s_culture/culture/cultureList.jsp?pSeq=&pRo=&pCurrentPage="; //문체부문화예술공연전시페이지
             String pageType = "&pType=%EC%A0%84%EC%8B%9C";

            for (int currentPage = 1; currentPage <= 5; currentPage++) { //페이지 for문
                String url = baseUrl + currentPage + pageType;
                Document doc = Jsoup.connect(url).get();
                Elements exhDiv = doc.select("div.contentWrap"); //리스트 전체(페이징포함)
                Elements exhUL = exhDiv.eq(0).select("ul.mediaWrap"); //목록 하나
               
//               log.info(url);
//               log.info(exhUL.size());
//               log.info(exhUL);
               
                for (int i = 0; i < exhUL.size(); i++) { // ul for문
                	
               	      Elements li = exhUL.eq(i).select("li");

               	      //log.info(li.size());

                for (int j = 0; j < li.size(); j++) { // ul 안에 li for문

                    	        	    	String exhImg = "https://www.mcst.go.kr" + li.eq(j).select("div.img img").attr("src");
                    	        	    	String exhName = li.eq(j).select("p.title").text();
                    	        	    	String exhDate = li.eq(j).select("ul.list03 li:contains(기간)").text().split(":").length > 1 ? li.eq(j).select("ul.list03 li:contains(기간)").text().split(":")[1].trim() : "";
                    	        	        String place = li.eq(j).select("ul.list03 li:contains(장소)").text().split(":").length > 1 ? li.eq(j).select("ul.list03 li:contains(장소)").text().split(":")[1].trim() : "";
                    	        	        String contact = li.eq(j).select("ul.list03 li:contains(문의)").text().split(":").length > 1 ? li.eq(j).select("ul.list03 li:contains(문의)").text().split(":")[1].trim() : "";       	        	  
                    	        	        String pSeq = "";
                    	        	        String pRo = "";
                    	        	        String[] hrefSplit = li.eq(j).select("a").attr("href").split("pSeq=");
                    	        	        String[] pRoSplit = li.eq(j).select("a").attr("href").split("pRo=");
                    	        	        if (hrefSplit.length > 1 || pRoSplit.length > 1 ) {
                    	        	            pSeq = hrefSplit[1].split("&")[0].trim();
                    	        	            pRo = pRoSplit[1].trim();
                    	        	        } else {
                    	        	            continue; // pSeq, pRo가 없으면 현재 반복문 건너뛰기
                    	        	        } //이렇게 안 하면 상세주소 pSeq, pRo 값이 null인게 안 걸러짐
                    	        	        
                    	        	        String exhDetail = "https://www.mcst.go.kr/kor/s_culture/culture/cultureView.jsp?pSeq="+pSeq+"&pRo="+pRo+"&pCurrentPage="+currentPage+pageType;
                    	        	        System.out.println("exhDetail~ "+exhDetail);
                    	        	        Document detaildoc = Jsoup.connect(exhDetail).get();
                    	        	        Elements tdetailDiv = detaildoc.select("div.contentWrap");
                    	        	        Elements detailDiv = detaildoc.select("div.board_detail");
                    	        	        String field = detailDiv.select("dl dt:contains(분야) + dd").text();
                    	        	        String exhTime = detailDiv.select("dl dt:contains(시간) + dd").text();
                    	        	        String charge = detailDiv.select("dl dt:contains(요금) + dd").text();
                    	        	        String homeurl = detailDiv.select("dl dt:contains(바로가기) + dd").text();
                    	        	        String exhIntro = tdetailDiv.select("div.view_con p").text();
                    	        	        

                    	        	        System.out.println("-----------------------------");
                    	        	        System.out.println(exhImg);
                    	        	        System.out.println(exhName);
                    	        	        System.out.println(exhDate);
                    	        	        System.out.println(place);
                    	        	        System.out.println(contact);
                    	        	        System.out.println(pSeq);
                    	        	        System.out.println(pRo);
                    	        	        System.out.println(field);
                    	        	        System.out.println(exhTime);
                    	        	        System.out.println(charge);
                    	        	        System.out.println(homeurl);
                    	        	        System.out.println(exhIntro);
                    	        	        System.out.println("-----------------------------");

                    	        	        HongboVO hbvo = new HongboVO();
                    	        	        hbvo.setExhImg(exhImg);
                    	        	        hbvo.setExhName(exhName);
                    	        	        hbvo.setExhDate(exhDate);
                    	        	        hbvo.setPlace(place);
                    	        	        hbvo.setContact(contact);
                    	        	        hbvo.setPSeq(pSeq);
                    	        	        hbvo.setPSeq(pRo);
                    	        	        hbvo.setField(field);
                    	        	        hbvo.setExhTime(exhTime);
                    	        	        hbvo.setCharge(charge);
                    	        	        hbvo.setHomeurl(homeurl);
                    	        	        hbvo.setExhIntro(exhIntro);

                    exhList.add(hbvo);
                }//end for
            }//end for
           }//end for
        } catch (IOException e) {
            e.printStackTrace();
        }
        model.addAttribute("list", exhList);
    }
}
