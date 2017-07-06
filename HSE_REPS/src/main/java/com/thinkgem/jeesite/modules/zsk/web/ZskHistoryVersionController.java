/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.zsk.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.zsk.entity.ZskHistoryVersion;
import com.thinkgem.jeesite.modules.zsk.service.ZskHistoryVersionService;

/**
 * 历史文档查看Controller
 * @author 郭凯凯
 * @version 2017-04-20
 */
@Controller
@RequestMapping(value = "${adminPath}/zsk/zskHistoryVersion")
public class ZskHistoryVersionController extends BaseController {

	@Autowired
	private ZskHistoryVersionService zskHistoryVersionService;
	
	@ModelAttribute
	public ZskHistoryVersion get(@RequestParam(required=false) String id) {
		ZskHistoryVersion entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = zskHistoryVersionService.get(id);
		}
		if (entity == null){
			entity = new ZskHistoryVersion();
		}
		return entity;
	}
	
	@RequiresPermissions("zsk:zskHistoryVersion:view")
	@RequestMapping(value = {"list", ""})
	public String list(ZskHistoryVersion zskHistoryVersion, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<ZskHistoryVersion> page = zskHistoryVersionService.findPage(new Page<ZskHistoryVersion>(request, response), zskHistoryVersion); 
		model.addAttribute("page", page);
		return "modules/zsk/zskHistoryVersionList";
	}

	@RequiresPermissions("zsk:zskHistoryVersion:view")
	@RequestMapping(value = "form")
	public String form(ZskHistoryVersion zskHistoryVersion, Model model) {
		model.addAttribute("zskHistoryVersion", zskHistoryVersion);
		return "modules/zsk/zskHistoryVersionForm";
	}

	@RequiresPermissions("zsk:zskHistoryVersion:edit")
	@RequestMapping(value = "save")
	public String save(ZskHistoryVersion zskHistoryVersion, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, zskHistoryVersion)){
			return form(zskHistoryVersion, model);
		}
		zskHistoryVersionService.save(zskHistoryVersion);
		addMessage(redirectAttributes, "保存历史文档查看成功");
		return "redirect:"+Global.getAdminPath()+"/zsk/zskHistoryVersion/?repage";
	}
	
	@RequiresPermissions("zsk:zskHistoryVersion:edit")
	@RequestMapping(value = "delete")
	public String delete(ZskHistoryVersion zskHistoryVersion, RedirectAttributes redirectAttributes) {
		zskHistoryVersionService.delete(zskHistoryVersion);
		addMessage(redirectAttributes, "删除历史文档查看成功");
		return "redirect:"+Global.getAdminPath()+"/zsk/zskHistoryVersion/?repage";
	}

}