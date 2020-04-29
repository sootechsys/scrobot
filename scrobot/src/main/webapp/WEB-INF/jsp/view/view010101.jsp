<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
	/**
	* @Class Name : egovSampleList.jsp
	* @Description : Sample List 화면
	* @Modification Information
	*
	*   수정일         수정자                   수정내용
	*  -------    --------    ---------------------------
	*  2009.02.01            최초 생성
	*
	* author 실행환경 개발팀
	* since 2009.02.01
	*
	* Copyright (C) 2009 by MOPAS  All right reserved.
	*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><spring:message code="title.sample" /></title>
<link type="text/css" rel="stylesheet"
	href="<c:url value='/css/egovframework/sample.css'/>" />
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<style>
/* The Modal (background) */
.modal {
	position: fixed; /* Stay in place */
	z-index: 1; /* Sit on top */
	left: 0;
	top: 0;
	width: 100%; /* Full width */
	height: 100%; /* Full height */
	overflow: auto; /* Enable scroll if needed */
	background-color: rgb(0, 0, 0); /* Fallback color */
	background-color: rgba(0, 0, 0, 0.4); /* Black w/ opacity */
}

/* Modal Content/Box */
.modal-content {
	background-color: #fefefe;
	margin: 15% auto; /* 15% from the top and centered */
	padding: 20px;
	border: 1px solid #888;
	width: 30%; /* Could be more or less, depending on screen size */
}

.tableFocus {
	border: 3px solid grey !important;
}

[focus="true"]{
	border: 3px solid grey !important;
}


.span_title {
	font-weight: bold;
	font-size: 15pt;
	cursor: pointer;
	
}

.div_button{
	height:30px;
	margin-top:20px;
	
}

.button{
	
	margin-right:20px;
	width:60px;
	height:30px;
	
}

.creationTd{
	 cursor:pointer;
}

.inputBox{
	width:150px;
}
</style>
<script src="https://code.jquery.com/jquery-3.2.1.js"></script>
<script type="text/javaScript" language="javascript" defer="defer">



  fn_draggable = function(){
	  
	  $( ".div_content" ).draggable();
	  $( ".div_title" ).draggable({ containment: "parent" });
	  $( ".span_title" ).draggable({ containment: "parent" });
	  $( ".div_button" ).draggable({ containment: "parent" });
	  
	  $(".button").draggable({cancel:false, containment: "parent"});
	  $( ".div_table" ).draggable({ containment: "parent" });
  }

	// 포커스잡힌 td의 정보
	voFocusTdInfo = "";
	
	// 포커스잡힌 div의 정보
	voFocusDivInfo = "";
	
	// 선택된 컴포넌트 종류
	vsCompoClickDvs = "";
	
	
	vnDivContentCount = 0;
	vnTitleCount = 0;
	vnDivButtonCount = 0;
	vnButtonCount = 0;
	vnTableCount = 0;
	vnInputCount = 0;
	vnSelectCount = 0;
	
	
	
	
	/* ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓ 그리기 이벤트 ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓ */
	
	
	
	/* DIV 만들기 */
	function divCreation() {
		
		var width = prompt("가로 사이즈?");
		if(width == null){
			return false;
		}
		var height = prompt("세로사이즈?");

		if (width < 1 || height < 1) {
			return false;
		}

		// 전체 div 시작
		var vsSource = "<div id=\"div" + vnDivContentCount;
		vsSource += "\" class=\"div_content\" ";
		vsSource += " style=\"position:relative; margin-top:30px; width:"+width+"px; height:"+height+"px; border: 1px solid;\" ";
		vsSource += " onclick=\"fn_divOnClick(this)\">";

		vsSource += "</div>";

		$("#creationTable").append(vsSource);
		
		// divcontent영역 개수 증가
		vnDivContentCount ++;

	};
	
	
	
	
	
	/* TITLE 만들기 */
	function titleCreation() {
		
		// div focus 여부
		if(!fn_divFocusYn()){
			return false;
		};
		
		// 부모 가로크기
		var width = $(voFocusDivInfo).css("width");
		// 타이틀 div 시작
		var vsSource = "  <div id=\"div" + vnTitleCount + "_title";
		vsSource += "  \" class=\"div_title\" width=\""+width+"\" ";
		vsSource += "   style=\"position:relative; text-align:left; margin:10px 0px 0px 5px;\" ";
		vsSource += "  onclick=\"fn_divTitleOnClick(this)\" ";
		vsSource += ">";
	
		// 타이틀 이미지
		vsSource += "  <img src=\"<c:url value='/images/egovframework/example/title_dot.gif'/>\" />";
	
		// 타이틀 span
		vsSource += "  <span id=\"span" + vnTitleCount + "_title";
		vsSource += "  \"class=\"span_title\" "
		vsSource += "  onclick=\"fn_spanTitleOnClick(this)\"> Title "
		vsSource += "  </span>";
		vsSource += "  </div>";
		
		$(voFocusDivInfo).append(vsSource);
		
		vnTitleCount++;

	};
	
	
	/* button 만들기 */
	function buttonCreation() {
		
		// div focus 여부
		if(!fn_divFocusYn()){
			return false;
		};
		
		// 부모 가로크기
		var width = $(voFocusDivInfo).css("width");
		// 타이틀 div 시작
		var vsSource = "  <div id=\"div" + vnDivButtonCount + "_button";
		vsSource += "  \" class=\"div_button\" width=\""+width+"\"";
		vsSource += "   style=\"position:relative; text-align:right;\" ";
		vsSource += "  onclick=\"fn_divButtonOnClick(this)\"";
		vsSource += ">";
	
		// 타이틀 span
		vsSource += "  <input type=\"button\" id=\"div" + vnDivButtonCount + "_title_button" + vnButtonCount+"\"";
		vsSource += "  class=\"button\" "
		vsSource += "  value=\"button\" "
		vsSource += "  onclick=\"fn_buttonOnClick(this)\">"
		vsSource += "  </input>";
		vsSource += "  </div>";
		
		$(voFocusDivInfo).append(vsSource);
		
		vnDivButtonCount++;
		vnButtonCount++;

	};
	

	
	
	
	/* 테이블그리기 */
	function tableCreation() {
		
		// div focus 여부
		if(!fn_divFocusYn()){
			return false;
		};
		// 부모 가로크기
		var width = $(voFocusDivInfo).css("width");
		
		var column = prompt("몇행?");
		
		if(column == null){
			return false;
		}
		var row = prompt("몇열?");

		if (column < 1 || row < 1) {
			return false;
		}


		// div table 시작
		var vsTableSource = "  <div id=\"div" + vnTableCount + "_table";
		vsTableSource += "  \" class=\"div_table\" ";
		vsTableSource += "   style=\"position:relative; padding:10px 0px 10px 0px; width:"+(width-5)+"\" ";
		vsTableSource += "  onclick=\"fn_divTableOnClick(this)\" "
		vsTableSource += ">";

		// table 시작
		vsTableSource += "<table id=\"table" + vnTableCount;
		vsTableSource += "\" class=\"table\" border=\"1\" cellpadding=\"0\" cellspacing=\"0\" ";
		vsTableSource += " style=\"position:relative; margin:0px 12px 0px 12px; width:"+(width-24)+"\">";
		vsTableSource += "\n <colgroup>";

		for (var i = 0; i < column; i++) {
			//짝수 셀
			if(i % 2 == 0){
				vsTableSource += "\n  <col width=\"100\"/>";
			// 홀수 셀
			} else{
				vsTableSource += "\n  <col width=\"200\"/>";
			}
			
		}
		vsTableSource += "\n </colgroup>";
		
		//tbody 추가
		vsTableSource += "\n <tbody>"

		for (var i = 0; i < row; i++) {
			vsTableSource += "\n <tr>";
			for (var j = 0; j < column; j++) {
				vsTableSource += "\n  <td class=\"tbtd_content creationTd\" "
				vsTableSource += "name=\"tbtd_"+j+"\""
				vsTableSource += "style=\"height:30px;\" "
				vsTableSource += "onclick=\"fn_tdOnClick(this)\" "
				vsTableSource += "ondblclick=\"fn_tdDbClick(this)\"> "
				vsTableSource += "</td>";
			}
			vsTableSource += "\n </tr>";
		}
		
		//tbody 추가
		vsTableSource += "\n </tbody>"

		vsTableSource += "</table>";
		vsTableSource += "</div>";

		$(voFocusDivInfo).append(vsTableSource);

		vnTableCount++;

	};

	
	
	
	/* input박스 그리기 */
	function inputCreation() {

		fn_tableFocusYn();
		voFocusTdInfo.textContent = "";
		var vsInputSource = "<input type=\"text\" class=\"inputBox\" name=\"value"+vnInputCount+"\" ";
		vsInputSource += "readonly style=\"text-align:left\">";
		vsInputSource += "</input>";

		$(".tableFocus").append(vsInputSource);
		voFocusTdInfo.className = "tbtd_content";
		
		// input박스 왼쪽정렬
		$(voFocusTdInfo).css("text-align","left");
		
		vnInputCount++;
		
	};

	
	
	/* select박스 그리기 */
	function selectCreation() {

		fn_tableFocusYn();
		var vsSelectSource = "<select class=\"selectBox\" name=\"value"+vnSelectCount+"\"";
		vsSelectSource += "style=\"width:100px;\""
		vsSelectSource += "></select>";

		$(".tableFocus").append(vsSelectSource);
		voFocusTdInfo.className = "tbtd_content";
		
		vnSelectCount++;
	};
	
	
	/* ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑ 그리기 이벤트 ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑ */

	
	
	
	
	
	
	/* ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓ click 이벤트 ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓ */
	
	
	/* div 온클릭 이벤트 
	 * 포커스 주입 */
	fn_divOnClick = function(param) {
	
		fn_draggable();
		
		// 클릭한 값이 div라면
		if(vsCompoClickDvs == ""){
			
				
				//div 포커스 해제
				fn_divFocusCancel();
				//테이블 포커스 해제
				fn_tableFocusCancel();
				
				voFocusDivInfo = param;
				$(param).attr("focus","true");
				$(param).attr("mainFocus","true");
				
			
			
		} else if(vsCompoClickDvs == "divTitle" || vsCompoClickDvs == "divButton" || vsCompoClickDvs == "divTable"){
			if (voFocusDivInfo.className == "divFocus") {
				voFocusDivInfo.className = "";
		    } else {
		    	//div 포커스 해제
				fn_divFocusCancel();
				//테이블 포커스 해제
				fn_tableFocusCancel();
				$(voFocusDivInfo).attr("focus","true");
		    	
		    }

		
		} else if(vsCompoClickDvs == "td"){
			
			//div 포커스 해제
			fn_divFocusCancel();
			voFocusDivInfo = "";
		}

		
		vsCompoClickDvs = "";
	
	}
	
	
	/* div 타이틀 Onclick */
	fn_divTitleOnClick = function(param) {
		
		vsCompoClickDvs = "divTitle";
		voFocusDivInfo = param;

	}
	
	
	/* 스팬타이틀 Onclick */
	fn_spanTitleOnClick = function(param) {
		
		vsCompoClickDvs = "title";
		
		var title = prompt("타이틀을 입력하시오");
		if(title != null){
			param.textContent = title;
		}

	}
	
	
	
	/* div 버튼 Onclick */
	fn_divButtonOnClick = function(param) {
		
		vsCompoClickDvs = "divButton";
		voFocusDivInfo = param;

	}
	
	
	/* 버튼 Onclick */
	fn_buttonOnClick = function(param) {
		
		vsCompoClickDvs = "button";
		
		var buttonNm = prompt("버튼명을 입력하시오");
		if(buttonNm != null && buttonNm != ""){
			$(param).val(buttonNm);
		}

	}
	
	/* div 테이블 Onclick */
	fn_divTableOnClick = function(param) {
		
		if(vsCompoClickDvs != "td"){
			vsCompoClickDvs = "divTable";
			voFocusDivInfo = param;
		}
		

	}
	

	/* 테이블 td 온클릭 이벤트
		포커스 주입 */
	fn_tdOnClick = function(param) {
		
		vsCompoClickDvs = "td";
		// td에 자식이 없을 경우에만 포커스
		if(param.children.length == 0){
			if (param.className == "tableFocus") {
				param.className = "tbtd_content";
			} else {
				/* voFocusTdInfo.className = "tbtd_content";
				voFocusTdInfo = param; */
				param.className = "tableFocus";
			}
		}

	}

	/* 테이블 td 더블클릭 이벤트
		라벨 설정 */
	fn_tdDbClick = function(param) {
		var label = prompt("라벨을 입력하시오");
		
		if(label != null){
			param.textContent = label;
		}
		param.removeChild;

		voFocusTdInfo.className = "tbtd_content";

		
	}
	
	
	
	/* ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑ click 이벤트 ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑ */
	

	
	
	/* ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓ 포커스 이벤트 ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓ */
	
	/* Div 포커스 여부 */
	fn_divFocusYn = function() {
		
		var vnFocusCount = $("[mainFocus=true]").length;
		if (vnFocusCount == 0) {
			alert("div를 선택하여 주시기 바랍니다.")
			return false;
		} else{
			return true;
		}
	}

	/* 테이블 포커스 여부 */
	fn_tableFocusYn = function() {
		
		var vnFocusCount = $(".tableFocus").length;
		if (vnFocusCount == 0) {
			alert("셀을 선택하여 주시기 바랍니다.")
			return false;
		}
	}
	
	
	/* div focus 해제 */
	fn_divFocusCancel = function(){
		if($("[focus=true]").length != 0){
			$("[focus=true]").attr("focus","false");
			$("[mainFocus=true]").attr("mainFocus","false");
		}
	}
	
	/* table td focus 해제 */
	fn_tableFocusCancel = function(){debugger;
		
		var vnTableFocusCount = $(".tableFocus").length;
		if(vnTableFocusCount != 0){
			for(var i=0; i<vnTableFocusCount; i++){
				$(".tableFocus")[0].className = "tbtd_content";
			}
			
		}
	}
	
	
	/* ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑ 포커스 이벤트 ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑ */
	

	/* ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓ TABLE 이벤트 ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓ */
	
	/* 행추가 */
	function fn_tableColAdd() {
			
		var vsTableId = "#"+$(".tableFocus").parent().parent().parent().attr("id");
		var tdnum = $(vsTableId+"> tbody td").length;
		var trnum = $(vsTableId+"> tbody tr").length;
		
		var count = tdnum/trnum;
		
		var buffer = "<tr>";
		
		for(var i=0; i<count; i++){
			buffer += "\n  <td class=\"tbtd_content\" "
			buffer += "name=\"tbtd_"+i+"\""
			buffer += "style=\"height:30px; cursor:pointer\" "
			buffer += "onclick=\"fn_tdOnClick(this)\" "
			buffer += "ondblclick=\"fn_tdDbClick(this)\"> "
			buffer += "</td>"
		}
		
		buffer += "\n </tr>";
		
		$(vsTableId+"> tbody:last").append(buffer);
	}
	
	/* 행삭제 */
	function fn_tableColDel(){
		var vsTableId = "#"+$(".tableFocus").parent().parent().parent().attr("id");
		$(vsTableId+">tbody:last > tr:last").remove();
	}
	

	//행 병합;
	function fn_tableColMerge(){ 
		var colspan = $(".tableFocus").length;
		var tfnameList = $(".tableFocus").attr('name');
		if(colspan > 1){
			// 병합했던 셀의 병합을 위한 분기처리
			// 기존 colSpan 값을 가져온다
			var style = ($("td.tableFocus").attr('colSpan') == null) ? null : $(".tableFocus");
			if(style == null){
				$("td.tableFocus[name ="+tfnameList+"]").attr("class","tbtd_sum"); // 병합할 td 클래스명 일시변경
				$(".tbtd_sum").attr("colSpan",colspan);
				$(".tbtd_sum").attr("class","tbtd_content"); //원상복귀
				$(".tableFocus").remove();
				//$(".tableFocus").attr("class", "hide")
			}
			else if(style != null){//이미 병합한 셀이 있으면 원래 콜스판들 다 더해서 주면됨.
				var tempArray = new Array();
				$("td.tableFocus").each(function(){
					tempArray.push($(this).attr('colSpan')); //colSpan 값 가져옴
				});
					tempArray.filter(function(item){
						return item !== null && item !==undefined && item !== "";
					});
					
					//colSpan 값 더하기
					var totalCol = 0;
					var count = 0;
					for(var i=0; i<tempArray.length; i++){
						var num = tempArray[i];
						
						if(num !== undefined){
							var number = parseInt(num);
							totalCol += number;
						}else if(num === undefined){
							count++;
						}
					
					}
					
					totalCol += count;
					
					$("td.tableFocus[name ="+tfnameList+"]").attr("class","tbtd_sum");
					$(".tbtd_sum").attr("colSpan",totalCol);
					$(".tbtd_sum").attr("class","tbtd_content"); //원상복귀
					$(".tableFocus").remove();
			}
			
		}else{
			alert("2개이상 선택하세요");
		}
		
		
	}//fn_tableColMerge() end
	
	//행 분할s
 	function fn_tableColDivision(){ 
	 	var colspan = $(".tableFocus").attr("colSpan");
	 	var name = $(".tableFocus").attr('name');
 		var namenum = parseInt(name.substring(name.lastIndexOf("_")+1)); 
 		var buffer ="";
 		for(namenum; namenum<colspan; namenum++){
 			buffer += "\n  <td class=\"tbtd_content\" ";
 			buffer += "name=\"tbtd_"+namenum+"\"";
 			buffer += "style=\"height:30px; cursor:pointer\" ";
 			buffer += "onclick=\"fn_tdOnClick(this)\" ";
 			buffer += "ondblclick=\"fn_tdDbClick(this)\"> ";
 			buffer += "</td>";
 		}
		$("td.tableFocus[name ="+name+"]").after(buffer);
		$("td.tableFocus[name ="+name+"]").remove();
	}
	
	/* ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑ TABLE 이벤트 ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑ */
	
	
	
	

	/* 글 등록 화면 function */
	fn_createSource = function() {
		// html 만들기
		var vsHtml = $("#creationTable").html();
		var vsbusinessNm = $("#businessNm").val();
		var vsStyle = $("style").html();
		
		if(vsbusinessNm == null || vsbusinessNm == ""){
			alert("업무명을 입력하시오");
			return false;
		}
		var vjCreationInfo = {
				"html" : vsHtml,
				"businessNm" : vsbusinessNm,
				"style" : vsStyle
		}
		
		$.ajax({
			url : "/creationHTML.do",
			type : "POST",
			data : vjCreationInfo,
			success : function() {
				alert("완료");

			},
			error : function() {
			}
		})
		
		// 모든소스 만들기
/* 		var vjCreationInfo = $("#creationForm").serialize();

		$.ajax({
			url : "/creationSource.do",
			type : "POST",
			data : vjCreationInfo,
			success : function() {
				alert("완료");

			},
			error : function() {
			}
		}) */

	}
</script>
</head>

<body
	style="text-align: center; margin: 0 auto; display: inline; margin-top: 400px; overflow: auto;">
	<jsp:include page="../header.jsp" />
	<form:form id="editForm" name="editForm" method="post"
		style="overflow:auto; ">
		<div id="content_pop" style="width: 1200px;">
			<!-- 타이틀 -->
			<div id="title">
				<ul>
					<li><img
						src="<c:url value='/images/egovframework/example/title_dot.gif'/>"
						alt="" />화면그리기</li>
				</ul>
			</div>
			<!-- // 타이틀 -->
			<br></br> <br></br>
			<div style="width: 500px; float: left;">
				<table width="50%" border="1" cellpadding="0" cellspacing="0"
					style="align: center; bordercolor: #D3E2EC; bordercolordark: #FFFFFF; border-collapse: collapse;">
					<colgroup>
						<col width="100" />
						<col width="100" />
						<col width="100" />
					</colgroup>
					<tr>
						<td class="tbtd_content" style="cursor: pointer"
							onclick="divCreation();">DIV영역</td>
						<td class="tbtd_content" style="cursor: pointer"
							onclick="titleCreation();">TITLE</td>
						<td class="tbtd_content" style="cursor: pointer"
							onclick="tableCreation();">TABLE</td>
					</tr>
					<tr>
						<td class="tbtd_content" style="cursor: pointer"
							onclick="buttonCreation();">BTN 영역</td>
						<td class="tbtd_content" style="cursor: pointer"
							onclick="inputCreation();">Input Box</td>
						<td class="tbtd_content" style="cursor: pointer"
							onclick="selectCreation();">Select Box</td>

					</tr>
					
					<tr>
						<td class="tbtd_content" style="cursor: pointer" onclick="fn_tableColAdd();">행 추가</td>
					</tr>
					<tr>
						<td class="tbtd_content" style="cursor: pointer" onclick="fn_tableColDel();">행 삭제</td>
					</tr>
					<tr>
						<td class="tbtd_content" style="cursor: pointer" onclick="fn_tableColMerge();">병합</td>
					</tr>
					<tr>
						<td class="tbtd_content" style="cursor: pointer" onclick="fn_tableColDivision();">분할</td>
					</tr>
				</table>
			</div>


		</div>



	</form:form>
	<form:form id="creationForm"
		style="position:absolute; width: 600px; top: 100px; left: 400px;"
		name="creationForm" method="post">
		<div id="div_creationForm">
			<div id="div_businessNm">
				<span>업무명</span> <input type="text" value="" id="businessNm"
					name="businessNm"></input> <br></br>
			</div>
			<div id="creationTable">

			</div>
		</div>
		
		<div id="saveDiv" style="margin: 50px 0px 0px 250px;">
			<input type="button" onclick="fn_createSource()" value="생성"></input>
		</div>
	</form:form>




</body>
</html>
