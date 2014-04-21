package cn.ts987.oa.controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLEncoder;
import java.util.Collection;
import java.util.zip.ZipInputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.activiti.engine.repository.ProcessDefinition;
import org.apache.log4j.Logger;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("processDefinition")
public class ProcessDefinitionController extends BaseController<Object>{
	
	private Logger logger = Logger.getLogger(ProcessDefinitionController.class.getName());  
	
	@RequestMapping("/list")
	public ModelAndView list() {
		Collection<ProcessDefinition> pdList = processDefinitionService.findAllLatestVersions();
		ModelAndView mv = new ModelAndView();
		mv.addObject("pdList", pdList);
		mv.setViewName("workflow/processDefinition/list");
		return mv; 
	}
	
	@RequestMapping("/addUI")
	public ModelAndView addUI() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("workflow/processDefinition/addUI");
		return mv;
	}
	
	@RequestMapping(value="processDefinition/add", method=RequestMethod.POST)//将文件上传请求映射到该方法
    public ModelAndView uploadFile(MultipartHttpServletRequest request) throws Exception{        
        MultipartFile file = request.getFile("file");//取得from里面的参数
        
        if(file == null) {
        	throw new FileNotFoundException("上传的流程定义文件不存在");
        }
        
        ZipInputStream zipInputStream = new ZipInputStream(file.getInputStream());
		processDefinitionService.deployZip(zipInputStream);
        
		//流程定义添加成功后，转到列表页面
		Collection<ProcessDefinition> pdList = processDefinitionService.findAllLatestVersions();
		ModelAndView mv = new ModelAndView();
		mv.addObject("pdList", pdList);
		mv.setViewName("workflow/processDefinition/list");
        return mv;//返回成功视图
    }   
	
	@RequestMapping("/delete")
	public ModelAndView delete(@RequestParam String key) throws Exception {
		key = new String(key.getBytes("iso8859-1"), "utf-8");
		processDefinitionService.deleteByKey(key);
		
		//流程定义添加成功后，转到列表页面
		Collection<ProcessDefinition> pdList = processDefinitionService.findAllLatestVersions();
		ModelAndView mv = new ModelAndView();
		mv.addObject("pdList", pdList);
		mv.setViewName("workflow/processDefinition/list");
        return mv;//返回成功视图
	}
	
	/**
	 * 获取流程图片 xxx.png
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("/showProcessImage")
	public void showProcess(@RequestParam String pdId, HttpServletResponse response)
	{
		try {
			
			InputStream resourceAsStream = processDefinitionService.getProcessImage(pdId);
			byte[] b = new byte[1024];
			int len = -1;
			while ((len = resourceAsStream.read(b, 0, 1024)) != -1) {
			    response.getOutputStream().write(b, 0, len);
			}
		}
		catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	
	
  
	 
	 
	
	

	
}
