/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.actcard.service;

import java.util.List;

import org.activiti.engine.RuntimeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.actcard.entity.Actcard;
import com.thinkgem.jeesite.modules.actcard.entity.ActcardReview;
import com.thinkgem.jeesite.modules.sys.dao.OfficeDao;
import com.thinkgem.jeesite.modules.train.entity.record.TrainRecordCourseware;
import com.thinkgem.jeesite.modules.train.entity.record.TrainRecordScore;
import com.thinkgem.jeesite.modules.act.service.ActTaskService;
import com.thinkgem.jeesite.modules.act.utils.ActUtils;
import com.thinkgem.jeesite.modules.actcard.dao.ActcardDao;
import com.thinkgem.jeesite.modules.actcard.dao.ActcardReviewDao;

/**
 * ACT卡Service
 * @author 岳鑫
 * @version 2017-05-30
 */
@Service
@Transactional(readOnly = true)
public class ActcardService extends CrudService<ActcardDao, Actcard> {

	@Autowired
	private ActTaskService actTaskService;
	@Autowired
	private RuntimeService runtimeService;
	
	@Autowired
	private ActcardReviewDao actcardReviewDao;
	@Autowired
	private OfficeDao officeDao;
	
	public Actcard get(String id) {
		Actcard actcard = super.get(id);
		actcard.setActcardReviewList(actcardReviewDao.findList(new ActcardReview(actcard)));
		return actcard;
	}
	
	public List<Actcard> findList(Actcard actcard) {
		return super.findList(actcard);
	}
	
	public Page<Actcard> findPage(Page<Actcard> page, Actcard actcard) {
		return super.findPage(page, actcard);
	}
	
	@Transactional(readOnly = false)
	public void save(Actcard actcard) {
		Actcard tempactcard = actcard;
		boolean isnew = actcard.getIsNewRecord();
		if (isnew){//这是一个新的流程
			if(null == actcard.getState() || "".equals(actcard.getState())){
				actcard.setState("指定责任人");
				actcard.setOffice(actcard.getTerritorialOffice());
			}
		}else if(actcard.getState().equals("指定责任人") && null != actcard.getSolver() ){
			actcard.setState("反馈整改情况");
			actcard.setUser(actcard.getSolver());
			actcard.setUser(actcard.getSolver());
			
			System.out.println(actcard.getAct().getTaskId());
			actTaskService.getProcessEngine().getTaskService().setAssignee(actcard.getAct().getTaskId(), actcard.getSolver().getId());
			actTaskService.taskForward( actcard.getProcInsId(), null);
			
		}else if(actcard.getState().equals("反馈整改情况") && null != actcard.getRectificationResult()){
			actcard.setState("关闭问题");
			actTaskService.getProcessEngine().getTaskService().setAssignee(actcard.getAct().getTaskId(), null);
			actTaskService.taskForward( actcard.getProcInsId(), null);
		}
		else if(actcard.getState().equals("关闭问题") && null != actcard.getCloserReport()){
			actcard.setState("已关闭");
			actTaskService.taskForward( actcard.getProcInsId(), null);
			//actTaskService.taskForward( actcard.getProcInsId(), null);
		}
		super.save(actcard);
		if (isnew){//这是一个新的流程
			System.out.println("这是一个新的流程");
			actTaskService.startProcess(ActUtils.PD_ACTCARD_PROCESS[0], ActUtils.PD_ACTCARD_PROCESS[1], actcard.getId(), "ACT卡");
		}
	}
	
	@Transactional(readOnly = false)
	public void delete(Actcard actcard) {
		super.delete(actcard);
		actcardReviewDao.delete(new ActcardReview(actcard));
	}
	
}