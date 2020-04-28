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
	background-color: grey;
}

.span_title {
	font-weight: bold;
	font-size: 15pt;
	cursor: pointer;
}
</style>
<script src="https://code.jquery.com/jquery-2.2.1.js"></script>
<script type="text/javaScript" language="javascript" defer="defer">

	// 포커스잡힌 td의 정보
	voFocusTdInfo = "";

	/* 테이블그리기 */
	function tableCreation() {
		
		var column = prompt("몇행?");
		var row = prompt("몇열?");

		if (column < 1 || row < 1) {
			return false;
		}

		var contentCount = $(".content").length;

		// 전체 div 시작
		var vsTableSource = "<div id=\"div" + contentCount;
		vsTableSource += "\" class=\"content\" width=\"500\"";
		vsTableSource += " style=\"position:relative; margin-top:30px;\">";

		// 타이틀 div 시작
		vsTableSource += "  <div id=\"div" + contentCount + "_title";
		vsTableSource += "  \" class=\"div_title\" width=\"500\"";
		vsTableSource += "   style=\"position:relative; text-align:left;\">";

		// 타이틀 이미지
		vsTableSource += "  <img src=\"<c:url value='/images/egovframework/example/title_dot.gif'/>\" />";

		// 타이틀 span
		vsTableSource += "  <span id=\"span" + contentCount + "_title";
		vsTableSource += "  \"class=\"span_title\" "
		vsTableSource += "  onclick=\"fn_titleSpanOnClick(this)\"> Title "
		vsTableSource += "  </span>";
		vsTableSource += "  </div>";

		// div table 시작
		vsTableSource += "  <div id=\"div" + contentCount + "_table";
		vsTableSource += "  \" class=\"div_table\" width=\"500\"";
		vsTableSource += "   style=\"position:relative;\">";

		// table 시작
		vsTableSource += "<table id=\"table" + contentCount;
		vsTableSource += "\" class=\"table\" width=\"500\" border=\"1\" cellpadding=\"0\" cellspacing=\"0\" ";
		vsTableSource += " style=\"position:relative; margin-top:10px;\">";
		vsTableSource += "\n <colgroup>";

		for (var i = 0; i < column; i++) {
			vsTableSource += "\n  <col width=\"100\"/>";
		}
		vsTableSource += "\n </colgroup>";

		for (var i = 0; i < row; i++) {
			vsTableSource += "\n <tr>";
			for (var j = 0; j < column; j++) {
				vsTableSource += "\n  <td class=\"tbtd_content\" "
				vsTableSource += "style=\"height:30px; cursor:pointer\" "
				vsTableSource += "onclick=\"fn_tdOnClick(this)\" "
				vsTableSource += "ondblclick=\"fn_tdDbClick(this)\"> "
				vsTableSource += "</td>";
			}
			vsTableSource += "\n </tr>";
		}

		vsTableSource += "</table>";
		vsTableSource += "</div>";
		vsTableSource += "</div>";

		$("#creationTable").append(vsTableSource);

	};

	/* input박스 그리기 */
	function inputCreation() {debugger;

		fn_tableFocusYn();
		voFocusTdInfo.textContent = "";
		var inputCount = $(".inputBox").length
		var vsInputSource = "<input type=\"text\" class=\"inputBox\" name=\"value"+inputCount+"\" readonly></input>";

		$(".tableFocus").append(vsInputSource);
		voFocusTdInfo.className = "tbtd_content";
		
	};

	/* select박스 그리기 */
	function selectCreation() {

		fn_tableFocusYn();
		var selectCount = $(".selectBox").length
		var vsSelectSource = "<select class=\"selectBox\" name=\"value"+selectCount+"\"></select>";

		$(".tableFocus").append(vsSelectSource);
		voFocusTdInfo.className = "tbtd_content";
	};

	

	/* 타이블 span Onclick */
	fn_titleSpanOnClick = function(param) {
		var title = prompt("타이틀을 입력하시오");
		if(title != null && title != ""){
			param.textContent = title;
		}

	}

	/* 포커스 여부 */
	fn_tableFocusYn = function() {
		
		var vnFocusCount = $(".tableFocus").length;
		if (vnFocusCount == 0) {
			alert("셀을 선택하여 주시기 바랍니다.")
			return false;
		}
	}

	/* 테이블 td 온클릭 이벤트
		포커스 주입 */
	fn_tdOnClick = function(param) {
		
		// td에 자식이 없을 경우에만 포커스
		if(param.children.length == 0){
			if (param.className == "tableFocus") {
				param.className = "tbtd_content";
			} else {
				voFocusTdInfo.className = "tbtd_content";
				voFocusTdInfo = param;
				param.className = "tableFocus";
			}
		}
	
		

	}

	/* 테이블 td 더블클릭 이벤트
		라벨 설정 */
	fn_tdDbClick = function(param) {debugger;
		var label = prompt("라벨을 입력하시오");
		
		if(label != null && label != ""){
			param.textContent = label;
		}
		param.removeChild;

		voFocusTdInfo.className = "tbtd_content";

	}

	/* 글 등록 화면 function */
	fn_createSource = function() {
		var vjCreationInfo = $("#creationForm").serialize();

		$.ajax({
			url : "/creationSource.do",
			type : "POST",
			data : vjCreationInfo,
			success : function() {
				alert("완료");

			},
			error : function() {
			}
		})

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
							onclick="tableCreation();">table</td>
						<td class="tbtd_content" style="cursor: pointer"
							onclick="inputCreation();">inputBox</td>
						<td class="tbtd_content" style="cursor: pointer"
							onclick="selectCreation();">selectBox</td>

					</tr>
					<tr>

					</tr>
					<tr>

					</tr>
				</table>
			</div>


		</div>



	</form:form>
	<form:form id="creationForm"
		style="position:absolute; width: 600px; top: 100px; left: 400px;"
		name="creationForm" method="post">
		<div id="creationTable">
			<div id="div_businessNm">
				<span>업무명</span> <input type="text" value="" id="businessNm"
					name="businessNm"></input> <br></br>
			</div>

		</div>
		<div id="saveDiv" style="margin: 50px 0px 0px 250px;">
			<input type="button" onclick="fn_createSource()" value="생성"></input>
		</div>
	</form:form>




</body>
</html>
