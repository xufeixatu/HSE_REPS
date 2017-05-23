/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.train.service.matrix;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.train.entity.matrix.TrainContent;
import com.thinkgem.jeesite.modules.train.dao.matrix.TrainContentDao;

/**
 * 培训知识内容信息Service
 * @author peizhen
 * @version 2017-05-18
 */
@Service
@Transactional(readOnly = true)
public class TrainContentService extends CrudService<TrainContentDao, TrainContent> {

	public TrainContent get(String id) {
		return super.get(id);
	}
	
	public List<TrainContent> findList(TrainContent trainContent) {
		return super.findList(trainContent);
	}
	
	public Page<TrainContent> findPage(Page<TrainContent> page, TrainContent trainContent) {
		return super.findPage(page, trainContent);
	}
	
	@Transactional(readOnly = false)
	public void save(TrainContent trainContent) {
		super.save(trainContent);
	}
	
	@Transactional(readOnly = false)
	public void delete(TrainContent trainContent) {
		super.delete(trainContent);
	}
	
}