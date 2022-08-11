<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>adContent</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
    'use strict';
 
    google.charts.load('current', {'packages':['line']});
    google.charts.setOnLoadCallback(drawChart);
/*     function test(res) {
    	let startDate = document.getElementById("datepicker1").value;
	   	 let endDate = document.getElementById("datepicker2").value;    	 
	   	 let period = document.getElementById("period").value;    	 
	   	 var date = new Date(startDate, endDate);
    } */
    /*    function period(){    	
		 let period = document.getElementById("period").value;
		 if(period == "day"){
			 period = 1;
		 }
		 else if(period == "month"){
			 period = 30;
		 }
		 else {
			 period = 365;
		 }
		 $.ajax({
				type : "post",
				url : "${ctp}/admin/adStatistics",
				data : {
					idx : period,
				},
				async : false,
				success : function(res) {
					alert("완료");
					location.reload();
				},
				error : function() {
					alert("삭제실패");	
				}
			});
    } */
    let period = 1;
    let datepicker1;
	let datepicker2;
    let calDate = 0; 
   
	function date(){
    	 datepicker1 = document.getElementById("datepicker1").value;
    	 datepicker2 = document.getElementById("datepicker2").value;    
    	
    	 const startDate = new Date(datepicker1);
    	 const endDate = new Date(datepicker2);
    	 const diffDate = startDate.getTime() - endDate.getTime();
    	 calDate = Math.abs(diffDate / (1000 * 60 * 60 * 24));
    }
    
    function periods(){    	
		 period = document.getElementById("period").value;
		 if(period == "day"){
			 period = 1;
		 }
		 else if(period == "month"){
			 period = 30;
		 }
		 else {
			 period = 365;
		 }	
    }
    function search(){
    	if(calDate == 0){
    		alert("날짜를 이틀 이상 선택해주세요");
    		return false;
    	}
    	console.log("calDate " + calDate);
    	console.log("period " + period);
    	calDate = Math.round(calDate / period);
    	console.log("calDate2 " + calDate);
    	$.ajax({
			type : "post",
			url : "${ctp}/admin/adStatistics",
			data : {
				datepicker1 : datepicker1,
				datepicker2 : datepicker2,
				calDate : calDate,
				period : period
			},
			async : false,
			success : function(res) {
				alert("성공");
				location.reload();
			},
			error : function() {
				alert("삭제실패");	
			}
		});
    }
/*     <c:if test="${not st.last}">,
	</c:if> */
    <c:set var="mPeriod" value="${mPeriod}"/>
    <c:set var="mCalDate" value="${mCalDate}"/>  
    <c:set var="sPeriod" value="${sPeriod}"/>
    <c:set var="sCalDate" value="${sCalDate}"/> 
    function drawChart() { 
		 var data = new google.visualization.DataTable();
    	 data.addColumn('number', 'Day');
         data.addColumn('number', 'Guardians of the Galaxy');
         data.addColumn('number', 'The Avengers');
         data.addColumn('number', 'Transformers: Age of Extinction');
       	 data.addRows([
      	        <c:forEach var="y" begin="0" end="${sCalDate}" step="1" varStatus="st">
	              	[${y},  100,  100,  100],
      	 		</c:forEach>      
              ]);
         var options = {
           chart: {
             title: 'Box Office Earnings in First Two Weeks of Opening',
             subtitle: 'in millions of dollars (USD)'
           },
           width: 900,
           height: 500,
           axes: {
             x: {
               0: {side: 'top'}
             }
           }
         };

         var chart = new google.charts.Line(document.getElementById('line_top_x'));

         chart.draw(data, google.charts.Line.convertOptions(options)); 
       }
    	
	$(function() {
	       //input을 datepicker로 선언
	       $("#datepicker1,#datepicker2").datepicker({
	           dateFormat: 'yy-mm-dd' //달력 날짜 형태
	           ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
	           ,showMonthAfterYear:true // 월- 년 순서가아닌 년도 - 월 순서
	           ,changeYear: true //option값 년 선택 가능
	           ,changeMonth: true //option값  월 선택 가능                
	           ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
	           ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
	           ,buttonImageOnly: true //버튼 이미지만 깔끔하게 보이게함
	           ,buttonText: "선택" //버튼 호버 텍스트              
	           ,yearSuffix: "년" //달력의 년도 부분 뒤 텍스트
	           ,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 텍스트
	           ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip
	           ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 텍스트
	           ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 Tooltip
	           ,minDate: "-5Y" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
	           ,maxDate: "+0D" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)  
	       });                    
	       
	       //초기값을 오늘 날짜로 설정해줘야 합니다.
	       $('#datepicker').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)            
	   });
  </script>
</head>
<body>
	<div id="line_top_x"></div>
<%-- 	<select id="year" onchange="">
		<option onchange="year()">년도별 통계</option>
		<c:forEach var="y" begin="${year-5}" end="${year}" step="1">
			<option value="20${y}">20${y}년</option>	  		
		</c:forEach>
	</select>
	<select id="month" onchange="month()">
		<option value="">월별 통계</option>
		<c:forEach var="m" begin="1" end="${month}" step="1">
	 		<option value="${m}">${m}월</option>	
	 	</c:forEach>
	</select>
	<select id="day" onchange="days()">
		<option value="">일별 통계</option>
		<c:forEach var="d" begin="1" end="${days}" step="1">
			<option value="${d}">${d}일</option>	
		</c:forEach>
	</select> --%>
	<select id="period" onchange="periods()">
		<option value="day">일별 통계</option>
		<option value="month">월별 통계</option>
		<option value="year">년도별 통계</option>
	</select>
	<p>조회기간을 선택해주세요
		<input type="text" id="datepicker1" onchange="date()">
	    <input type="text" id="datepicker2" onchange="date()"> 
<!-- 	    <input type="text" id="datepicker1" onchange="test(1)">
	    <input type="text" id="datepicker2" onchange="test(2)"> -->
	    <input type="button" id="" value="검색" onclick="search()">
	</p>
	<c:if test=""></c:if>
</body>
</html>