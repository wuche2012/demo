package com.cc.framework.web.admin;

import java.security.interfaces.RSAPublicKey;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.codec.binary.Base64;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.DisabledAccountException;
import org.apache.shiro.authc.ExcessiveAttemptsException;
import org.apache.shiro.authc.ExpiredCredentialsException;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authc.pam.UnsupportedTokenException;
import org.apache.shiro.authz.UnauthorizedException;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.cc.framework.security.AuthenticationToken;
import com.cc.framework.service.RSAService;
import com.cc.framework.service.impl.RSAServiceImpl;
import com.cc.framework.util.SpringContextUtil;
import com.cc.framework.web.BaseController;


@Controller
@RequestMapping("/admin")
public class AdminIndexController extends BaseController{

	@RequestMapping("/index")
	public ModelAndView index(){
		return new ModelAndView("admin/index");
	}
	
	@RequestMapping(value = "/login",method=RequestMethod.POST)  
	public ModelAndView doLogin(HttpServletRequest request, Model model) {  
		String host = request.getRemoteAddr();
	    String msg = "";  
	    ModelAndView mv = new ModelAndView("admin/login");
	    String userName = request.getParameter("username");  
	    String password = request.getParameter("password");
	    String captchaId = request.getParameter("captchaId");
	    String captcha = request.getParameter("captcha");
	    boolean rememberMe = Boolean.parseBoolean(request.getParameter("rememberMe"));
	    System.out.println(userName);  
	    System.out.println(password);  
	    
	    AuthenticationToken token = new AuthenticationToken(userName, password, captchaId, captcha, rememberMe, host);
	    
	    token.setRememberMe(true);  
	    Subject subject = SecurityUtils.getSubject();  
	    try {  
	        subject.login(token);  
	        if (subject.isAuthenticated()) {  
	            return index(); 
	        } else {
	        	mv.addObject("msg", msg);
	            return mv;  
	        }  
	    } catch (IncorrectCredentialsException e) {  
	        msg = "登录用戶名或密码错误!";// Password for account " + token.getPrincipal() + " was incorrect.";  
	        model.addAttribute("message", msg);  
	        System.out.println(msg);  
	    } catch (ExcessiveAttemptsException e) {  
	        msg = "登录失败次数过多!";  
	        model.addAttribute("message", msg);  
	        System.out.println(msg);  
	    } catch (LockedAccountException e) {  
	        msg = "帐号已被锁定!";//The account for username " + token.getPrincipal() + " was locked.";  
	        model.addAttribute("message", msg);  
	        System.out.println(msg);  
	    } catch (DisabledAccountException e) {  
	        msg = "帐号已被禁用! ";//The account for username " + token.getPrincipal() + " was disabled.";  
	        model.addAttribute("message", msg);  
	        System.out.println(msg);  
	    } catch (ExpiredCredentialsException e) {  
	        msg = "帐号已过期!";// the account for username " + token.getPrincipal() + "  was expired.";  
	        model.addAttribute("message", msg);  
	        System.out.println(msg);  
	    } catch (UnknownAccountException e) {  
	        msg = "帐号不存在!";// There is no user with username of " + token.getPrincipal();  
	        model.addAttribute("message", msg);  
	        System.out.println(msg);  
	    } catch (UnauthorizedException e) {  
	        msg = "您没有得到相应的授权！";//+ e.getMessage();  
	        model.addAttribute("message", msg);  
	        System.out.println(msg);  
	    } catch(UnsupportedTokenException e){
	    	msg = "验证码错误！";
	    	model.addAttribute("message", msg);  
	    }
	    mv.addObject("msg", msg);
	    return mv;
	}
	
	@RequestMapping("/logout")
	private ModelAndView logout(HttpServletRequest request){
		Subject currentUser = SecurityUtils.getSubject();  
		currentUser.logout();
		rsaService.removePrivateKey(request);
		return welcom(request);
	}
	
	@Autowired
	private RSAService rsaService;
	
	@RequestMapping(value="/login",method=RequestMethod.GET)
	public ModelAndView welcom(HttpServletRequest request){
		RSAPublicKey publicKey = rsaService.generateKey(request);
		String modulus = Base64.encodeBase64String(publicKey.getModulus().toByteArray());
		String exponent = Base64.encodeBase64String(publicKey.getPublicExponent().toByteArray());
		
		String captchaId = UUID.randomUUID().toString();
		ModelAndView mv = new ModelAndView("admin/login");
		mv.addObject("captchaId", captchaId);
		mv.addObject("modulus", modulus);
		mv.addObject("exponent", exponent);
		return mv;
	}
	
	@RequestMapping("/welcome")
	public String wel(){
		return "admin/welcome";
	}
}
