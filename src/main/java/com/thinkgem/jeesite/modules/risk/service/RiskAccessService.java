/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.risk.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.risk.entity.RiskAccess;
import com.thinkgem.jeesite.modules.risk.entity.RiskSaferesult;
import com.thinkgem.jeesite.modules.risk.dao.RiskAccessDao;
import com.thinkgem.jeesite.modules.risk.dao.RiskSaferesultDao;

/**
 * riskService
 * @author lily
 * @version 2017-05-18
 */
@Service
@Transactional(readOnly = true)
public class RiskAccessService extends CrudService<RiskAccessDao, RiskAccess> {

	@Autowired
	private RiskSaferesultDao riskSaferesultDao;
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
		String lscore = riskAccess.getLscore();
		String escore = riskAccess.getEscore();
		String cscore = riskAccess.getCscore();
		float dscore = 0;
		//LEC的实现
		if (lscore != null && escore != null && cscore != null && !lscore.isEmpty() && !escore.isEmpty()
				&& !cscore.isEmpty()) {
			dscore = Float.parseFloat(lscore) * Float.parseFloat(escore) * Float.parseFloat(cscore);
			RiskSaferesult entity = new RiskSaferesult();
			entity.setLscore(lscore);
			entity.setEscore(escore);
			entity.setCscore(cscore);
			entity.setDscore(dscore+"");
			entity.setRecognizeid(riskAccess.getId());
			if(dscore>=320){
				entity.setRiskLevel("5");
			}else if(dscore>=160){
				entity.setRiskLevel("4");
			}else if(dscore>=70){
				entity.setRiskLevel("3");
			}else if(dscore>=20){
				entity.setRiskLevel("2");
			}else {
				entity.setRiskLevel("1");
			}
			List<RiskAccess> risk = findList(riskAccess);
			
			String id=risk.get(0).getId();
			entity.setRecognizeid(id);
			entity.preInsert();
			
			riskSaferesultDao.insert(entity);
			riskAccess.setAccessid(entity.getId());
			riskAccess.setRiskLevel(entity.getRiskLevel());
			super.save(riskAccess);
		}
	}
	
	@Transactional(readOnly = false)
	public void delete(RiskAccess riskAccess) {
		super.delete(riskAccess);
	}
	/**
	 * 得到评分
	 * @param riskAccess
	 * @return
	 */
	@Transactional(readOnly = false)
	public void  analyse(RiskAccess riskAccess) {
		RiskSaferesult riskSaferesult=null;
		
		List<RiskAccess> risk = findList(riskAccess);
		String id=risk.get(0).getAccessid();
		riskSaferesult=riskSaferesultDao.get(id);
		
		riskAccess.setRiskLevel(riskSaferesult.getRiskLevel());
		riskAccess.setLscore(riskSaferesult.getLscore());
		riskAccess.setEscore(riskSaferesult.getEscore());
		riskAccess.setCscore(riskSaferesult.getCscore());
		
		//return riskAccess;
	}
	
}