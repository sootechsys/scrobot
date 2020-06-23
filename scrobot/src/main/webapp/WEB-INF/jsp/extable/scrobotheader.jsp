<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>scrobot_공통헤더</title>
<script src="https://code.jquery.com/jquery-latest.js"></script> 
<link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/sample.css'/>" />
<style>
	
	.nav-container {
		display:flex;
		flex-direction:row;
		width:100%;
		height:50px;
		margin:0;
		padding:0;
		background-color:lightsky;
		list-style-type:none;
		background-color:#ccb68d;
		
	}
	
	#nav{
		z-index:1;
		position:fixed;
		width:100%
	}
	
	.nav-item {
		padding:15px;
		color:black;
		font-size:11pt;
		font-weight: bold;
	}
	
	.nav-item:hover {
		cursor:pointer;
	}
	
	.nav-item a {
		text-align:center;
		text-decoration:none;
		color:white;
		
	}
	
</style>
<script src="https://code.jquery.com/jquery-3.2.1.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript" src="./js/scrobot.js" ></script> 
<script type="text/javascript" src="./js/onclick.js" ></script> 
<script type="text/javascript" src="./js/focusOut.js" ></script> 
<script type="text/javascript" src="./js/table.js" ></script> 
<script src ="./js/colResizable-1.6.js"></script>
<script src ="./js/colResizable-1.6.min.js"></script>
<head>
<script type="text/javaScript">


	// 현재 화면 업무명
	vsWrkNm = "";
	
	//Clone
	voClone = [""];
	
	//clone index
	vnCloneIndex = 0;
	
	/* 2020.05.04
	상세보기 페이지를 위치시킨다.
	*///
	function info(){ 
		
		if($("#propertyTable").css("display") == "table"){
			$("#propertyTable").hide();
		}
		else{
			$("#propertyTable").show();
		}
	}
	
	function fn_sourceReset(){
	
		fn_saveClone();

		$("#creationTable").empty();
		vsWrkNm = "";
	}
		
	
	fn_saveClone = function(param){
	
		
	$("#li_rollback").attr("onclick","fn_sourceRollBack()");
	$("#li_rollback").css("color", "black");
	
	if(vnCloneIndex == 0){
		
		//되돌리기 위하여 클론저장
		if(param == "td"){
			voClone[0] = ($("#creationTable").html());
		} else{
			voClone.unshift($("#creationTable").html());
		}
		
		
	} else{
		for(var i=0; i<vnCloneIndex; i++){
			voClone.splice(0,1)
		}
		
		
		//되돌리기 위하여 클론저장
		if(param == "td"){
			voClone[0] = ($("#creationTable").html());
		} else{
			voClone.unshift($("#creationTable").html());
		}
		$("#li_restart").attr("onclick","");
		$("#li_restart").css("color", "grey");
		vnCloneIndex = 0;
	}
	
	
	}
	
	
	
	//되돌리기
	function fn_sourceRollBack(){
	
		if(vnCloneIndex == 0 && voClone.length == 1){
			//되돌리기 위하여 클론저장
			voClone.unshift($("#creationTable").html());
		}
		
		
	
		$("#creationTable").empty();
		vnCloneIndex++;
		$("#creationTable").append(voClone[vnCloneIndex]);
		
		
		if(vnCloneIndex == voClone.length-1){
			$("#li_rollback").attr("onclick","");
			$("#li_rollback").css("color", "grey");
		} else{
			$("#li_rollback").attr("onclick","fn_sourceRollBack()");
			$("#li_rollback").css("color", "black");
		}
		
		$("#li_restart").attr("onclick","fn_sourceRestart()");
		$("#li_restart").css("color", "black");

			
	}
	
	// 다시실행
	fn_sourceRestart = function(){
		if(voClone != ""){
		
			$("#creationTable").empty();
			vnCloneIndex--;
			$("#creationTable").append(voClone[vnCloneIndex]);
		
			if(vnCloneIndex == 0){
				$("#li_restart").attr("onclick","");
				$("#li_restart").css("color", "grey");
			} else{
				$("#li_restart").attr("onclick","fn_sourceRestart()");
				$("#li_restart").css("color", "black");
			}
			
			$("#li_rollback").attr("onclick","fn_sourceRollBack()");
			$("#li_rollback").css("color", "black");
		}
	}
	
	
	
	fn_preview = function(){
	
		var info = {"header" : "Preview",
				    "width"  : $("#creationForm").css("width"),
				    "height" : $("#creationForm").css("height")}
		robot.openPop(info,$("#div_creationForm").html(),"tag");
	}
	
	/* 다른이름으로 저장 function */
	fn_diffrentNmSave = function() {
		
		$.ajax({
			url : "/userIdSessionYn.do",
			type : "POST",
			success : function(data) {
				
				// 세션에 id 없을경우
				if(data == ""){
					robot.alert("세션이 만료되었습니다. 다시 로그인 해주시기 바랍니다.","","","fn_saveListCallAlert");
					
				// 세션에 id가 있다면
				} else{
					robot.prompt("업무명을 입력하시오",["업무명"],"","","fn_diffrentNmSaveCallBack");
				}

			},
			error : function() {
			}
		})
		
		
		
	}
	
	/* 다른이름으로 저장 CallBack */
	fn_diffrentNmSaveCallBack = function(param){
		
		if(param == ""){
			return false;
		}
		
		var vsHtml = $("#creationTable").html();
		var vsStyle = $("style").html();
		
		var vsbusinessNm = param[0]

		var vjCreationInfo = {
				"html" : vsHtml,
				"businessNm" : vsbusinessNm,
				"style" : vsStyle
		}
		
		$.ajax({
			url : "/creationHTML.do",
			type : "POST",
			data : vjCreationInfo,
			success : function(data) {
				robot.alert("저장되었습니다.");
				vsWrkNm = vsbusinessNm;

			},
			error : function() {
			}
		})
	}
	
	
	
	/* 저장 function */
	fn_createSource = function() {
		
		$.ajax({
			url : "/userIdSessionYn.do",
			type : "POST",
			success : function(data) {
				
				// 세션에 id 없을경우
				if(data == ""){
					robot.alert("세션이 만료되었습니다. 다시 로그인 해주시기 바랍니다.","","","fn_saveListCallAlert");
					
				// 세션에 id가 있다면
				} else{
					if(vsWrkNm == ""){
						robot.prompt("업무명을 입력하시오",["업무명"],"","","fn_diffrentNmSaveCallBack");
					} else{
						fn_diffrentNmSaveCallBack([vsWrkNm]);
					}
				}

			},
			error : function() {
			}
		})
		
		
		
		
		
		
	}
	
	
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
		
	
	/* 불러오기 function */
	fn_saveListCall = function(){
			
			
			
			
			$.ajax({
				url : "/userIdSessionYn.do",
				type : "POST",
				success : function(data) {
					
					// 세션에 id 없을경우
					if(data == ""){
						robot.alert("세션이 만료되었습니다. 다시 로그인 해주시기 바랍니다.","","","fn_saveListCallAlert");
						
					// 세션에 id가 있다면
					} else{
						var param = {
					    		"wrkNm" : "hi"
					    }
						var info = {"header" : "불러오기",
								    "width"  : "700px",
								    "height" : "500px",
								    "callBack" : "fn_saveListCallCallBack",
								    "param" : param}
						robot.openPop(info, "view010101P01.jsp");
					}

				},
				error : function() {
				}
			})
		
	}
		
	fn_saveListCallAlert = function(param){
		var info = {"header" : "로그인",
			    "width"  : "700px",
			    "height" : "500px"}
		robot.openPop(info, "user010101P01.jsp");
	}
		
	fn_saveListCallCallBack = function(param){
		vsWrkNm = param;
	}


</script>
</head>

<body>
	 <div id="nav">
	 	<ul class="nav-container">
	 		<li class="nav-item" onclick="fn_sourceReset();">새로만들기</li>
	 		<li class="nav-item" onclick="fn_saveListCall();">불러오기</li>
	 		<li class="nav-item" onclick="fn_createSource();">저장</li>
	 		<li class="nav-item" onclick="fn_diffrentNmSave();">다른이름으로저장</li>
	 		<li id="li_rollback" class="nav-item" onclick=";" style="color:grey;">되돌리기</li>
	 		<li id="li_restart" class="nav-item" onclick=";" style="color:grey;">다시실행</li>
	 		<li class="nav-item" onclick="info();">속성보기</li>
	 		<li class="nav-item" onclick="fn_preview();">미리보기</li>
	 		
	 	</ul>
	 </div>
</body>
</html>























