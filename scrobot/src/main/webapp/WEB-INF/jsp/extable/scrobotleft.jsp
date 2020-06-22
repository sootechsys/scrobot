<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>scrobot_공통사이드바</title>


<style>
/* 사이드바 스타일      */
.sidenav {
	height: 100%;
	position: fixed;
	z-index: 1;
	top: 0;
	left: 0;
	margin-top: 50px;
	background-color: #97d5e0;
	overflow-x: hidden;
	transition: 0.5s ease-in-out;
	width: 320px;
	/* padding-top: 60px; */
}

.sidenav tr {
	padding: 10px 10px 10px 10px;
	text-decoration: none;
	/* font-size: 25px; */
	color: #fff;
	display: block;
	transition: 0.2s ease-in-out;
}

.sidenav table {
	/* margin:auto; */
	width: 100%;
}

.sidenav table thead tr th {
	margin: auto;
}

.sidenav tbody {
	width: 80%;
}

.sidenav td {
	width: 50px;
	height: 20px;
}

.JCLRgrip {
	cursor: ew-resize;
}

/* 미디어쿼리 적용 */

/* #propertyTable{
	width:100%; 
	border: 1px solid #444444; 
	align: center;
	border-collapse: collapse;
	background-color: white;					
} */
#propertyTable tr {
	border: 1px solid #444444;
}
</style>
<script type="text/javaScript">




  
  // outline 제자리 복귀시 rownum
  vnSortNum = 0;
  
  // drop여부
  vsDropYn = "";
  
  vbTitleDragCheck = false;
  vbButtonDragCheck = false;
  vbInputBoxDragCheck = false;

  
  

  fn_creationTableResize = function(ui){
	  
	  var voChild = $("#creationTable").children();
		
		var vnTotalLeft = 0;
		var vnTotalTop = 0;
		for(var i=0; i<voChild.length; i++){
			if(voChild.eq(i).attr("id") != ""){
				var vnLeft = Number(voChild.eq(i).css("left").replace("px",""));
				var vnWidth = Number(voChild.eq(i).width());
				
				var vnTop = Number(voChild.eq(i).css("top").replace("px",""));
				var vnHeight = Number(voChild.eq(i).height());
				
				if(vnTotalLeft < vnLeft+vnWidth){
					vnTotalLeft = vnLeft+vnWidth;
				}
				
				if(vnTotalTop < vnTop+vnHeight){
					vnTotalTop = vnTop+vnHeight;
				}
			}
		}
		
		if(vnTotalLeft >  $("#creationForm").width()){
			var vsFormLeft = (ui.offset.left+500)+"px";
		  var vsTableLeft = (ui.offset.left+430)+"px";
	  	  $("#creationForm").css("width",vsFormLeft);
	  	  
	  	  $("#creationTable").css("width",vsTableLeft);
		}
		
		if(vnTotalTop+200 >  $("#creationForm").height()){
			var vsFormTop = (ui.offset.top+600)+"px";
		  var vsTableTop = (ui.offset.top+430)+"px";
	  	  $("#creationForm").css("height",vsFormTop);
	  	  
	  	  $("#creationTable").css("height",vsTableTop);
		}
	  
  }

 /**************************************
   * accordion 관련 함수
   **************************************/
    fn_draggable = function(){
	 
	 if($( ".div_content" ).length != 0){
		 $( ".div_content" ).draggable(
			{cursor: "move",
		     grid: [ 10, 10 ],
			 stop: function( event, ui ) {/* 1188 */
					  fn_creationTableResize(ui);
			}
		});
		 
		$( ".div_content" ).resizable();
	 }
	 
	 $( ".table" ).draggable({ cursor: "move",
			grid: [ 10, 10 ],
			stop: function( event, ui ) {/* 1188 */
				  fn_creationTableResize(ui);
		}
		}); 


  $( ".div_title" ).draggable({ cursor: "move",
  					    grid: [ 10, 10 ],
  					    stop: function( event, ui ){
  		                   vbTitleDragCheck = true;
  		                  fn_creationTableResize(ui);
  		   				}
  });
  
  $(".button").draggable({ cancel:false,
  			   cursor: "move",
  			   grid: [ 10, 10 ],
                stop: function( event, ui ){
  	               vbButtonDragCheck = true;
  	              fn_creationTableResize(ui);
  	   		}
  });
  
  $(".inputBox").draggable({ cancel:false,
  			   cursor: "move",
  			   grid: [ 10, 10 ],
  			   stop: function(event,ui){
  				  fn_creationTableResize(ui);
  			}
  });
  
  
  $(".selectBox").draggable({ cancel:false,
  				cursor: "move",
  				grid: [ 10, 10 ],
  				stop: function( event, ui ){
  					fn_creationTableResize(ui);
  				}
  });
  	  
  	  
  	  
  	$( "#creationTable" ).droppable({
        drop: function( event, ui ) {debugger;
        
        	vsDropYn = "Y";
	        if(ui.draggable.attr("compoDvs") != "div_content"){
	        		
	            var voContent = $(".div_content");
	            var vnContLength = voContent.length;
	            
	            // 부모 아이디
	            var vsParentId = ui.draggable.parent().attr("id");
	            
	         	// 부모 컴포넌트 종류
	            var vsParentCompoDvs = ui.draggable.parent().attr("compoDvs");
	            // 부모 클래스
	            var vsParentClass = ui.draggable.parent().attr("class");
	            
	            // 움직인곳의 세로높이
	            var vnCurrTop = Number(ui.draggable.css("top").replace("px",""));
	            
	         	// 움직인곳의 가로높이
	            var vnCurrLeft = Number(ui.draggable.css("left").replace("px",""));
	         	
	         	var vsDivYn = "N";
	        	var vnDivRow = 0;
	        	
	            if(vsParentClass != null){
	            	// 출발한 곳이 테이블이라면
	            	if(ui.draggable.parent().prop("tagName") == "TD"){
	            		// 출발한 div의 높이
		            	var vnOldParentTop = Number(ui.draggable.parent().offset().top);
		            	
		            	// 출발한 div의 폭
		            	var vnOldParentLeft = Number(ui.draggable.parent().offset().left);
		            	vnCurrTop += vnOldParentTop;
		            	vnCurrTop -= 76;
		            	vnCurrLeft += vnOldParentLeft;
		            	vnCurrLeft -= 337;
	            	}
	            	
	            	// 출발한 곳이 안이라면
	            	if(vsParentCompoDvs == "div_content"){
	            		// 출발한 div의 높이
		            	var vnOldParentTop = Number(ui.draggable.parent().css("top").replace("px",""));
		            	
		            	// 출발한 div의 폭
		            	var vnOldParentLeft = Number(ui.draggable.parent().css("left").replace("px",""));
		            	vnCurrTop += vnOldParentTop;
		            	vnCurrLeft += vnOldParentLeft;
		            	
		            	
		            	// div_content 개수 동안 반복
	    	         	for(var i=0; i<vnContLength; i++){
	    	         		var top = Number(voContent.eq(i).css("top").replace("px",""));
	                		var height = Number(voContent.eq(i).css("height").replace("px",""));
	                		var left = Number(voContent.eq(i).css("left").replace("px",""));
	                		var width = Number(voContent.eq(i).css("width").replace("px",""));
	                		
	                		// 도착한 곳이 div 안이라면(밖->안)
	    	                if(vnCurrTop < top+height && vnCurrTop > top-22 &&
	    	                   vnCurrLeft < left+width && vnCurrLeft > left-22){
	    	                	
	    	                	vsDivYn = "Y";
	    	                }
	                		
	        	            if(vsDivYn == "Y"){
	        	            	vnDivRow = i;
	        	            	break;
	        	            }
	    	         	}
		            	
		            
	            	}
	            	
	            	// 출발한 곳이 밖이라면	
	            	if(vsParentId == "creationTable"){
	            		// div_content 개수 동안 반복
	    	         	for(var i=0; i<vnContLength; i++){
	    	         		var top = Number(voContent.eq(i).css("top").replace("px",""));
	                		var height = Number(voContent.eq(i).css("height").replace("px",""));
	                		var left = Number(voContent.eq(i).css("left").replace("px",""));
	                		var width = Number(voContent.eq(i).css("width").replace("px",""));
	                		
	                		// 도착한 곳이 div 안이라면(밖->안)
	    	                if(vnCurrTop < top+height && vnCurrTop > top &&
	    	                   vnCurrLeft < left+width && vnCurrLeft > left){
	    	                	
	    	                	vsDivYn = "Y";
	    	                }
	                		
	        	            if(vsDivYn == "Y"){
	        	            	vnDivRow = i;
	        	            	break;
	        	            }
	    	         	}
	            		
	            	}
	            	
	            	
	            	
	            	
	            }

	         	
	         	ui.draggable.css("position","absolute");
	         	
	            // 출발한 곳이 밖이라면
	            if(vsParentId == "creationTable"){
	            	
	            	// 움직인곳이 div 안으로 이동했다면(밖->안)
	            	if(vsDivYn == "Y"){
	            		// 도착한 div의 높이
	        			var vnNewParentTop = Number(voContent.eq(vnDivRow).css("top").replace("px",""));
	        			// 도착한 div의 폭
	        			var vnNewParentLeft = Number(voContent.eq(vnDivRow).css("left").replace("px",""));
	        			
	        			ui.draggable.css("top",(vnCurrTop-vnNewParentTop-31)+"px")
            			ui.draggable.css("left",(vnCurrLeft-vnNewParentLeft-31)+"px")
            			
            			
            			voContent.eq(vnDivRow).append(ui.draggable);
            			
	            	// 움직인곳이 밖으로 이동했다면(밖->밖)
	            	} else{
	            		// 아무액션 필요없음
	            	}
	            
	            // 출발한 곳이 div 안일경우
	            } else{
	            	
            		// 도착한 곳이 div 안이라면(안->안)
	            	if(vsDivYn == "Y"){
	            		
	            		// 도착한 div의 높이
	        			var vnNewParentTop = Number(voContent.eq(vnDivRow).css("top").replace("px",""));
	        			// 도착한 div의 폭
	        			var vnNewParentLeft = Number(voContent.eq(vnDivRow).css("left").replace("px",""));
	        			
            			ui.draggable.css("top",(vnCurrTop-vnNewParentTop)+"px")
            			ui.draggable.css("left",(vnCurrLeft-vnNewParentLeft)+"px")
            			
            			voContent.eq(vnDivRow).append(ui.draggable);
	            	
	            	// 도착한 곳이 div 밖이라면(안->밖)
	            	} else{
	            		
	            		ui.draggable.css("top",(vnCurrTop+31)+"px")
	            		ui.draggable.css("left",(vnCurrLeft+31)+"px")
	            		$( this ).append(ui.draggable);
	            	}
	            	
	            }
	        }
        }
  	 });
  	
   	  $( ".table" ).resizable();
  	  
  
    $( "td" ).droppable({
        drop: function( event, ui ) {
        	var vsCompoDvs = ui.draggable.attr("compoDvs");
        	if(vsCompoDvs == "inputBox" || vsCompoDvs == "selectBox"){
        		ui.draggable.css("top","");
        		ui.draggable.css("left","");
        		ui.draggable.css("position","relative");
        		$(this).append(ui.draggable);
        	}
        
        }
    });
    
    $( "#sortable" ).on( "sortupdate", function( event, ui ) {} );
    
    };
	
	
	
	
	/* ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓ 그리기 이벤트 ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓ */
		
	
	
	
	/* DIV 만들기 */
	function divCreation() {
		onclick.draw("div");
	}
	/* TITLE 만들기 */
	function titleCreation() {
		
		onclick.draw("title");
	}
	
	/* button 만들기 */
	function buttonCreation() {
		onclick.draw("button");
	}
	
	/* 테이블그리기 */
	function tableCreation() {
		robot.prompt("행과 열의 갯수를 지정하십시오.", ["행","열"],"생성","취소","fn_tableCreationCallBack");
	}
	
	/* 테이블그리기 CallBack */
	fn_tableCreationCallBack = function(param) {
		onclick.draw("table",param);
	}
	
	/* input박스 그리기 */
	function inputCreation() {
		onclick.draw("input");
	}
	
	/* select박스 그리기 */
	function selectCreation() {
		onclick.draw("select");
	}
	
	/* ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑ 그리기 이벤트 ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑ */

	/* ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓ click 이벤트 ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓ */
	
	var shiftHold = 0;
	$(document).ready(function(){
		
		
		$("body").keydown(function(e){ // 키누를떄
			if(e.keyCode == 16){ //shift 
				shiftHold = 1;
			}
		
			if(e.keyCode == 46){
				var vsTdFocus = $(".tableFocus");
				var vnTdFocusLengh = vsTdFocus.length;
				if(vnTdFocusLengh != 0){ vsTdFocus.parent().parent().parent().remove(); }
				// 현재 포커스를 가지고있는 객체를 삭제한다.
				var voRightInfo = $("[orgId="+$("[focus=true]").attr("id")+"]");
				if(voRightInfo.attr("level") == "1"){ $("[parent="+voRightInfo.attr("id")+"]").remove(); voRightInfo.remove();}
				else{ voRightInfo.remove(); }
				$("[focus=true]").remove();
			}
		});
		
		$("body").keyup(function (e){ // 키뗄떼
			if(e.keyCode == 16){
				shiftHold = 0;
			}
		});
	});
	
	fn_creationClick = function(){
		
		
		if(shiftHold == 0){
			focusOut.All();
		}
		
	}
	
	
	
	
 	$(document).click(function(e){
		
 		fn_draggable();
		if(e.target.className != "tbtd_content"){
			onclick.focus(shiftHold,e);
		}
		
	});
	
	
	
	/* ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑ click 이벤트 ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑ */
	

	/* ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓ 더블클릭 이벤트 ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓ */
	fn_InputBoxOnDblClick = function(param){ //input
		//기능 구분되면 작성
	}
	
	fn_SelectBoxOnDblClick = function(param){ //select
		// 기능구분되면 작성
	}
	
	
	fn_titleOnDblClick = function(param){ // title
		
		robot.prompt("타이틀을 입력하시오",["타이틀"],"","","fn_titleOnDblClickCallBack");
	
		voPromptObject = param;
			
	}
	
	fn_titleOnDblClickCallBack = function(param){
		
		if(param == ""){
			voPromptObject = "";
			return false;
		}
		
		$(voPromptObject).parent().css("width","1000px");
		voPromptObject.textContent = param[0];
		var vnWidth = $(voPromptObject).css("width");
		$(voPromptObject).parent().css("width",vnWidth);
		
		voPromptObject = "";
	}
	
	/* 테이블 td 더블클릭 이벤트
	라벨 설정 */
    fn_tdDbClick = function(param) {
    	robot.prompt("라벨을 입력하시오",["라벨"],"","","fn_tdDbClickCallBack");
    	
    	voPromptObject = param;
    
    	
    }
    
    fn_tdDbClickCallBack = function(param){
    
    	if(param == ""){
			voPromptObject = "";
			return false;
		}
    	voPromptObject.textContent = param[0];
    	$(".tableFocus").attr("label",param[0]);
    	param.removeChild;
    	voPromptObject = "";
    
    voFocusTdInfo.className = "tbtd_content creationTd";
    	
    }
	
	
	fn_buttonOnDblClick = function(param){ //button
		robot.prompt("버튼명을 입력하시오",["버튼명"],"","","fn_buttonOnDblClickCallBack");
	
		voPromptObject = param;
		if(buttonNm != null && buttonNm != ""){
			$(param).val(buttonNm);
		}
	}
	
	fn_buttonOnDblClickCallBack = function(param){
		
		if(param == ""){
			voPromptObject = "";
			return false;
		}
		
		$(voPromptObject).val(param[0]);
		
		voPromptObject = "";
	}
	/* ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑ 더블클릭 이벤트 ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑ */
	
	
	

	/* ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓ TABLE 이벤트 ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓ */
	fn_colResize = function(){
		
		var onSampleResized = function(e){
			var table = $ (e.currentTarget);
		 };
		
			$ ("#table0").colResizable({
			 	liveDrag : true , 
			    gripInnerHtml : "<div class = 'grip'> </ div>" ,  
			    draggingClass : "dragging" ,  
			    onResize : onSampleResized
		  });
		}
	fn_tableColAddUp = function(){
		tableEdit.addUp();
	}
	
	fn_tableColAddDown = function(){
		tableEdit.addDown();
	}

	fn_deleter = function(){
		tableEdit.deleteNode();
	}

	fn_tableRowAddLeft = function(){
		tableEdit.addLeft();
	}

	fn_tableRowAddRight = function(){
		tableEdit.addRight();
	}

	fn_fn_tableRowDel = function(){
		tableEdit.RowDelete();
	}

	fn_tableMerge = function(){
		tableEdit.Merge();
	}

	fn_tableDivision = function(){
		tableEdit.Divide();
	}
	
	/* ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑ TABLE 이벤트 ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑ */
	
	
	/**********************************
	 수정  프로세스 
	***********************************/
	function infoUpdate(){
		
		var vsTrnum = $("#propertyTable tbody tr").length;
			vsTrnum --;
		
		var vmObj = {};
		//jsonArray에 변경정보 담기
		for(var i=0; i<vsTrnum; i++){
			var vsKey = $("tr[name=buffer"+i+"] > td:first").text();
			var vsValue = $("tr[name=buffer"+i+"] > td:last > input[type=text]").val();
			
			if(vsKey != null && vsValue != null){
				if(vsKey == "id"){
					vmObj["id"] = vsValue;	
				}
				if(vsKey == "class"){
					vmObj["class"] = vsValue;	
				}
				if(vsKey == "name"){
					vmObj["name"] = vsValue;	
				}
				if(vsKey == "label"){
					vmObj["label"] = vsValue;	
				}
				if(vsKey == "style"){
					vmObj["style"] = vsValue;	
				}
				if(vsKey == "value"){
					vmObj["value"] = vsValue;	
				}
			}
		}
		//key값 셋팅
		var keys = Object.keys(vmObj);
		
		//key와 value를 가져와 해당 component에 입력
		var check = $(".tableFocus").length;
		
		if(check == 0){
			var inputCheck = $(".inputBox[focus=true]").length;
			var selectCheck = $(".selectBox[focus=true]").length;
			var buttonCheck = $(".button[focus=true]").length;
			var titleCheck = $(".span_title[focus=true]").length;
			
			
			if(inputCheck != 0){
				for(var i in keys){
					$(".inputBox[focus=true]").attr(keys[i],vmObj[keys[i]]);
				}
			}
			else if(selectCheck != 0){
				for(var i in keys){
					$(".selectBox[focus=true]").attr(keys[i],vmObj[keys[i]]);
				}
			}
			else if(buttonCheck != 0){
				for(var i in keys){
					$(".button[focus=true]").attr(keys[i],vmObj[keys[i]]);
				}
			}
			else if(titleCheck != 0){
				for(var i in keys){
					$(".span_title[focus=true]").attr(keys[i],vmObj[keys[i]]);
				}
			}
		}
		else if(check !=0){
			for(var i in keys){
				$(".tableFocus").attr(keys[i],vmObj[keys[i]]);
			}
			//focus 된 td의 textContent 바꿔주기
			 $(".tableFocus").text(vmObj["label"]);
		}
		 
	}//수정 프로세스 end
	
		
	/**********************************
	 검색 프로세스 
	***********************************/
	function infoSearch(){
		//vsProperty == 검색어 
		var vsProperty = $("#Search").val();
		var vsTrnum = $("#propertyTable tbody tr").length;
			vsTrnum --;
		
		//반복문을 통해 td의 값(속성 키,값)을 가져와 JsonArray에 삽입
		var vmObj = {};
		
		for(var i=0; i<vsTrnum; i++){
			//vsKey == 속성키
			var vsKey = $("tr[name=buffer"+i+"] > td:first").text();
			var vsValue = $("tr[name=buffer"+i+"] > td:last > input[type=text]").val();
			if(vsKey != null && vsValue != null){
				if(vsKey == "id"){
					vmObj["id"] = vsValue;	
				}
				if(vsKey == "class"){
					vmObj["class"] = vsValue;	
				}
				if(vsKey == "name"){
					vmObj["name"] = vsValue;	
				}
				if(vsKey == "label"){
					vmObj["label"] = vsValue;	
				}
			}
		}	
		
		// vmObj의 key값만 저장
		var Keys = Object.keys(vmObj);
		
		// 키값으로 검색어 찾기 
		for(var j=0; j<Keys.length; j++){
			//입력값이 없을때 
			if(vsProperty == null){
				alert("검색어를 입력하세요");
				break;
			}
			// 입력값이 테이블에 있을때 
			if(Keys[j] == vsProperty){
				for(var k=0; k<vsTrnum; k++){	
					$("tr[name=buffer"+k+"]").hide();
				}
					$("tr[name=buffer"+j+"]").show();
				break;
			} 
			
		}		
	}//검색 프로세스 end

	
</script>

</head>

<body>
	<div id="mysidenav" class="sidenav">
		<!-- <div style="width: 500px; float: left;"> -->
		<table border="1" cellpadding="0" cellspacing="0"
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
					onclick="buttonCreation();">Button</td>
				<td class="tbtd_content" style="cursor: pointer"
					onclick="inputCreation();">Input Box</td>
				<td class="tbtd_content" style="cursor: pointer"
					onclick="selectCreation();">Select Box</td>
			</tr>

			<tr>
				<td class="tbtd_content" style="cursor: pointer"
					onclick="fn_tableColAddUp();">위로 행 추가</td>
				<td class="tbtd_content" style="cursor: pointer"
					onclick="fn_tableColAddDown();">아래 행 추가</td>
				<td class="tbtd_content" style="cursor: pointer"
					onclick="fn_deleter();">삭제</td>
			</tr>
			<tr>
				<td class="tbtd_content" style="cursor: pointer"
					onclick="fn_tableRowAddLeft();">좌측 열 추가</td>
				<td class="tbtd_content" style="cursor: pointer"
					onclick="fn_tableRowAddRight();">우측 열 추가</td>
			</tr>
			<tr>
				<td class="tbtd_content" style="cursor: pointer"
					onclick="fn_tableMerge();">병합</td>
				<td class="tbtd_content" style="cursor: pointer"
					onclick="fn_tableDivision();">분할</td>
			</tr>
		</table>
		<!-- </div> -->
		<table id="propertyTable" style="display: none;">
			<tr>
				<!-- 이거로 검색. -->
				<td><input type="text" id="Search"></input></td>
				<td><input type="button" onclick="infoSearch();" value="검색"></input>
				<td>
				<td><input type="button" onclick="infoUpdate();" value="수정"></input></td>
			</tr>
		</table>
	</div>

	<div style="width: 150px; float: right; display: none;">
		<ul id="sortable">
		</ul>
	</div>
</body>
</html>