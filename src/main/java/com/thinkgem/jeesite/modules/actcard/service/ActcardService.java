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
import com.thinkgem.jeesite.modules.actcard.entity.Actcard;
import com.thinkgem.jeesite.modules.act.service.ActTaskService;
import com.thinkgem.jeesite.modules.act.utils.ActUtils;
import com.thinkgem.jeesite.modules.actcard.dao.ActcardDao;

/**
 * ACT卡Service
 * @author 岳鑫
 * @version 2017-05-23
 */
@Service
@Transactional(readOnly = true)
public class ActcardService extends CrudService<ActcardDao, Actcard> {
	
	@Autowired
	private ActTaskService actTaskService;

	public Actcard get(String id) {
		return super.get(id);
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
		//actTaskService.startProcess(ActUtils.PD_ACTCARD_PROCESS[0], ActUtils.PD_ACTCARD_PROCESS[1], actcard.getId(), "ACT卡");
	}
	
	@Transactional(readOnly = false)
	public void delete(Actcard actcard) {
		super.delete(actcard);
	}
	
}