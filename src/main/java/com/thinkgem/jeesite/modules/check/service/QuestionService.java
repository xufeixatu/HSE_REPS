/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.check.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.common.collect.Maps;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.act.service.ActTaskService;
import com.thinkgem.jeesite.modules.act.utils.ActUtils;
import com.thinkgem.jeesite.modules.check.dao.QuestionDao;
import com.thinkgem.jeesite.modules.check.entity.Question;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

/**
 * 监督检查问题上报Service
 * @author hehui
 * @version 2017-05-15
 */
@Service
@Transactional(readOnly = true)
public class QuestionService extends CrudService<QuestionDao, Question> {

	@Autowired
	private ActTaskService actTaskService;
	
	public Question getByProcInsId(String procInsId) {
		return dao.getByProcInsId(procInsId);
	}
	
	public Question get(String id) {
		return super.get(id);
	}
	
	public List<Question> findList(Question question) {
		return super.findList(question);
	}
	
	public Page<Question> findPage(Page<Question> page, Question question) {
		return super.findPage(page, question);
	}
	
	@Transactional(readOnly = false)
	public void delete(Question question) {
		super.delete(question);
	}
	
	/**
	 * 审核新增或编辑
	 * @param testAudit
	 */
	@Transactional(readOnly = false)
	public void save(Question question) {
		
		// 申请发起
		if (StringUtils.isBlank(question.getId())){
			question.preInsert();
			//设置上报问题者的ID
			User currentUser = UserUtils.getUser();
			question.setReportUserId(currentUser.getId());
			question.setReporterComment(question.getAct().getComment());//上报问题意见
			question.setStateId("1");//问题审批中
			dao.insert(question);
			
			Map<String, Object> vars = Maps.newHashMap();
			String currentAuditUserId = question.getCurrentAuditUser().getId();
			String currentAuditUserLoginName = UserUtils.get(currentAuditUserId).getLoginName();
			vars.put("userId", currentAuditUserLoginName);

			// 启动流程
			actTaskService.startProcess(ActUtils.PD_QUESTION_AUDIT[0], ActUtils.PD_QUESTION_AUDIT[1], question.getId(), "上报问题处理", vars);
		}
		// 重新编辑申请		
		else{
			question.preUpdate();
			dao.update(question);
			question.getAct().setComment(("yes".equals(question.getAct().getFlag())?"[重新上报] ":"[关闭问题] ")+question.getAct().getComment());
			// 完成流程任务
			Map<String, Object> vars = Maps.newHashMap();
			vars.put("pass", "yes".equals(question.getAct().getFlag())? "1" : "0");
			actTaskService.complete(question.getAct().getTaskId(), question.getAct().getProcInsId(), question.getAct().getComment(), "上报问题处理", vars);
		}
	}

	/**
	 * 审核审批保存
	 * @param testAudit
	 */
	@Transactional(readOnly = false)
	public void auditSave(Question question) {
		
		// 设置意见
		question.getAct().setComment(question.getAct().getComment());
		
		question.preUpdate();
		
		// 对不同环节的业务逻辑进行操作
		String taskDefKey = question.getAct().getTaskDefKey();

		// 审核环节
		if ("problem_report_audit".equals(taskDefKey)){
			question.setReporterLeaderComment(question.getAct().getComment());
			if("yes".equals(question.getAct().getFlag())) {
				question.setStateId("2");//问题受理中
			}
			dao.update(question);
		}		
		else if ("problem_report_audit01".equals(taskDefKey)){
			question.setRectifierLeaderComment(question.getAct().getComment());
			question.setStateId("3");//问题处理中
			dao.update(question);
		}
		else if ("problem_report_audit02".equals(taskDefKey)){
			question.setRectifierComment(question.getAct().getComment());
			question.setStateId("4");//问题待关闭
			dao.update(question);
		}
		else if ("problem_report_audit03".equals(taskDefKey)){
			question.setReporterComment(question.getAct().getComment());
			if("yes".equals(question.getAct().getFlag())) {
				question.setStateId("5");//问题已关闭
			}
			dao.update(question);
		}
		// 未知环节，直接返回
		else{
			return;
		}
		// 提交流程任务
		Map<String, Object> vars = Maps.newHashMap();
		vars.put("pass", "yes".equals(question.getAct().getFlag())? "1" : "0");
		String currentAuditUserId = question.getCurrentAuditUser().getId();
		String currentAuditUserLoginName = UserUtils.get(currentAuditUserId).getLoginName();
		vars.put("userId", currentAuditUserLoginName);
		actTaskService.complete(question.getAct().getTaskId(), question.getAct().getProcInsId(), question.getAct().getComment(), vars);
//		vars.put("var_test", "yes_no_test2");
//		actTaskService.getProcessEngine().getTaskService().addComment(testAudit.getAct().getTaskId(), testAudit.getAct().getProcInsId(), testAudit.getAct().getComment());
//		actTaskService.jumpTask(testAudit.getAct().getProcInsId(), testAudit.getAct().getTaskId(), "audit2", vars);
	}
	
}