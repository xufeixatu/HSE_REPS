/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.actcard.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.actcard.entity.ActcardUnsafe;
import com.thinkgem.jeesite.modules.actcard.dao.ActcardUnsafeDao;

/**
 * actcard_unsafe关联表Service
 * @author 岳鑫
 * @version 2017-06-07
 */
@Service
@Transactional(readOnly = true)
public class ActcardUnsafeService extends CrudService<ActcardUnsafeDao, ActcardUnsafe> {

	public ActcardUnsafe get(String id) {
		return super.get(id);
	}
	
	public List<ActcardUnsafe> findList(ActcardUnsafe actcardUnsafe) {
		return super.findList(actcardUnsafe);
	}
	
	public Page<ActcardUnsafe> findPage(Page<ActcardUnsafe> page, ActcardUnsafe actcardUnsafe) {
		return super.findPage(page, actcardUnsafe);
	}
	
	@Transactional(readOnly = false)
	public void save(ActcardUnsafe actcardUnsafe) {
		super.save(actcardUnsafe);
	}
	
	@Transactional(readOnly = false)
	public void delete(ActcardUnsafe actcardUnsafe) {
		super.delete(actcardUnsafe);
	}
	
}