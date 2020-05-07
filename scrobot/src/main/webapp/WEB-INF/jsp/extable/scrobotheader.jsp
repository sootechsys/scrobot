<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>scrobot_공통헤더</title>
<script src="https://code.jquery.com/jquery-latest.js"></script> 
 
<style>
	body{
		margin:0;
	}
	
	.nav-container {
		display:flex;
		flex-direction:row;
		width:100%;
		height:35px;
		margin:0;
		padding:0;
		background-color:lightsky;
		list-style-type:none;
		background-color:#97d5e0;
	}
	
	.nav-item {
		padding:5px;
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
<script type="text/javaScript">
	
	/* 2020.05.04
	id,class,name,label을 가져와 좌측바에 위치시킨다.
	*/
	function info() { 
		
		var vmObj = {
				"id" : $(".tableFocus").attr("id"),
				"class" : $(".tableFocus").attr("class"),
				"name" : $(".tableFocus").attr("name"),
				"label" : $(".tableFocus").attr("label"),
				"style" : $(".tableFocus").attr("style")
		};
		
		//console.log(vmObj);
		
		var keys = Object.keys(vmObj);
		
		//console.log(keys);
		
		var vsbuffer = "";
		//undefined check
		for(var i in keys){
			//테이블 상세보기 마다 초기화 
			$("tr[name=buffer"+i+"]").remove();
			
		//	console.log("key="+keys[i],"value="+vmObj[keys[i]]);
			
			if(typeof vmObj[keys[i]] == "undefined"){
				vmObj[keys[i]] = ""; 
			}
			
			vsbuffer +="<tr name=\"buffer"+i+"\">";
			vsbuffer +="<td>"+keys[i]+"</td>";
			vsbuffer +="<td><input type=\"text\" value=\""+vmObj[keys[i]]+"\"></input></td>";
			vsbuffer +="</tr>";
		}
			
		$("#propertyTable > tbody:last").append(vsbuffer);	
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
	function fn_sourceRollBack(){ 
		if(RollBack != null){
			RollBack.appendTo("#creationTable");
		}else{
			alert("되돌릴 테이터가 없습니다.");
		}
	}
	


</script>
</head>

<body>
	 <nav>
	 	<ul class="nav-container">
	 		<li class="nav-item" onclick="fn_sourceReset();">새로만들기</li>
	 		<li class="nav-item" onclick="fn_sourceRollBack();">되돌리기</li>
	 		<li class="nav-item" onclick="fn_createSource();">저장</li>
	 		<li class="nav-item" onclick="">다른이름으로저장</li>
	 		<li class="nav-item" onclick="info();">상세보기</li>
	 	</ul>
	 </nav>
</body>
</html>























