/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.actcard.service;

import java.util.List;
import java.util.UUID;

import org.activiti.engine.RuntimeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.actcard.entity.Actcard;
import com.thinkgem.jeesite.modules.actcard.entity.ActcardReview;
import com.thinkgem.jeesite.modules.actcard.entity.ActcardUnsafe;
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
	private ActcardUnsafeService actcardUnsafeService;
	@Autowired
	private ActcardUnsafeEventService actcardUnsafeEventService;
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
		String others = actcard.getActcardUnsafeEventChildId();//用ActcardUnsafeEventChildId代替other传入
		actcard.setActcardUnsafeEventChildId("");
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
			
			//新的流程时保存actcard_unsafe表
			saveActunsafe(actcard,others);
		}
	}
	
	
	private void saveActunsafe(Actcard actcard,String others) {
		
		// TODO Auto-generated method stub
		String unids = actcard.getActcardUnsafeEventId();
		if(null!=unids && unids.length()>1){//将正常的actunsafe保存
			String[] unidsArr = unids.split(",");
			for (int i = 0; i < unidsArr.length; i++) {
				if(null != unidsArr[i] && !"".equals(unidsArr[i])){
					ActcardUnsafe actcardUnsafe = new ActcardUnsafe();
					//actcardUnsafe.setId("ee");
					actcardUnsafe.setActcardId(actcard.getId());
					actcardUnsafe.setUnsafeEventId(unidsArr[i]);
					ActcardUnsafe actcardUnsafe2 = new ActcardUnsafe();//父亲节点，这里的ID为下一个的parentID
					if(null == actcardUnsafeEventService.get(unidsArr[i]).getParentId()){
						actcardUnsafe2.setId("0");
					}else{
						actcardUnsafe2.setId(actcardUnsafeEventService.get(unidsArr[i]).getParentId());
					}
					
					actcardUnsafe.setParent(actcardUnsafe2);
					actcardUnsafe.setParentIds("0,");
					actcardUnsafe.setSort(actcardUnsafeEventService.get(unidsArr[i]).getSort()+"");
					actcardUnsafe.setName(actcardUnsafeEventService.get(unidsArr[i]).getName());
					actcardUnsafeService.save(actcardUnsafe);
				}
			}
		}
		//保存其他
		String unsafeOtherInfo = others;
		if(unsafeOtherInfo.length()>1){
			String[] unsafeOtherInfos = unsafeOtherInfo.split(",");
			for (int i = 0; i < unsafeOtherInfos.length; i++) {
				ActcardUnsafe actcardUnsafe = new ActcardUnsafe();
				//actcardUnsafe.setId("ee");
				actcardUnsafe.setActcardId(actcard.getId());
				actcardUnsafe.setUnsafeEventId(UUID.randomUUID().toString().replaceAll("-", ""));
				ActcardUnsafe actcardUnsafe2 = new ActcardUnsafe();//父亲节点，这里的ID为下一个的parentID
				actcardUnsafe2.setId(unsafeOtherInfos[i].split("-")[1].replaceAll("_temp", ""));
				
				actcardUnsafe.setParent(actcardUnsafe2);
				actcardUnsafe.setParentIds("0,");
				actcardUnsafe.setSort("30");
				actcardUnsafe.setName(unsafeOtherInfos[i].split("-")[0]);
				actcardUnsafeService.save(actcardUnsafe);
			}
		}
		
	}

	@Transactional(readOnly = false)
	public void review(Actcard actcard,ActcardReview actcardReview) {
		actcard.getActcardReviewList().add(actcardReview);
		actcardReview.setActcard(actcard);
		actcardReview.preInsert();
		actcardReviewDao.insert(actcardReview);
	}
	
	
	@Transactional(readOnly = false)
	public void delete(Actcard actcard) {
		super.delete(actcard);
		actcardReviewDao.delete(new ActcardReview(actcard));
	}
	
}