
package scrobot.cmm.controller;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import scrobot.sourceFileGenerator.Application;
import scrobot.cmm.service.cmm010101Service;
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
 *  test2
 *  test3 jhj
 *  
 */

@Controller
public class cmm010101Controller {
	
	/** EgovSampleService */
	private cmm010101Service cmm010101Service;
	
	/**
	 * 화면그리기 화면을 조회한다.
	 */
	@RequestMapping(value = "/registViewDrawWrk.do", method = RequestMethod.GET, produces = "application/text; charset=utf8" )
	public void registViewDrawWrk(@RequestParam Map<String, Object> param, SessionStatus status, HttpServletRequest request) throws Exception {
		
		

		status.setComplete();
	}



}
