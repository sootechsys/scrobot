
package scrobot.viewedit.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import scrobot.sourceFileGenerator.Application;
import scrobot.viewedit.service.view010101Service;
/**
 * @Class Name : viewEditController.java
 * @Description : EgovSample Controller Class
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2009.03.16           최초생성
 *
 * @author 개발프레임웍크 실행환경 개발팀
 * @since 2009. 03.16
 * @version 1.0
 * @see
 *
 *  Copyright (C) by MOPAS All right reserved.
 */

@Controller
public class view010101Controller {
	
	/** EgovSampleService */
	private view010101Service view010101service;
	
	/**
	 * 화면그리기 화면을 조회한다.
	 */
	@RequestMapping(value = "/viewEdit.do", method = RequestMethod.GET, produces = "application/text; charset=utf8" )
	public String main() throws Exception {
		return "view/view010101";
	}
	
	/**
	 * 소스 만들기를 실행한다.
	 */
	@RequestMapping(value = "/creationSource.do", produces = "application/text; charset=utf8" )
	public void creationSource(@RequestParam Map<String, Object> param, SessionStatus status) throws Exception {
		Application.main(param);
	}
	
	/*
	 * 테이블 조작 화면을 조회한다
	 * */
	@RequestMapping(value = "/scrobotheader.do", method = RequestMethod.GET, produces = "application/text; charset=utf8" )
	public String scrobotheader() throws Exception {
		return "view/scrobotheader";
	}
	
	@RequestMapping(value = "/scrobotleft.do", method = RequestMethod.GET, produces = "application/text; charset=utf8" )
	public String scrobotleft() throws Exception {
		return "view/scrobotleft";
	}
	
	@RequestMapping(value = "/extable.do", method = RequestMethod.GET, produces = "application/text; charset=utf8" )
	public String extable() throws Exception {
		return "extable/extable";
	}
}









