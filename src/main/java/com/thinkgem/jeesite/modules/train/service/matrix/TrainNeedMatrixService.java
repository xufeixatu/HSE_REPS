/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.train.service.matrix;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.train.entity.matrix.TrainNeedMatrix;
import com.thinkgem.jeesite.modules.train.dao.matrix.TrainNeedMatrixDao;

/**
 * 培训需求矩阵Service
 * @author peizhen
 * @version 2017-05-20
 */
@Service
@Transactional(readOnly = true)
public class TrainNeedMatrixService extends CrudService<TrainNeedMatrixDao, TrainNeedMatrix> {

	public TrainNeedMatrix get(String id) {
		return super.get(id);
	}
	
	public List<TrainNeedMatrix> findList(TrainNeedMatrix trainNeedMatrix) {
		return super.findList(trainNeedMatrix);
	}
	
	public Page<TrainNeedMatrix> findPage(Page<TrainNeedMatrix> page, TrainNeedMatrix trainNeedMatrix) {
		return super.findPage(page, trainNeedMatrix);
	}
	
	@Transactional(readOnly = false)
	public void save(TrainNeedMatrix trainNeedMatrix) {
		super.save(trainNeedMatrix);
	}
	
	@Transactional(readOnly = false)
	public void delete(TrainNeedMatrix trainNeedMatrix) {
		super.delete(trainNeedMatrix);
	}
	
}