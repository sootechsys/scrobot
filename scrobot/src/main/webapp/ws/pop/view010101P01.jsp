<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>

<style>
.div_grid{
	float:left;
	width:300px;
	height:400px;
	text-align: left;
}
.div_detailGrid{
	float:left;
	width:300px;
	height:400px;
	text-align: left;
}
.div_retrieve_result{
	margin-top:50px;
}

tr[focus=true]{
	border: 2px solid black !important;
	background: skyblue;
}

</style>


<script src="https://code.jquery.com/jquery-3.2.1.js"></script>

<script type="text/javaScript" language="javascript" defer="defer">




fn_retrieveWrk = function(){
	var vsWrkNm = $("#ibx_retrieveWrktype").val();


	var vjRetrieveInfo = {
			"wrkNm" : vsWrkNm
	}
	
	$.ajax({
		url : "/retrieveWrk.ajax",
		type : "POST",
		data : vjRetrieveInfo,
		success : function(data) {debugger;
			var nameList = data.resultMap.wrkList;
			var historyList = data.resultMap.wrkHistryList;
			var buffer = "";	
			for(var i=0; i<nameList.length; i++){
				buffer += "<tr>"
				buffer += "<td>"+data.resultMap.wrkList[i].wrkNm+"</td>"
				buffer += "</tr>"
			}
			
			var buffer2 ="";
			for(var i=0; i<historyList.length; i++){
				buffer2 +="<tr class=\"tr"+i+"\" onclick =\"fn_wrkHistryStyle(this)\" focus=\"false\" >"
				buffer2 +="<td ondblclick=\"fn_dblwrkHistryPrompt(this)\">"+data.resultMap.wrkHistryList[i].wrkNm+"</td>"
				buffer2 +="<td ondblclick=\"fn_dblwrkHistryPrompt(this)\">"+data.resultMap.wrkHistryList[i].chngHistryDttm+"</td>"
				
				buffer2 += "</tr>"
			}
			
			
			$("#viewList > tbody > tr").remove();
			
			$("#viewList > tbody").append(buffer);
			
			$("#viewUpdateList > tbody > tr").remove();
			
			$("#viewUpdateList > tbody").append(buffer2);

		},
		error : function() {
		}
	})
}

fn_wrkHistryStyle = function(param){
	var focusCheck = $("#viewUpdateList > tbody > tr[focus=true]").length; //포커스갯수
	
	if(focusCheck == 0){ // 0개면 바로 true
		var trClass = param.className;
		$("."+trClass).attr("focus",true);
	}
	else if(focusCheck != 0){ // 0 이상이면
		
		var trLength = $("#viewUpdateList > tbody > tr").length; // tr길이
		
		for(var i=0; i<trLength; i++){ //일단 포커스 다지움.
			var focus = $("#viewUpdateList > tbody > tr[class=tr"+i+"]").attr("focus"); // focus 확인
			if(focus){ //true일때
				$("#viewUpdateList > tbody > tr[class=tr"+i+"]").attr("focus",false); // focus 삭제
			}
		}
		
		var trClass = param.className;
		$("."+trClass).attr("focus",true);
		
	}

}


fn_dblwrkHistryPrompt = function(param){
	debugger;
	var YnCheck = confirm("해당 파일을 적용하시겠습니까?.");
	debugger;
	if(YnCheck == true){
		var WrkNmTd = param.parentElement.firstChild.textContent; // 업무명
		var ChngHistryDttmTd = param.parentElement.lastChild.textContent; // 저장일시
		var vjRetrieveInfoDetail = {
				"wrkNm" : WrkNmTd,
				"chngHistryDttm" : ChngHistryDttmTd
		}
		
		$.ajax({
			url : "/retrieveWrkDetail.ajax",
			type : "POST",
			data : vjRetrieveInfoDetail,
			success : function(data){ debugger;
				
				console.log(data);
				
				var wrkNm = data.eList[0].wrkNm;
				var Source = data.eList[0].source;
				
				$("#creationTable").empty();
				
				$("#creationTable").append(Source);
					
				robot.closePop();
			
			},error : function(){
				alert("확인되지 않습니다");
			}
		})
	}
	else if(YnCheck == false){
		
	}
}


</script>
</head>

<body>
 <div class="div_retrieve_terms">
 	<span> 업무명</span>
 	<input type="text" id="ibx_retrieveWrktype"></input>
 	<input id="" type="button" value="조회" onclick="fn_retrieveWrk()"></input>
 </div>
 <div class="div_retrieve_result">
 	<div class="div_grid">
 		<h4> 화면목록</h4>
 		<table id="viewList">
 			<colgroup>
 				<col width="100"/>
 			</colgroup>
 			<thead>
 				<tr>
 					<th>업무명</th>
 				</tr>
 			</thead>
 			<tbody>
 			</tbody>
 		</table>
 	</div>
 	
 	<div class="div_detailGrid">
 		<h4> 화면변경 이력목록</h4>
 		<table id="viewUpdateList">
 			<colgroup>
 				<col width="100"/>
 			</colgroup>
 			<thead>
 				<tr>
 					<th>업무명</th>
 					<th>저장일시</th>
 				</tr>
 			</thead>
 			<tbody>
 			</tbody>
 		</table>
 	</div>
 	
 </div>

 
 
</body>
</html>
