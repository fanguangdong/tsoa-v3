package cn.ts987.oa.interceptor;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Level;
import org.apache.log4j.Logger;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import cn.ts987.oa.domain.User;

public class LoginInterceptor implements HandlerInterceptor{

private Logger logger = Logger.getLogger(LoginInterceptor.class.getName()); 
	
	private List<String> excludedUrls;
	   
	public void setExcludedUrls(List<String> excludedUrls) {  
		this.excludedUrls = excludedUrls;  
	}   
	
	@Override
	public void afterCompletion(HttpServletRequest arg0,
			HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1,
			Object arg2, ModelAndView arg3) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public boolean preHandle(HttpServletRequest req, HttpServletResponse res,
			Object arg2) throws Exception {
		
		//排除指定urls
		String requestUri = req.getRequestURI();  
	    for (String url : excludedUrls) {  
	    	
	      if (requestUri.endsWith(url)) {  //排除urls
	    	  return true;  
	      }  
	    }  
		
	    User user = (User) req.getSession().getAttribute("user");
	    
		if(user == null) {
            logger.log(Level.INFO, "user not login"); 
            res.sendRedirect(req.getContextPath() +  "/user/loginUI.oa"); 
            return false;  
        } 
		
        return true;
	}
	
}
