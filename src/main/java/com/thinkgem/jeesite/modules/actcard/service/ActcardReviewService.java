/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.actcard.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.actcard.entity.ActcardReview;
import com.thinkgem.jeesite.modules.actcard.dao.ActcardReviewDao;

/**
 * ACT卡评阅Service
 * @author 岳鑫
 * @version 2017-05-23
 */
@Service
@Transactional(readOnly = true)
public class ActcardReviewService extends CrudService<ActcardReviewDao, ActcardReview> {

	public ActcardReview get(String id) {
		return super.get(id);
	}
	
	public List<ActcardReview> findList(ActcardReview actcardReview) {
		return super.findList(actcardReview);
	}
	
	public Page<ActcardReview> findPage(Page<ActcardReview> page, ActcardReview actcardReview) {
		return super.findPage(page, actcardReview);
	}
	
	@Transactional(readOnly = false)
	public void save(ActcardReview actcardReview) {
		super.save(actcardReview);
	}
	
	@Transactional(readOnly = false)
	public void delete(ActcardReview actcardReview) {
		super.delete(actcardReview);
	}
	
}