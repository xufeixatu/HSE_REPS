/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.check.web;

import java.util.List;

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
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.check.entity.Question;
import com.thinkgem.jeesite.modules.check.service.QuestionService;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

/**
 * 监督检查问题上报Controller
 * @author hehui
 * @version 2017-05-15
 */
@Controller
@RequestMapping(value = "${adminPath}/check/question")
public class QuestionController extends BaseController {

	@Autowired
	private QuestionService questionService;
	
	@ModelAttribute
	public Question get(@RequestParam(required=false) String id) {
		Question entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = questionService.get(id);
		}
		if (entity == null){
			entity = new Question();
		}
		return entity;
	}
	
	@RequiresPermissions("check:question:view")
	@RequestMapping(value = {"list", ""})
	public String list(Question question, HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		if (!user.isAdmin()){
			question.setCreateBy(user);
		}
		Page<Question> page = questionService.findPage(new Page<Question>(request, response), question); 
		List<Question> questions = page.getList();
		try {
			for (Question ques : questions) {
				User reportUser = UserUtils.get(ques.getReportUserId());
				ques.setReportUserName(reportUser.getName());
				ques.setReportUserOfficeName(reportUser.getOffice().getName());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("page", page);
		return "modules/check/questionList";
	}

	@RequiresPermissions("check:question:view")
	@RequestMapping(value = "form")
	public String form(Question question, Model model) {
		
		String view = "questionForm";
		
		// 查看审批申请单
		if (StringUtils.isNotBlank(question.getId())){

			// 环节编号
			String taskDefKey = question.getAct().getTaskDefKey();
			
			// 查看工单
			if(question.getAct().isFinishTask()){
				view = "questionAuditView";
			}
			// 修改环节
			else if ("problem_report_modify".equals(taskDefKey)){
				view = "questionForm";
			}
			// 审核环节
			else if ("problem_report_audit01".equals(taskDefKey)){
				view = "questionAudit";
			}
			// 审核环节2
			else if ("problem_report_audit02".equals(taskDefKey)){
				view = "questionAudit";
			}
			// 审核环节3
			else if ("problem_report_audit03".equals(taskDefKey)){
				view = "questionAudit";
			}
		}
		model.addAttribute("question", question);
		return "modules/check/"+view;
	}

	@RequiresPermissions("check:question:edit")
	@RequestMapping(value = "save")
	public String save(Question question, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, question)){
			return form(question, model);
		}
		questionService.save(question);
		addMessage(redirectAttributes, "提交审批'" + question.getCurrentAuditUser().getName() + "'成功");
		return "redirect:" + adminPath + "/act/task/todo/";
//		addMessage(redirectAttributes, "保存监督检查问题上报成功");
//		return "redirect:"+Global.getAdminPath()+"/check/question/?repage";
	}
	
	@RequiresPermissions("check:question:edit")
	@RequestMapping(value = "saveAudit")
	public String saveAudit(Question question, Model model) {
		if (StringUtils.isBlank(question.getAct().getFlag())
				|| StringUtils.isBlank(question.getAct().getComment())){
			addMessage(model, "请填写意见");
			return form(question, model);
		}
		questionService.auditSave(question);
		return "redirect:" + adminPath + "/act/task/todo/";
	}	
	
	@RequiresPermissions("check:question:edit")
	@RequestMapping(value = "delete")
	public String delete(Question question, RedirectAttributes redirectAttributes) {
		questionService.delete(question);
		addMessage(redirectAttributes, "删除检查问题成功");
		return "redirect:"+Global.getAdminPath()+"/check/question/?repage";
	}

}