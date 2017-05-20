/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.risk.service.risk;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.risk.entity.risk.RiskAccess;
import com.thinkgem.jeesite.modules.risk.dao.risk.RiskAccessDao;

/**
 * riskService
 * @author lily
 * @version 2017-05-11
 */
@Service
@Transactional(readOnly = true)
public class RiskAccessService extends CrudService<RiskAccessDao, RiskAccess> {

	public RiskAccess get(String id) {
		return super.get(id);
	}
	
	public List<RiskAccess> findList(RiskAccess riskAccess) {
		return super.findList(riskAccess);
	}
	
	public Page<RiskAccess> findPage(Page<RiskAccess> page, RiskAccess riskAccess) {
		return super.findPage(page, riskAccess);
	}
	
	@Transactional(readOnly = false)
	public void save(RiskAccess riskAccess) {
		super.save(riskAccess);
	}
	
	@Transactional(readOnly = false)
	public void delete(RiskAccess riskAccess) {
		super.delete(riskAccess);
	}
	
}