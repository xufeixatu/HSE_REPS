/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.check.web;

import java.io.File;
import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.poi.ss.usermodel.Row;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.excel.ImportExcel;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.check.entity.CheckItem;
import com.thinkgem.jeesite.modules.check.entity.CheckTemplate;
import com.thinkgem.jeesite.modules.check.service.CheckItemService;
import com.thinkgem.jeesite.modules.check.service.CheckTemplateService;

/**
 * 检查模板管理Controller
 * @author hehui
 * @version 2017-05-08
 */
@Controller
@RequestMapping(value = "${adminPath}/check/checkTemplate")
public class CheckTemplateController extends BaseController {

	private static final Logger LOG = Logger.getLogger(CheckTemplateController.class);
	
	@Autowired
	private CheckTemplateService checkTemplateService;
	
	@Autowired
	private CheckItemService checkItemService;
	
	@ModelAttribute
	public CheckTemplate get(@RequestParam(required=false) String id) {
		CheckTemplate entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = checkTemplateService.get(id);
		}
		if (entity == null){
			entity = new CheckTemplate();
		}
		return entity;
	}
	
	@RequiresPermissions("check:checkTemplate:view")
	@RequestMapping(value = {"list", ""})
	public String list(CheckTemplate checkTemplate, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CheckTemplate> page = checkTemplateService.findPage(new Page<CheckTemplate>(request, response), checkTemplate); 
		model.addAttribute("page", page);
		return "modules/check/checkTemplateList";
	}

	@RequiresPermissions("check:checkTemplate:view")
	@RequestMapping(value = "form")
	public String form(CheckTemplate checkTemplate, Model model) {
		model.addAttribute("checkTemplate", checkTemplate);
		return "modules/check/checkTemplateForm";
	}

	@RequiresPermissions("check:checkTemplate:edit")
	@RequestMapping(value = "save")
	public String save(HttpServletRequest request, HttpServletResponse response, 
			RedirectAttributes redirectAttributes) {
		
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request; 
		MultipartFile uploadFile = multipartRequest.getFile("attachFile"); 
		String filePath = null;
		CheckTemplate checkTemplate = new CheckTemplate();
   	 	try {
   	 		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd-HH-mm-ss");
   	 		String currentTime = DateUtils.DateToStr(format, DateUtils.getCurrTime());
   	 		//上传至服务器的目录
   	 		String uploadDirStr = request.getSession().getServletContext().getRealPath("/")+"check_template/";
   	 		File uploadDirFile = new File(uploadDirStr);
   	 		if(!uploadDirFile.exists()){
   	 			uploadDirFile.mkdirs();
   	 		}
   	 		String fileName = uploadFile.getOriginalFilename();
			filePath = uploadDirStr + fileName.substring(0, fileName.lastIndexOf(".")) + "(" + currentTime + ").xls";
 			uploadFile.transferTo(new File(filePath));
			checkTemplate.setTemplateName(multipartRequest.getParameter("templateName"));
			checkTemplate.setTemplateDesc(multipartRequest.getParameter("templateDesc"));	
			checkTemplate.setUsedStatus(multipartRequest.getParameter("usedStatus"));			 
		} catch (Exception e) {
			addMessage(redirectAttributes, "上传检查模板失败！");
			return "";
		}
		checkTemplateService.save(checkTemplate);
		//从模板中读取检查项并存入到数据库中
        if(!StringUtils.isEmpty(filePath)) {
        	int rowNum = 1;
        	try {
        		ImportExcel excel = new ImportExcel(filePath, 2);
        		for (int i = excel.getDataRowNum(); i < excel.getLastDataRowNum(); i++) {
        			rowNum = i;
        			Row row = excel.getRow(i);
        			String checkContent = excel.getCellValue(row, 1).toString();
        			CheckItem checkItem = new CheckItem();
        			checkItem.setTemplateId(checkTemplate.getId());
        			checkItem.setCheckContent(checkContent);
        			checkItemService.save(checkItem);
        		}
        	} catch (Exception e) {
        		LOG.error("插入检查项失败！文件名："+filePath+",row:"+rowNum+","+e.toString());
        	}
        }
		addMessage(redirectAttributes, "保存检查模板管理成功");
		return "redirect:"+Global.getAdminPath()+"/check/checkTemplate/?repage";
	}
	
	@RequiresPermissions("check:checkTemplate:edit")
	@RequestMapping(value = "delete")
	public String delete(CheckTemplate checkTemplate, RedirectAttributes redirectAttributes) {
		checkTemplateService.delete(checkTemplate);
		CheckItem checkItem = new CheckItem();
		checkItem.setTemplateId(checkTemplate.getId());
		checkItemService.delete(checkItem);
		addMessage(redirectAttributes, "删除检查模板管理成功");
		return "redirect:"+Global.getAdminPath()+"/check/checkTemplate/?repage";
	}

}