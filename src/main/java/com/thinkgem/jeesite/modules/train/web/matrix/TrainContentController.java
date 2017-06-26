/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.train.web.matrix;

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
import com.thinkgem.jeesite.modules.train.entity.matrix.TrainContent;
import com.thinkgem.jeesite.modules.train.service.matrix.TrainContentService;

/**
 * 培训知识内容信息Controller
 * @author peizhen
 * @version 2017-05-18
 */
@Controller
@RequestMapping(value = "${adminPath}/train/matrix/trainContent")
public class TrainContentController extends BaseController {

	@Autowired
	private TrainContentService trainContentService;
	
	@ModelAttribute
	public TrainContent get(@RequestParam(required=false) String id) {
		TrainContent entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = trainContentService.get(id);
		}
		if (entity == null){
			entity = new TrainContent();
		}
		return entity;
	}
	
	@RequiresPermissions("train:matrix:trainContent:view")
	@RequestMapping(value = {"list", ""})
	public String list(TrainContent trainContent, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<TrainContent> page = trainContentService.findPage(new Page<TrainContent>(request, response), trainContent); 
		model.addAttribute("page", page);
		return "modules/train/matrix/trainContentList";
	}

	@RequiresPermissions("train:matrix:trainContent:view")
	@RequestMapping(value = "form")
	public String form(TrainContent trainContent, Model model) {
		model.addAttribute("trainContent", trainContent);
		return "modules/train/matrix/trainContentForm";
	}

	@RequiresPermissions("train:matrix:trainContent:edit")
	@RequestMapping(value = "save")
	public String save(TrainContent trainContent, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, trainContent)){
			return form(trainContent, model);
		}
		trainContentService.save(trainContent);
		addMessage(redirectAttributes, "保存培训内容成功");
		return "redirect:"+Global.getAdminPath()+"/train/matrix/trainContent/?repage";
	}
	
	@RequiresPermissions("train:matrix:trainContent:edit")
	@RequestMapping(value = "delete")
	public String delete(TrainContent trainContent, RedirectAttributes redirectAttributes) {
		trainContentService.delete(trainContent);
		addMessage(redirectAttributes, "删除培训内容成功");
		return "redirect:"+Global.getAdminPath()+"/train/matrix/trainContent/?repage";
	}

}