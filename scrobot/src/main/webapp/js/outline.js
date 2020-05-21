	
	
	/************************************* 
     * outline 그리기 함수
     **************************************/
	fn_rightDraw = function(){
		var vsBasicSource = "<li class=\"ui-state-default\" "; 
		var vsRightSource = "";
		
		// 컴포넌트 그리는 div자식들 가져온다.
		var voChild = $("#creationTable").children();
		var vnChildCount = voChild.length;
		
		// div_content가 1개이상이라면
		if(vnChildCount != 0){
			for(var a=0; a<vnChildCount; a++){
				var voSortableChild = $("#sortable").children();
				var vnSortableChildCount = voSortableChild.length;
				
				var vsTagNm = voChild.eq(a).prop("tagName");
				var vsTagId = voChild.eq(a).prop("id");
				var vsTagInfo = vsTagNm + "_" + vsTagId;
				
				vsRightSource =  vsBasicSource + "id = \""+vsTagInfo + "\"";
				vsRightSource += " orgId=\""+vsTagId+"\"";
				vsRightSource += " level=\"1\"";
				vsRightSource += ">";
				vsRightSource +=  vsTagInfo + "</li>"
				
				var vnoverlapCount = 0;
				
				//outline에 1개이상 있다면
				if(vnSortableChildCount != 0){
					
					// 컴포넌트가 outline에 이미 존재하는지 체크
					for(var b=0; b<vnSortableChildCount; b++){
						if(voSortableChild.eq(b).text() == vsTagInfo){
							vnoverlapCount++;
							
						}
					}
					
					// 존재하지 않다면 outline에 추가
					if(vnoverlapCount == 0){
						$("#sortable").append(vsRightSource);
					}
			    // outline에 컴포넌트가 0개라면 바로 outline 추가
				} else{
					$("#sortable").append(vsRightSource);
				}
				
				
				// 버튼div, 타이틀div, 테이블div 등등 손자를 그리기위하여 포커스잡힌 div를 가져옴
				var voFocusDiv = $("[mainFocus=true]");
				var voChild2 = voFocusDiv.children();
				
				vsTagNm = voFocusDiv.eq(a).prop("tagName");
				vsTagId = voFocusDiv.eq(a).prop("id");
				vsTagInfo = vsTagNm + "_" + vsTagId;
				
				
				var vnChildCount2 = voChild2.length
				if(vnChildCount2 != 0){
					for(var b=0; b<vnChildCount2; b++){
						if(voChild2.eq(b).prop("id") != ""){
							var vsTagNm2 = voChild2.eq(b).prop("tagName");
							var vsTagId2 = voChild2.eq(b).prop("id");
							var vsTagInfo2 = vsTagNm2 + "_" + vsTagId2;
							
							vsRightSource =  vsBasicSource + "id = \""+vsTagInfo2 + "\"";
							vsRightSource += " orgId=\""+vsTagId2+"\"";
							vsRightSource += " level = \"2\"";
							vsRightSource += " parent = \""+vsTagInfo + "\"";
							vsRightSource += "><span class=\"ui-icon ui-icon-arrowthick-2-n-s\"></span>";
							vsRightSource +=  vsTagInfo2 + "</li>"
							
							var vnoverlapCount = 0;
							
							// 손자가 outline에 이미 존재하는지 체크
							for(var c=0; c<vnSortableChildCount; c++){
								if(voSortableChild.eq(c).text() == vsTagInfo2){
									vnoverlapCount++;
								}
							}
							
							// 존재하지 않는다면 추가
							if(vnoverlapCount == 0){
								
								// 자식이 하나도 없다면 부모바로 다음에 존재해야 함으로 after처리
								if($("[parent="+vsTagInfo+"]").length == 0){
									$("#"+vsTagInfo).after(vsRightSource);
							    // 자식이 하나 이상이라면 가장 마지막 처리
								} else{
									$("[parent="+vsTagInfo+"]").last().after(vsRightSource);
								}
								
							}

						}
						
						
					}
					
				}
			}
		}
	}