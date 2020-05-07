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

  #sortable { list-style-type: none; margin: 0; padding: 0; }
  #sortable li { margin: 0 3px 3px 3px; padding: 0.4em; padding-left: 1.5em; font-size: 1.0em; height: 10px; }
  #sortable li span { position: absolute; margin-left: -1.3em; }
  .ui-state-highlight { height: 1.5em; line-height: 1.2em; }
  .ui-sortable{background: #eee;}
[level="1"] { margin-top: 30px !important; }
[level="2"] { margin-left: 20px !important; }
.tableFocus {
	border: 3px solid grey !important;
}

[focus="true"]{
	border: 3px solid grey !important;
}

.div_content{
	overflow:hidden;
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



</script>
</head>

<body
	style="text-align: center; margin: 0 auto; display: inline; margin-top: 400px; overflow: auto;">
	<jsp:include page="../extable/scrobotheader.jsp" />
	<jsp:include page="../extable/scrobotleft.jsp" flush="false"/>



	<form:form id="creationForm"
		style="position:absolute; top: 100px; left: 400px;"
		name="creationForm" method="post">
		<div id="div_creationForm">
			<div id="creationTable">

			</div>
			
		</div>
	</form:form>

</body>
</html>
