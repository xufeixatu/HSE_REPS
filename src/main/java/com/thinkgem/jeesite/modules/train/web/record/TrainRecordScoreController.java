/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.train.web.record;

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
import com.thinkgem.jeesite.modules.train.entity.record.TrainRecordScore;
import com.thinkgem.jeesite.modules.train.service.record.TrainRecordScoreService;

/**
 * 受培人员成绩Controller
 * @author peizhen
 * @version 2017-05-20
 */
@Controller
@RequestMapping(value = "${adminPath}/train/record/trainRecordScore")
public class TrainRecordScoreController extends BaseController {

	@Autowired
	private TrainRecordScoreService trainRecordScoreService;
	
	@ModelAttribute
	public TrainRecordScore get(@RequestParam(required=false) String id) {
		TrainRecordScore entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = trainRecordScoreService.get(id);
		}
		if (entity == null){
			entity = new TrainRecordScore();
		}
		return entity;
	}
	
	@RequiresPermissions("train:record:trainRecordScore:view")
	@RequestMapping(value = {"list", ""})
	public String list(TrainRecordScore trainRecordScore, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<TrainRecordScore> page = trainRecordScoreService.findPage(new Page<TrainRecordScore>(request, response), trainRecordScore); 
		model.addAttribute("page", page);
		return "modules/train/record/trainRecordScoreList";
	}

	@RequiresPermissions("train:record:trainRecordScore:view")
	@RequestMapping(value = "form")
	public String form(TrainRecordScore trainRecordScore, Model model) {
		model.addAttribute("trainRecordScore", trainRecordScore);
		return "modules/train/record/trainRecordScoreForm";
	}

	@RequiresPermissions("train:record:trainRecordScore:edit")
	@RequestMapping(value = "save")
	public String save(TrainRecordScore trainRecordScore, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, trainRecordScore)){
			return form(trainRecordScore, model);
		}
		trainRecordScoreService.save(trainRecordScore);
		addMessage(redirectAttributes, "保存受培人员成绩成功");
		return "redirect:"+Global.getAdminPath()+"/train/record/trainRecordScore/?repage";
	}
	
	@RequiresPermissions("train:record:trainRecordScore:edit")
	@RequestMapping(value = "delete")
	public String delete(TrainRecordScore trainRecordScore, RedirectAttributes redirectAttributes) {
		trainRecordScoreService.delete(trainRecordScore);
		addMessage(redirectAttributes, "删除受培人员成绩成功");
		return "redirect:"+Global.getAdminPath()+"/train/record/trainRecordScore/?repage";
	}

}