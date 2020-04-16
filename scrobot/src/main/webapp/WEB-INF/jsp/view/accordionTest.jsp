<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title><spring:message code="title.sample" /></title>
    <link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/sample.css'/>"/>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <style>
  		.ui-widget-content { width: 150px; height: 150px; padding: 0.5em; }
  	</style>

	<script src="https://code.jquery.com/jquery-2.2.1.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script type="text/javaScript" language="javascript" defer="defer">

    
    $( function() {
        $( "#draggable" ).draggable();
        $( "#draggable2" ).draggable();
      } );
    
    
    save = function(){debugger;
    	alert($(".ui-widget-content").attr("style"))
    }


    </script>
</head>

<body>
 
<div id="draggable" class="ui-widget-content">
  <p>Drag me around</p>
</div>
<div id="draggable2" class="ui-widget-content">
  <p>Drag me around</p>
</div>
<div>
	<input type="button" onclick="save();" value="저장" style="position:relative; left:500px;"></input>
</div>
 
 
</body>
</html>
