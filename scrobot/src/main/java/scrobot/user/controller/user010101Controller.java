/*
 * Copyright 2008-2009 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package scrobot.user.controller;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import scrobot.user.service.user010101Service;

/**
 * @Class Name : EgovSampleController.java

 * @
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2009.03.16           최초생성

 */

@Controller
public class user010101Controller {

	/** user010101Service */
	@Resource(name = "user010101Service")
	private user010101Service user010101service;
	
	/**
	 * 메인 화면을 조회한다.
	 * @param searchVO - 목록 조회조건 정보가 담긴 VO
	 * @param model
	 * @return "egovSampleRegister"
	 * @exception Exception
	 */
	@RequestMapping(value = "/main.do", method = RequestMethod.GET, produces = "application/text; charset=utf8" )
	public String main(HttpServletRequest request) throws Exception {
		  HttpSession session = request.getSession();
		  String userId = (String) session.getAttribute("userId");
		  if(userId != null) {
			  return "forward:/viewEdit.do";
		  } else {
			  return "user/user010101";
		  }
	}
	
	
	/**
	 * 회원가입 화면을 조회한다.
	 * @param searchVO - 목록 조회조건 정보가 담긴 VO
	 * @param model
	 * @return "egovSampleRegister"
	 * @exception Exception
	 */
	@RequestMapping(value = "/moveJoinForm.do", method = RequestMethod.GET, produces = "application/text; charset=utf8" )
	public String moveJoinForm() throws Exception {
		return "user/user010102";
	}

	
	/**
	 * 로그인 정보를 조회 후 로그인한다.
	 * @param searchVO - 목록 조회조건 정보가 담긴 VO
	 * @param model
	 * @return "egovSampleRegister"
	 * @exception Exception
	 */
	@RequestMapping(value = "/retrieveLogin.do", method = RequestMethod.POST, produces = "application/text; charset=utf8" )
	@ResponseBody
	public String retrieveLogin(@RequestParam Map<String, Object> param, SessionStatus status, HttpServletRequest request) throws Exception {
		param.put("dvsNm", "login");
		EgovMap login = user010101service.retrieveLogin(param);
		String loginSuccessYn = (String) login.get("loginSuccessYn");
		if(loginSuccessYn.equals("Y")) {
			HttpSession session = request.getSession();
		    session.setAttribute("userId", param.get("id"));
		}
		status.setComplete();
		return loginSuccessYn;
		
	}
	
	
	/**
	 * 로그아웃한다.
	 * @param searchVO - 목록 조회조건 정보가 담긴 VO
	 * @param model
	 * @return "egovSampleRegister"
	 * @exception Exception
	 */
	@RequestMapping(value = "/logout.do", method = RequestMethod.GET, produces = "application/text; charset=utf8" )
	public String logout(SessionStatus status, HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		session.invalidate();
		status.setComplete();
		System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>logout");
		return "user/user010101";
	}


}
