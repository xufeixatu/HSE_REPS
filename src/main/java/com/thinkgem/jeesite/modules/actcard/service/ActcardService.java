/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.actcard.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.actcard.entity.Actcard;
import com.thinkgem.jeesite.modules.actcard.entity.ActcardReview;
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
	private ActcardReviewDao actcardReviewDao;
	
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
		super.save(actcard);
		for (ActcardReview actcardReview : actcard.getActcardReviewList()){
			if (actcardReview.getId() == null){
				continue;
			}
			if (ActcardReview.DEL_FLAG_NORMAL.equals(actcardReview.getDelFlag())){
				if (StringUtils.isBlank(actcardReview.getId())){
					actcardReview.setActcard(actcard);
					actcardReview.preInsert();
					actcardReviewDao.insert(actcardReview);
				}else{
					actcardReview.preUpdate();
					actcardReviewDao.update(actcardReview);
				}
			}else{
				actcardReviewDao.delete(actcardReview);
			}
		}
		actTaskService.startProcess(ActUtils.PD_ACTCARD_PROCESS[0], ActUtils.PD_ACTCARD_PROCESS[1], actcard.getId(), "ACT卡");
	}
	
	@Transactional(readOnly = false)
	public void delete(Actcard actcard) {
		super.delete(actcard);
		actcardReviewDao.delete(new ActcardReview(actcard));
	}
	
}