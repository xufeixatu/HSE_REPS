/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.actcard.web;

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
import com.thinkgem.jeesite.modules.actcard.entity.ActcardReview;
import com.thinkgem.jeesite.modules.actcard.service.ActcardReviewService;

/**
 * ACT卡评阅Controller
 * @author 岳鑫
 * @version 2017-05-23
 */
@Controller
@RequestMapping(value = "${adminPath}/actcard/actcardReview")
public class ActcardReviewController extends BaseController {

	@Autowired
	private ActcardReviewService actcardReviewService;
	
	@ModelAttribute
	public ActcardReview get(@RequestParam(required=false) String id) {
		ActcardReview entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = actcardReviewService.get(id);
		}
		if (entity == null){
			entity = new ActcardReview();
		}
		return entity;
	}
	
	@RequiresPermissions("actcard:actcardReview:view")
	@RequestMapping(value = {"list", ""})
	public String list(ActcardReview actcardReview, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<ActcardReview> page = actcardReviewService.findPage(new Page<ActcardReview>(request, response), actcardReview); 
		model.addAttribute("page", page);
		return "modules/actcard/actcardReviewList";
	}

	@RequiresPermissions("actcard:actcardReview:view")
	@RequestMapping(value = "form")
	public String form(ActcardReview actcardReview, Model model) {
		model.addAttribute("actcardReview", actcardReview);
		return "modules/actcard/actcardReviewForm";
	}

	@RequiresPermissions("actcard:actcardReview:edit")
	@RequestMapping(value = "save")
	public String save(ActcardReview actcardReview, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, actcardReview)){
			return form(actcardReview, model);
		}
		actcardReviewService.save(actcardReview);
		addMessage(redirectAttributes, "保存ACT卡评阅成功");
		return "redirect:"+Global.getAdminPath()+"/actcard/actcardReview/?repage";
	}
	
	@RequiresPermissions("actcard:actcardReview:edit")
	@RequestMapping(value = "delete")
	public String delete(ActcardReview actcardReview, RedirectAttributes redirectAttributes) {
		actcardReviewService.delete(actcardReview);
		addMessage(redirectAttributes, "删除ACT卡评阅成功");
		return "redirect:"+Global.getAdminPath()+"/actcard/actcardReview/?repage";
	}

}