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
</style>
<script src="https://code.jquery.com/jquery-2.2.1.js"></script>
<script type="text/javaScript" language="javascript" defer="defer">


	function tableCreation() {
		debugger;
		var column = prompt("몇행?");
		var row = prompt("몇열?");
		
		if(column < 1 || row < 1){
			return false;
		}

		var tableCount = $(".table").length

		var vsTableSource = "<table id=\"table"
				+ tableCount
				+ "\" class=\"table\" width=\"50%\" border=\"1\" cellpadding=\"0\" cellspacing=\"0\" style=\"position:relative; left:500px; margin-top:50px;\">";
		vsTableSource += "\n <colgroup>";

		for (var i = 0; i < column; i++) {
			vsTableSource += "\n  <col width=\"100\"/>";
		}
		vsTableSource += "\n </colgroup>";

		for (var i = 0; i < row; i++) {
			vsTableSource += "\n <tr>";
			for (var j = 0; j < column; j++) {
				vsTableSource += "\n  <td class=\"tbtd_content\" style=\"height:30px;\"></td>";
			}
			vsTableSource += "\n </tr>";
		}

		vsTableSource += "</table>";

		$("#creationTable").append(vsTableSource);

	};

	function inputCreation() {debugger;


		var tableCount = $(".table").length
		var vsInputSource = "<input type=\"text\" class=\"text\" name=\"label"+tableCount+"\"></input><input type=\"text\" class=\"text\" name=\"value"+tableCount+"\"></input><br>";



		$("#creationTable").append(vsInputSource);

	};

	/* 글 등록 화면 function */
	fn_createSource = function() {
		var vjCreationInfo = $("#creationForm").serialize();

		$.ajax({
            url: "/creationSource.do",
            type: "POST",
            data: vjCreationInfo,
            success: function(){
            	alert("완료");

            },
            error: function(){
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
			<br></br>
			<br></br>
			<div style="width: 500px; float: left;">
				<table width="50%" border="1" cellpadding="0" cellspacing="0"
					style="align: center; bordercolor: #D3E2EC; bordercolordark: #FFFFFF; border-collapse: collapse;">
					<colgroup>
						<col width="100" />
						<col width="100" />
					</colgroup>
					<tr>
						<td class="tbtd_content" style="cursor: pointer"
							onclick="tableCreation();">table creation</td>
					</tr>
					<tr>
						<td class="tbtd_content" style="cursor: pointer"
							onclick="inputCreation();">inputBox
								creation</a></td>
					</tr>
					<tr>
						<td class="tbtd_content"><a href="/hi.do">selectBox
								creation</a></td>
					</tr>
				</table>
			</div>


		</div>


	
    </form:form>
    <form:form id="creationForm" name="creationForm" method="post">
	<div id="creationTable">
		<span>업무명</span>
		<input type="text" value="" id="businessNm" name="businessNm"></input>
		<br></br>
	</div>
	</form:form>
	<div id="saveDiv" style="margin:50px 0px 0px 250px;">
		<input type="button" onclick="fn_createSource()" value="생성"></input>
	</div>



</body>
</html>
