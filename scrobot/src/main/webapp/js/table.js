

tableEdit = {};



tableEdit.addUp = function(){
	var vsTableId = $(".tableFocus").parent().parent().parent().attr("id"); //현재 table
	var currentTrNum = $("#"+vsTableId+" > tbody > tr").length; // table tr길이
	var currentTdNum = $("#"+vsTableId+" > tbody > tr > td").length; 
	currentTdNum = currentTdNum / currentTrNum; // table td길이
	
	var vsFocusTrRow = $(".tableFocus").parent().attr("row"); //focus row
	var vsFocusTdShell = $(".tableFocus").attr("shell"); //focs td shell
	
	var buffer = "<tr name=\"tr\" row=\"\">";
	for(var i=0; i<currentTdNum; i++){
		buffer += "\n  <td class=\"tbtd_content creationTd\""
		buffer += "shell = \""+i+"\"";
		buffer += "style=\"height:30px; cursor:pointer\" "
		buffer += "compoDvs=\"td\" "
		buffer += "ondblclick=\"fn_tdDbClick(this)\"> "
		buffer += "</td>"
	}
	buffer += "\n </tr>";
	
	if(vsFocusTrRow ==0){ //가장 위 선택 시 
		$("#"+vsTableId+"> tbody > tr:first").before(buffer);
	}else if(vsFocusTrRow !=0){ // 다른곳 선택 시 
		for(var a=0; a<currentTdNum; a++){ // td갯수만큼 반복
			var rowSpan = $("#"+vsTableId+"> tbody > tr[row="+(vsFocusTrRow-1)+"] > td[shell="+a+"]").attr("rowSpan");// 각td마다 rowSpan을 가져온다
			if(typeof rowSpan != "undefined" || rowSpan != null){// rowSpan이 있으면
				viRowSpan = parseInt(rowSpan);
				viRowSpan += 1;
				$("#"+vsTableId+"> tbody > tr[row="+vsFocusTrRow-1+"] > td[shell="+a+"]").attr("rowSpan",viRowSpan);
			}
		}
		$("#"+vsTableId+"> tbody > tr[row="+vsFocusTrRow+"]").before(buffer);
	}
		
	
	//다 끝나고 나면 tr row 정비
	// row를 다시 1번부터 매겨줌
	var resetTrNum = $("#"+vsTableId+"> tbody > tr").length;
	for(var i=1; i<=resetTrNum; i++){
		$("#"+vsTableId+"> tbody > tr:nth-child("+i+")").attr("row",i-1);
		}
	
	
}



tableEdit.addDown = function(){
	var vsTableId = $(".tableFocus").parent().parent().parent().attr("id"); //현재 table
	var currentTrNum = $("#"+vsTableId+" > tbody > tr").length; // table tr길이
	var currentTdNum = $("#"+vsTableId+" > tbody > tr > td").length; 
	currentTdNum = currentTdNum / currentTrNum; // table td길이
	
	var vsFocusTrRow = $(".tableFocus").parent().attr("row"); //focus row
	var vsFocusTdShell = $(".tableFocus").attr("shell"); //focs td shell
	
	var buffer = "<tr name=\"tr\" row=\"\">";
	for(var i=0; i<currentTdNum; i++){
		buffer += "\n  <td class=\"tbtd_content creationTd\""
		buffer += "shell = \""+i+"\"";
		buffer += "style=\"height:30px; cursor:pointer\" "
		buffer += "compoDvs=\"td\" "
		buffer += "ondblclick=\"fn_tdDbClick(this)\"> "
		buffer += "</td>"
	}
	buffer += "\n </tr>";
	
	for(var a=0; a<currentTdNum; a++){ // td갯수만큼 반복
		
    	var rowSpan = $("#"+vsTableId+"> tbody > tr[row="+(vsFocusTrRow+1)+"] > td[shell="+a+"]").attr("rowSpan");// 각td마다 rowSpan을 가져온다
    	
    	if(typeof rowSpan != "undefined" || rowSpan != null){// rowSpan이 있으면
    		
    		viRowSpan = parseInt(rowSpan);
    		viRowSpan += 1;
    		$("#"+vsTableId+"> tbody > tr[row="+(vsFocusTrRow+1)+"] > td[shell="+a+"]").attr("rowspan",viRowSpan);
    	}
    }
    	$("#"+vsTableId+"> tbody > tr[row="+vsFocusTrRow+"]").after(buffer);
	
	//다 끝나고 나면 tr row 정비
	// row를 다시 1번부터 매겨줌
	var resetTrNum = $("#"+vsTableId+"> tbody > tr").length;
	for(var i=1; i<=resetTrNum; i++){
		$("#"+vsTableId+"> tbody > tr:nth-child("+i+")").attr("row",i-1);
		}
	
	
}




tableEdit.ColDelete = function(){
	var vsTableId = $(".tableFocus").parent().parent().parent().attr("id"); //현재 table
	var currentTrNum = $("#"+vsTableId+" > tbody > tr").length; // table tr길이
	var currentTdNum = $("#"+vsTableId+" > tbody > tr > td").length; 
	currentTdNum = currentTdNum / currentTrNum; // table td길이
	var vsFocusTrRow = $(".tableFocus").parent().attr("row");// focus tr row
	var vsFocusTdShell = $(".tableFocus").attr("shell"); //focs td shell
	
	
		
	for(var i=0; i<currentTdNum; i++){
		var rowSpan = $("#"+vsTableId+"> tbody > tr[row="+vsFocusTrRow+"] > td[shell="+i+"]").attr("rowspan");// 각td마다 rowSpan을 가져온다	
		if(typeof rowSpan != "undefined" || rowSpan != null){ // rowSpan 있을떄
			var viRowSpan = parseInt(rowSpan);	
			
			var buffer = "<td class=\"tbtd_content creationTd\""
				buffer += "shell = \""+i+"\"";
				buffer += "style=\"height:30px; cursor:pointer\" "
				buffer += "compoDvs=\"td\" "
				buffer += "ondblclick=\"fn_tdDbClick(this)\"> "
				buffer += "</td>"
		
			$("#"+vsTableId+"> tbody > tr[row="+vsFocusTrRow+"]").remove();
				
			for(var j=1; j<viRowSpan; j++){
				$("#"+vsTableId+"> tbody > tr[row="+(vsFocusTrRow+j)+"] > td[shell="+i+"]").after(buffer);
			}
			
		}
		else if(typeof rowSpan == "undefined" || rowSpan == null){ //rowSpan 없을떄
			$("#"+vsTableId+"> tbody > tr[row="+vsFocusTrRow+"]").remove();
		}
		
		//다 끝나고 나면 tr row 정비
		// row를 다시 1번부터 매겨줌
		var resetTrNum = $("#"+vsTableId+"> tbody > tr").length;
		for(var i=1; i<=resetTrNum; i++){
			$("#"+vsTableId+"> tbody > tr:nth-child("+i+")").attr("row",i-1);
			}
}
}


tableEdit.addLeft = function(){
	var vsTableId = $(".tableFocus").parent().parent().parent().attr("id"); //현재 table
	var currentTrNum = $("#"+vsTableId+" > tbody > tr").length; // table tr길이
	var currentTdNum = $("#"+vsTableId+" > tbody > tr > td").length; 
	currentTdNum = currentTdNum / currentTrNum; // table td길이
	
	var vsFocusTrRow = $(".tableFocus").parent().attr("row"); //focus row
	var vsFocusTdShell = $(".tableFocus").attr("shell"); //focs td shell
	
	// 각 라인에 td 하나씩 넣어야한다.
	var buffer = "";
		buffer += "\n  <td class=\"tbtd_content creationTd\"";
		buffer += "shell = \""+vsFocusTdShell+"\"";
		buffer += "style=\"height:30px; cursor:pointer\" ";
		buffer += "compoDvs=\"td\" ";
		buffer += "ondblclick=\"fn_tdDbClick(this)\"> ";
		buffer += "</td>";
		
	for(var i=0; i<currentTrNum; i++){
		$("#"+vsTableId+"> tbody > tr[row="+i+"] > td[shell="+vsFocusTdShell+"]").before(buffer);
	}
	
	var resetTdNum = $("#"+vsTableId+"> tbody > tr > td").length;
	for(var i=0; i<currentTrNum; i++){
		for(var j=1; j<=resetTdNum; j++){
			$("#"+vsTableId+"> tbody > tr[row="+i+"] > td:nth-child("+j+")").attr("shell",j-1);
		}
	}
}



tableEdit.addRight = function(){
	var vsTableId = $(".tableFocus").parent().parent().parent().attr("id"); //현재 table
	var currentTrNum = $("#"+vsTableId+" > tbody > tr").length; // table tr길이
	var currentTdNum = $("#"+vsTableId+" > tbody > tr > td").length; 
	currentTdNum = currentTdNum / currentTrNum; // table td길이
	
	var vsFocusTrRow = $(".tableFocus").parent().attr("row"); //focus row
	var vsFocusTdShell = $(".tableFocus").attr("shell"); //focs td shell
	
	
	var buffer = "";
	buffer += "\n  <td class=\"tbtd_content creationTd\"";
	buffer += "shell = \""+vsFocusTdShell+"\"";
	buffer += "style=\"height:30px; cursor:pointer\" ";
	buffer += "compoDvs=\"td\" ";
	buffer += "ondblclick=\"fn_tdDbClick(this)\"> ";
	buffer += "</td>";

	for(var i=0; i<currentTrNum; i++){
		var ColCheck = $("#"+vsTableId+"> tbody > tr[row="+i+"] > td[shell="+vsFocusTdShell+"]").attr("colSpan");
		var RowCheck = $("#"+vsTableId+"> tbody > tr[row="+i+"] > td[shell="+vsFocusTdShell+"]").attr("rowSpan");
		
		if(typeof ColCheck == "undefined" || ColCheck == null){
			// colSpan이 없다는 것 따라서 추가바로 하면 된다.
			$("#"+vsTableId+"> tbody > tr[row="+i+"] > td[shell="+vsFocusTdShell+"]").after(buffer);
		}
		else if(ColCheck >= 2){
				var viColCheck = parseInt(ColCheck);
				viColCheck += 1;
				$("#"+vsTableId+"> tbody > tr[row="+i+"] > td[shell="+vsFocusTdShell+"]").attr("colSpan",viColCheck);
				
				if(typeof RowCheck != "undefined" || RowCheck != null){
					var viRowCheck = parseInt(RowCheck);
					viRowCheck -=1;
					i += viRowCheck;
				}
				
		}
			
	}
	
	var resetTdNum = $("#"+vsTableId+"> tbody > tr > td").length;
	for(var i=0; i<currentTrNum; i++){
		for(var j=1; j<=resetTdNum; j++){
			$("#"+vsTableId+"> tbody > tr[row="+i+"] > td:nth-child("+j+")").attr("shell",j-1);
		}
	}
}



tableEdit.RowDelete = function(){
	var vsTableId = $(".tableFocus").parent().parent().parent().attr("id"); //현재 table
	var currentTrNum = $("#"+vsTableId+" > tbody > tr").length; // table tr길이
	var currentTdNum = $("#"+vsTableId+" > tbody > tr > td").length; 
	currentTdNum = currentTdNum / currentTrNum; // table td길이
	var vsFocusTrRow = $(".tableFocus").parent().attr("row");// focus tr row
	var vsFocusTdShell = $(".tableFocus").attr("shell"); //focs td shell
	var delCount = 0;
	//각 tr마다 focus 된 라인이 colSpan 범위에 들어가는지 파악 후 colSpan -1을 할지 셀을 지울지 결정한다. 단 -1하면 hide된 셀도 지워야함
	for(var i=0; i<currentTrNum; i++){
		var Check = $("#"+vsTableId+" > tbody > tr[row="+i+"] > td[shell="+vsFocusTdShell+"]").attr("colSpan");
		
		if(typeof Check == "undefined" || Check == null){ //스스로 colSpan 가지지 않을때
			
			for(var j=0; j<currentTdNum; j++){ // 1. colSpan 가질때 - focus가 포함될때 안될떄 /안가질때 - focs셀일때
				var ColCheck = $("#"+vsTableId+" > tbody > tr[row="+i+"] > td[shell="+j+"]").attr("colSpan");	
				
				if(typeof ColCheck == "undefined" || ColCheck == null){ // colSpan 안가질때
					if(j == vsFocusTdShell){
						$("#"+vsTableId+" > tbody > tr[row="+i+"] > td[shell="+j+"]").remove();
						break;
					}
					else if(j != vsFocusTdShell){
						continue;
					}
				}
				else if(typeof ColCheck != "undefined" || ColCheck != null){ // colSpan 가질때
					var viColCheck = parseInt(ColCheck);
					viColCheck += j;
					viColCheck -= 1;
					if(viColCheck >= vsFocusTdShell){ // col이 2이면 아예삭제해야함
						var colSpan = parseInt(ColCheck);
						if(colSpan > 2){
							colSpan -= 1;
							$("#"+vsTableId+" > tbody > tr[row="+i+"] > td[shell="+j+"]").attr("colSpan",colSpan);
							$("#"+vsTableId+" > tbody > tr[row="+i+"] > td[shell="+vsFocusTdShell+"]").remove();
							break;
						}
						else if(colSpan <= 2){
							$("#"+vsTableId+" > tbody > tr[row="+i+"] > td[shell="+j+"]").removeAttr("colSpan");
							$("#"+vsTableId+" > tbody > tr[row="+i+"] > td[shell="+vsFocusTdShell+"]").remove();
							break;
						}
					}
					else if(viColCheck < vsFocusTdShell){
						continue;
					}
				}
				
			}
			
		}
		else if(typeof Check != "undefined" || Check != null){ // 스스로 colSpan 가질떄
			for(var j=vsFocusTdShell; j<Check+vsFocusTdShell; j++){
				 $("#"+vsTableId+" > tbody > tr[row="+i+"] > td[shell="+j+"]").show();
			}
			 $("#"+vsTableId+" > tbody > tr[row="+i+"] > td[shell="+vsFocusTdShell+"]").remove();
		}
	}
	
	var resetTdNum = $("#"+vsTableId+"> tbody > tr > td").length;
	for(var i=0; i<currentTrNum; i++){
		for(var j=1; j<=resetTdNum; j++){
			$("#"+vsTableId+"> tbody > tr[row="+i+"] > td:nth-child("+j+")").attr("shell",j-1);
		}
	}
}



tableEdit.Merge = function(){
	var vsTableId = $(".tableFocus").parent().parent().parent().attr("id"); // 테이블 아이디
	var currentTrNum = $("#"+vsTableId+" > tbody > tr").length; //현재 tr 갯수
	var currentTdNum = $("#"+vsTableId+" > tbody > tr > td").length; 
	currentTdNum = currentTdNum / currentTrNum; //현재 td 갯수
	
	//rowSpan 탐색
	var vsRow = new Array(currentTdNum);
		for(var i=0; i<currentTrNum; i++){
			vsRow[i] = new Array(currentTrNum);
		}

	for(var i=0; i<currentTrNum; i++){//tr갯수만큼 반복
		var viTdLength = $("#"+vsTableId+" > tbody > tr[row="+i+"] > td").length;
		for(var j=0; j<currentTdNum; j++){//td갯수만큼 반복
			var rowSpan = $("#"+vsTableId+" > tbody >  tr[row="+i+"]  > td[shell="+j+"]").attr("rowspan");
				if(typeof rowSpan != "undefined" || rowSpan != null){
					vsRow[i][j] = rowSpan;
				}
				else{
					vsRow[i][j] = 1;
				}
		}
	}
	

	
	//colSpan 탐색
	var vsCol = new Array(currentTdNum);
		for(var i=0; i<currentTrNum; i++){
			vsCol[i] = new Array(currentTrNum);
		}
		
	for(var i=0; i<currentTrNum; i++){//tr갯수만큼 반복
		var viTdLength = $("#"+vsTableId+" > tbody > tr[row="+i+"] > td").length;
		for(var j=0; j<currentTdNum; j++){//td갯수만큼 반복
			var colSpan = $("#"+vsTableId+" > tbody >  tr[row="+i+"]  > td[shell="+j+"]").attr("colspan");
				if(typeof colSpan != "undefined" || colSpan != null){
					vsCol[i][j] = colSpan;
				}
				else{
					vsCol[i][j] = 1;
				}
		}	
	}
	
	
	//text 탐색
	var vsText = new Array(currentTdNum);
		for(var i=0; i<currentTrNum; i++){
			vsText[i] = new Array(currentTrNum);
		}
		
	for(var i=0; i<currentTrNum; i++){
		for(var j=0; j<currentTdNum; j++){
			vsText[i][j] = $("#"+vsTableId+"> tbody > tr[row="+i+"] > td[shell="+j+"]").text();
		}
	}
	
	
	
	//row / col 세이브
	var vsTotal = new Array(currentTdNum);
	for(var i=0; i<currentTrNum; i++){
		vsTotal[i] = new Array(currentTrNum);
	}
	
	for(var i=0; i<currentTrNum; i++){
		for(var j=0; j<currentTdNum; j++){
			var rowSpan = vsRow[i][j];
			var colSpan = vsCol[i][j];
			// 분기처리 - 1. xx 2. xy 3. yx 4. yy
			// 1. xx 둘다 없다
			if(rowSpan == "1" && colSpan == "1"){
				if(vsTotal[i][j]=="c0" || vsTotal[i][j]=="r0"){ // row&col에 먹힌거면
					continue;
				}else{
					vsTotal[i][j] = "1";
				}
			}
			// 2. row는 있고 col은 없다
			else if(rowSpan != "1" && colSpan == "1"){
				var virowSpan = parseInt(rowSpan);
				for (var a=1; a<virowSpan; a++){
					if(i+a > currentTrNum){
						break;
					}
					vsTotal[i+a][j] = "r0";
					vsTotal[i][j] = "r"+rowSpan;
				}
			}
			// 3. row는 없고 col은 있다
			else if(rowSpan == "1" && colSpan != "1"){
				var viColSpan = parseInt(colSpan);
				for (var a=1; a<viColSpan; a++){
					if(j+a > currentTdNum){
						break;
					}
					vsTotal[i][j+a] = "c0";
					vsTotal[i][j] = "c"+colSpan;
				}
			}
			// 4. yy 둘다 있다 i=tr j=td
			else if(rowSpan != "1" && colSpan != "1"){
				var virowSpan = parseInt(rowSpan);
				var viColSpan = parseInt(colSpan);
				for (var a=i; a<virowSpan+i; a++){
					for(var b=j; b<viColSpan+j; b++){
						if(a == i && b == j){
							vsTotal[a][b]= rowSpan+":"+colSpan;
						}else if(a == i){
							vsTotal[a][b]="c0";
						}else if(a!=i){
							vsTotal[a][b]="r0";
						}
					}
				}
			}
		}
	}
	
	// ↑↑↑↑↑↑↑↑↑↑↑↑↑↑ 상단까지 배열로 col / row 가져오기 실시함 / text ↑↑↑↑↑↑↑↑↑↑↑↑↑↑
		
	// focus 된 td들의 위치를 정확히 파악해서 그곳에다가 attr해줌. 0인경우 remove(); || hide(); 
	var vsTalbeFocus = new Array(currentTdNum);
	for(var i=0; i<currentTrNum; i++){
		vsTalbeFocus[i] = new Array(currentTrNum);
	}
	
	for(var i=0; i<currentTrNum; i++){
		for(var j=0; j<currentTdNum; j++){
			vsTalbeFocus[i][j] = $("#"+vsTableId+"> tbody > tr[row="+i+"] > td[shell="+j+"]").attr("class");
		}
	}

	
	
	var tableFocusRowNumber = $(".tableFocus").parent().attr("row");
	var stub = parseInt(tableFocusRowNumber);
	var tableFocusShellNumber = $(".tableFocus").attr("shell"); //tablefocus 좌상단
	var stub2 = parseInt(tableFocusShellNumber);
	
	var Span = [];
	
	//rowSpan의 갯수는 각 tr당 r이 속해있는 것 중 
	
	var inputRowSpan = 0; // 최종 row
	var inputColSpan = 0; // 최종 col
	for(var i=0; i<currentTrNum; i++){
		for(var j=0; j<currentTdNum; j++){
			var check = vsTotal[i][j];
			var classCheck = vsTalbeFocus[i][j];
			// 유형 = tf-c / tf-r / tf-cr / tf-1 / tf-0
			if(typeof Span[i] == "undefined" && Span[i] == null){
				Span[i]=0;
			}
			if(classCheck == "tableFocus"){
				if(check.indexOf(":") != -1){ // tf-cr
					var vaCheck = check.split(":");
					var viRNum = parseInt(vaCheck[0]);
					var viCNum = parseInt(vaCheck[1]);
					var colSize = Span[i];
					Span[i] = colSize+viCNum;
				}
				else if(check.indexOf("c") != -1){
					var viStup2 = parseInt(check.replace("c",""));
					var colSize = Span[i];
					Span[i] = colSize+viStup2;
				}
				else if(check.indexOf("r") != -1){
					var colSize = Span[i];
					Span[i] = colSize+1;					
				}
				else if(check == "1"){
					var colSize = Span[i];
					Span[i] = colSize+1;
				}
			}

		}
	}
	
	
	inputColSpan = Span[stub]; //colSpan 길이
	
	//rowSpan 길이
	var viFocusRow = new Array(currentTdNum);
	for(var i=0; i<currentTrNum; i++){
		viFocusRow[i] = new Array(currentTrNum);
	}
	
	
	for(var i=0; i<currentTrNum; i++){
		for(var j=0; j<currentTdNum; j++){
			var check = vsTotal[i][j];
			var classCheck = vsTalbeFocus[i][j];
			if(classCheck == "tableFocus"){
				if(check.indexOf(":") != -1){
					var vaCheck = check.split(":");
					var viRNum = parseInt(vaCheck[0]);
					viFocusRow[i][j] = viRNum;
				}
				else if(check.indexOf("r") != -1){
					var viStup1 = parseInt(check.replace("r",""));
					var viRNum = parseInt(viStup1);
					viFocusRow[i][j] = viRNum;
					
				}
				else if(check.indexOf("c") != -1){
					viFocusRow[i][j] = 1;
				}
				else if(check == 1){
					viFocusRow[i][j] = 1;
				}
			}
			else if(classCheck != "tableFocus"){
				viFocusRow[i][j] = 0;
			}
			
		}
	}
	
	var total = [];
	for(var i=0; i<currentTdNum; i++){
		for(var j=0; j<currentTrNum; j++){
			var adder = viFocusRow[j][i];
			if(typeof total[i] =="undefined"){
				total[i]=0;
			}
			if(adder == 0){
				continue;
			}
			else if(adder != 0){
				var current = total[i];
				total[i] = current + adder;
			}
		}
	}
	
	// inputRowSpan에 값 설정.
	for(var i=0; i<total.length; i++){
		var check = total[i];
		if(inputRowSpan <= check){
			inputRowSpan = check;
		}		
	}

	
	
	

		
		//col row 재분배함
		// 좌측 상단에만 줘야함, 나머지는 0으로 바꿔줘야함.
		var first=0;
		for(var i=0; i<currentTrNum; i++){
			for(var j=0; j<currentTdNum; j++){
				var check = vsTotal[i][j];
				var classCheck = vsTalbeFocus[i][j];
				
				if(classCheck == "tableFocus"){
					if(check != "0"){
						if(first == 0){
							first += 1;
							if(inputRowSpan > 1 && inputColSpan > 1){ // r:c
								// 여기서 줄인다..?
								for(var a=stub; a<inputRowSpan+stub; a++){
									for(var b=stub2; b<inputColSpan+stub2; b++){
										if(a == stub && b == stub2){
											continue;
										}
										
										if(a == stub){
											vsTotal[a][b] = "c0";
										}
										else if(a != stub){
											vsTotal[a][b] = "r0";
										}
										
									}
								}
								vsTotal[i][j] = inputRowSpan.toString()+":"+inputColSpan.toString();	
							}
							else if(inputRowSpan > 1 && inputColSpan <= 1){ // r
								for(var a=stub; a<inputRowSpan+stub; a++){
									if(a == stub){
										continue;
									}
									vsTotal[a][j] = "r0"
								}
								vsTotal[i][j] = "r"+ inputRowSpan.toString()
							}
							else if(inputRowSpan <= 1 && inputColSpan > 1){ // c
								for(var b=stub2; b<inputColSpan+stub2; b++){
									if(b == stub2){
										continue;
									}
									vsTotal[i][b] = "c0"
								}
								vsTotal[i][j] = "c"+inputColSpan.toString();
							}
							else if(inputRowSpan <= 1 && inputColSpan <= 1){ // 없
								robot.alert("하나만 선택하면 안되요");
							}
						}
					}
				}
			}
		}
		
		
		for(var i=0; i<currentTrNum; i++){
			for(var j=0; j<currentTdNum; j++){
				var InputSpan = vsTotal[i][j];
				// 0 / 1 / c / r / r:c
				if(InputSpan == "c0" || InputSpan == "r0" ){ //포함되는 셀 hide();
					$("#"+vsTableId+"> tbody > tr[row="+i+"] > td[shell="+j+"]").hide(); // h
				} 
				else if(InputSpan == "1"){
					$("#"+vsTableId+"> tbody > tr[row="+i+"] > td[shell="+j+"]").show();
				}
				else if(InputSpan.indexOf(":") != -1){ // row:col // row나 col이 0일 수 있음 분기처리.
					var vaCheck = InputSpan.split(":");
					var vsRNum = vaCheck[0];
					var vsCNum = vaCheck[1];
					var viRNum = vsRNum.replace("r",""); //r 값
					var viCNum = vsCNum.replace("c",""); //c 값
					
					if(viRNum == "0" && viCNum != "0"){
						$("#"+vsTableId+"> tbody > tr[row="+i+"] > td[shell="+j+"]").attr("colspan",viCNum);
					}
					else if(viCNum == "0" && viRNum != "0"){
						$("#"+vsTableId+"> tbody > tr[row="+i+"] > td[shell="+j+"]").attr("rowspan",viRNum);
					}
					else if(viCNum != "0" && viRNum != "0"){
						$("#"+vsTableId+"> tbody > tr[row="+i+"] > td[shell="+j+"]").attr("colspan",viCNum);
						$("#"+vsTableId+"> tbody > tr[row="+i+"] > td[shell="+j+"]").attr("rowspan",viRNum);
					}
				}
				else if(InputSpan.indexOf("c") != -1){ // col
					var viStup2 = parseInt(InputSpan.replace("c",""));
					$("#"+vsTableId+"> tbody > tr[row="+i+"] > td[shell="+j+"]").attr("colspan",viStup2);
				}
				else if(InputSpan.indexOf("r") != -1){ // row
					var viStup1 = parseInt(InputSpan.replace("r",""));
					$("#"+vsTableId+"> tbody > tr[row="+i+"] > td[shell="+j+"]").attr("rowspan",viStup1);
				}
			}
		}
}



tableEdit.Divide = function(){
	var vsTableId = $(".tableFocus").parent().parent().parent().attr("id");
	var focusTr = parseInt($(".tableFocus").parent().attr("row"));
	var focusTd = parseInt($(".tableFocus").attr("shell"));
	var currentTrNum = $("#"+vsTableId+" > tbody > tr").length; // table tr길이
	var currentTdNum = $("#"+vsTableId+" > tbody > tr > td").length; 
	currentTdNum = currentTdNum / currentTrNum; 
	
	 var checkColSpan = $(".tableFocus").attr("colspan");
	 	if(typeof checkColSpan == "undefined"){
	 		checkColSpan = 0;
	 	}
	 var focusShellCol = parseInt(checkColSpan);
	 
	 var checkRowSpan = $(".tableFocus").attr("rowspan");
	 	if(typeof checkRowSpan == "undefined"){
	 		checkRowSpan = 0;
	 	}
	 var focusShellRow = parseInt(checkRowSpan);
	 
	 if(focusShellCol == 0 && focusShellRow != 0){// col이 없을떄
		$("#"+vsTableId+"> tbody > tr[row="+focusTr+"] > td[shell="+focusTd+"]").removeAttr("rowSpan");
		
	 	for(var a=focusTr+1; a<focusTr+focusShellRow; a++){
			$("#"+vsTableId+"> tbody > tr[row="+a+"] > td[shell="+focusTd+"]").show();
		}
	 }
	 else if(focusShellCol != 0 && focusShellRow == 0){ // row가 없을때
		 $("#"+vsTableId+"> tbody > tr[row="+focusTr+"] > td[shell="+focusTd+"]").removeAttr("colSpan");

		 for(var a=focusTd+1; a<focusTd+focusShellCol; a++){
			$("#"+vsTableId+"> tbody > tr[row="+focusTr+"] > td[shell="+a+"]").show();
		}
	 }
	 else if(focusShellCol != 0 && focusShellRow != 0){ // 둘다 있으면
		 $("#"+vsTableId+"> tbody > tr[row="+focusTr+"] > td[shell="+focusTd+"]").removeAttr("rowSpan");
		 $("#"+vsTableId+"> tbody > tr[row="+focusTr+"] > td[shell="+focusTd+"]").removeAttr("colSpan");
		 
		 for(var a=focusTr; a<focusTr+focusShellRow; a++){
			 for(var b=focusTd; b<focusTd+focusShellCol; b++){
				 if(a==focusTr && b==focusTd){
					 continue;
				 }
				 else{
					 $("#"+vsTableId+"> tbody > tr[row="+a+"] > td[shell="+b+"]").show();
				 }
			 }
		 }
	 }
	 else if(focusShellCol == 0 && focusShellRow == 0){ 			
	}
}
