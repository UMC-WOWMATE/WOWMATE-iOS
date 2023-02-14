//
//  File.swift
//  wowmate
//
//  Created by 김초원 on 2023/02/15.
//

import Foundation

let schoolImgUrl: [String : String] = [
    "가천대학교" : "https://wowmate-server-s3.s3.ap-northeast-2.amazonaws.com/school_images/%E1%84%80%E1%85%A1%E1%84%8E%E1%85%A5%E1%86%AB.jpg",
    "가톨릭대학교" : "https://wowmate-server-s3.s3.ap-northeast-2.amazonaws.com/school_images/%E1%84%80%E1%85%A1%E1%84%90%E1%85%A9%E1%86%AF%E1%84%85%E1%85%B5%E1%86%A8.jpg",
    "건국대학교" : "https://wowmate-server-s3.s3.ap-northeast-2.amazonaws.com/school_images/%E1%84%80%E1%85%A5%E1%86%AB%E1%84%80%E1%85%AE%E1%86%A8.jpg",
    "경희대학교": "https://wowmate-server-s3.s3.ap-northeast-2.amazonaws.com/school_images/%E1%84%80%E1%85%A7%E1%86%BC%E1%84%92%E1%85%B4.jpg",
    "광운대학교" : "https://wowmate-server-s3.s3.ap-northeast-2.amazonaws.com/school_images/%E1%84%80%E1%85%AA%E1%86%BC%E1%84%8B%E1%85%AE%E1%86%AB.jpg",

    "단국대학교" : "https://wowmate-server-s3.s3.ap-northeast-2.amazonaws.com/school_images/%E1%84%83%E1%85%A1%E1%86%AB%E1%84%80%E1%85%AE%E1%86%A8.jpg",

    "덕성여자대학교" : "https://wowmate-server-s3.s3.ap-northeast-2.amazonaws.com/school_images/%E1%84%83%E1%85%A5%E1%86%A8%E1%84%89%E1%85%A5%E1%86%BC%E1%84%8B%E1%85%A7.jpg",

    "동국대학교" : "https://wowmate-server-s3.s3.ap-northeast-2.amazonaws.com/school_images/%E1%84%83%E1%85%A9%E1%86%BC%E1%84%80%E1%85%AE%E1%86%A8.jpg",

    "동덕여자대학교" : "https://wowmate-server-s3.s3.ap-northeast-2.amazonaws.com/school_images/%E1%84%83%E1%85%A9%E1%86%BC%E1%84%83%E1%85%A5%E1%86%A8%E1%84%8B%E1%85%A7.jpg",

    "명지대학교" : "https://wowmate-server-s3.s3.ap-northeast-2.amazonaws.com/school_images/%E1%84%86%E1%85%A7%E1%86%BC%E1%84%8C%E1%85%B5.jpg",

    "부경대학교" : "https://wowmate-server-s3.s3.ap-northeast-2.amazonaws.com/school_images/%E1%84%87%E1%85%AE%E1%84%80%E1%85%A7%E1%86%BC.jpg",

    "부산대학교" : "https://wowmate-server-s3.s3.ap-northeast-2.amazonaws.com/school_images/%E1%84%87%E1%85%AE%E1%84%89%E1%85%A1%E1%86%AB.jpg",

    "서울시립대학교" :  "https://wowmate-server-s3.s3.ap-northeast-2.amazonaws.com/school_images/%E1%84%89%E1%85%A5%E1%84%8B%E1%85%AE%E1%86%AF%E1%84%89%E1%85%B5%E1%84%85%E1%85%B5%E1%86%B8.jpg",

    "서울여자대학교" : "https://wowmate-server-s3.s3.ap-northeast-2.amazonaws.com/school_images/%E1%84%89%E1%85%A5%E1%84%8B%E1%85%AE%E1%86%AF%E1%84%8B%E1%85%A7.jpg",

    "성신여지대학교" : "https://wowmate-server-s3.s3.ap-northeast-2.amazonaws.com/school_images/%E1%84%89%E1%85%A5%E1%86%BC%E1%84%89%E1%85%B5%E1%86%AB%E1%84%8B%E1%85%A7.jpg",

    "세종대학교" : "https://wowmate-server-s3.s3.ap-northeast-2.amazonaws.com/school_images/%E1%84%89%E1%85%A6%E1%84%8C%E1%85%A9%E1%86%BC.jpg",

    "숙명여자대학교" : "https://wowmate-server-s3.s3.ap-northeast-2.amazonaws.com/school_images/%E1%84%89%E1%85%AE%E1%86%A8%E1%84%86%E1%85%A7%E1%86%BC%E1%84%8B%E1%85%A7.jpg",

    "숭실대학교" : "https://wowmate-server-s3.s3.ap-northeast-2.amazonaws.com/school_images/%E1%84%89%E1%85%AE%E1%86%BC%E1%84%89%E1%85%B5%E1%86%AF.jpg",

    "아주대학교" : "https://wowmate-server-s3.s3.ap-northeast-2.amazonaws.com/school_images/%E1%84%8B%E1%85%A1%E1%84%8C%E1%85%AE.jpg",

    "이화여지대학교" : "https://wowmate-server-s3.s3.ap-northeast-2.amazonaws.com/school_images/%E1%84%8B%E1%85%B5%E1%84%92%E1%85%AA%E1%84%8B%E1%85%A7.jpg",

    "인하대학교" : "https://wowmate-server-s3.s3.ap-northeast-2.amazonaws.com/school_images/%E1%84%8B%E1%85%B5%E1%86%AB%E1%84%92%E1%85%A1.jpg",

    "중앙대학교" : "https://wowmate-server-s3.s3.ap-northeast-2.amazonaws.com/school_images/%E1%84%8C%E1%85%AE%E1%86%BC%E1%84%8B%E1%85%A1%E1%86%BC.jpg",

    "한국외국어대학교" : "https://wowmate-server-s3.s3.ap-northeast-2.amazonaws.com/school_images/%E1%84%92%E1%85%A1%E1%86%AB%E1%84%80%E1%85%AE%E1%86%A8%E1%84%8B%E1%85%AC.jpg",

    "한국항공대학교" : "https://wowmate-server-s3.s3.ap-northeast-2.amazonaws.com/school_images/%E1%84%92%E1%85%A1%E1%86%AB%E1%84%80%E1%85%AE%E1%86%A8%E1%84%92%E1%85%A1%E1%86%BC%E1%84%80%E1%85%A9%E1%86%BC.jpg",

    "한국해양대학교" : "https://wowmate-server-s3.s3.ap-northeast-2.amazonaws.com/school_images/%E1%84%92%E1%85%A1%E1%86%AB%E1%84%80%E1%85%AE%E1%86%A8%E1%84%92%E1%85%A2%E1%84%8B%E1%85%A3%E1%86%BC.jpg",

    "한양대학교" : "https://wowmate-server-s3.s3.ap-northeast-2.amazonaws.com/school_images/%E1%84%92%E1%85%A1%E1%86%AB%E1%84%8B%E1%85%A3%E1%86%BC.jpg",

    "홍익대학교" : "https://wowmate-server-s3.s3.ap-northeast-2.amazonaws.com/school_images/%E1%84%92%E1%85%A9%E1%86%BC%E1%84%8B%E1%85%B5%E1%86%A8.jpg",

    "경상국립대학교" : "https://wowmate-server-s3.s3.ap-northeast-2.amazonaws.com/school_images/%E1%84%80%E1%85%A7%E1%86%BC%E1%84%89%E1%85%A1%E1%86%BC%E1%84%80%E1%85%AE%E1%86%A8%E1%84%85%E1%85%B5%E1%86%B8.jpg",

]
 






