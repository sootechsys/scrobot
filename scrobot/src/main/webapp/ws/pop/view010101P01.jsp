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
</style>


<script src="https://code.jquery.com/jquery-3.2.1.js"></script>

<script type="text/javaScript" language="javascript" defer="defer">

fn_retrieveWrk = function(){debugger;
	var vsWrkNm = $("#ibx_retrieveWrktype").value;


	var vjRetrieveInfo = {
			"wrkNm" : vsWrkNm
	}
	
	$.ajax({
		url : "/retrieveWrk.do",
		type : "POST",
		data : vjRetrieveInfo,
		success : function(data) {debugger;
			alert("완료");

		},
		error : function() {
		}
	})
}

</script>
</head>

<body>
 <div class="div_retrieve_terms">
 	<span> 업무명</span>
 	<input type="text" id="ibx_retrieveWrktype="></input>
 	<input id="" type="button" value="조회" onclick="fn_retrieveWrk()"></input>
 </div>
 <div class="div_retrieve_result">
 	<div class="div_grid">
 		<h4> 화면목록</h4>
 		<table>
 			<colgroup>
 				<col width="100"/>
 			</colgroup>
 			<thead>
 				<tr>
 					<th>업무명</th>
 				</tr>
 			</thead>
 				<tr>
 				</tr>
 			<tbody>
 			</tbody>
 		</table>
 	</div>
 	
 	<div class="div_detailGrid">
 		<h4> 화면변경 이력목록</h4>
 		<table>
 			<colgroup>
 				<col width="100"/>
 			</colgroup>
 			<thead>
 				<tr>
 					<th>업무명</th>
 					<th>저장일시</th>
 				</tr>
 			</thead>
 				<tr>
 				</tr>
 			<tbody>
 			</tbody>
 		</table>
 	</div>
 	
 </div>

 
 
</body>
</html>
