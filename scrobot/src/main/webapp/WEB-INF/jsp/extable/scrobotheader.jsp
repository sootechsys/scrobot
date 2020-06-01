<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>scrobot_공통헤더</title>
<script src="https://code.jquery.com/jquery-latest.js"></script> 
 
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
		background-color:#97d5e0;
		
	}
	
	#nav{
		z-index:1;
		position:fixed;
		width:100%
	}
	
	.nav-item {
		padding:15px;
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
<script src ="./js/colResizable-1.6.js"></script>
<script src ="./js/colResizable-1.6.min.js"></script>
<head>
<script type="text/javaScript">
	
	/* 2020.05.04
	상세보기 페이지를 위치시킨다.
	*/
	var infoCount = 0;
	function info(){ 
		$("#propertyTable").show();
		if(infoCount == 0){
			infoCount++;
		}
		else if(infoCount == 1){
			$("#propertyTable").hide();
			infoCount--;
		}
	}
		
	//생성한 모든 컴포넌트를 삭제
	var RollBack = "";
	function fn_sourceReset(){
		//복사 후 삭제. 되돌리기 위하여
		RollBack = $("#creationTable").clone();
		//$("#creationTable").html(RollBack);
		//console.log(RollBack);
		$("#creationTable").empty();
	}
	
	//되돌리기
	function fn_sourceRollBack(){debugger;
		if(RollBack != null){
			RollBack.appendTo("#creationTable");
		}else{
			alert("되돌릴 테이터가 없습니다.");
		}
	}
	
	fn_preview = function(){
	
		var info = {"header" : "Preview",
				    "width"  : $("#creationForm").css("width"),
				    "height" : $("#creationForm").css("height")}
		robot.openPop(info, "",$("#div_creationForm").html(),"tag");
	}
	
	
	
	/* 글 등록 화면 function */
	fn_createSource = function() {
		// html 만들기
		var vsHtml = $("#creationTable").html();
		//prompt로 우선 vsbusinessNm을 받는다
		var vsbusinessNm = prompt("업무명");
		//var vsbusinessNm = $("#businessNm").val();
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
		
		
	fn_call = function(){
		
		var info = {"header" : "불러오기",
				    "width"  : "700px",
				    "height" : "500px"
				    }
		robot.openPop(info, "", "view010101P01.jsp");
	}


</script>
</head>

<body>
	 <div id="nav">
	 	<ul class="nav-container">
	 		<li class="nav-item" onclick="fn_sourceReset();">새로만들기</li>
	 		<li class="nav-item" onclick="fn_sourceRollBack();">되돌리기</li>
	 		<li class="nav-item" onclick="fn_createSource();">저장</li>
	 		<li class="nav-item" onclick="">다른이름으로저장</li>
	 		<li class="nav-item" onclick="info();">상세보기</li>
	 		<li class="nav-item" onclick="fn_preview();">미리보기</li>
	 		<li class="nav-item" onclick="fn_call();">불러오기</li>
	 	</ul>
	 </div>
</body>
</html>























