/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.risk.service;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.risk.dao.RiskAccessDao;
import com.thinkgem.jeesite.modules.risk.dao.RiskEnvirresultDao;
import com.thinkgem.jeesite.modules.risk.dao.RiskSaferesultDao;
import com.thinkgem.jeesite.modules.risk.entity.RiskAccess;
import com.thinkgem.jeesite.modules.risk.entity.RiskEnvirresult;
import com.thinkgem.jeesite.modules.risk.entity.RiskSaferesult;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

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
	@Autowired
	private RiskEnvirresultDao envirresultDao;
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
	/**
	 * 增加一个新的风险
	 * @param riskAccess
	 */
	@Transactional(readOnly = false)
	public void addSave(RiskAccess riskAccess) {
	
	
		riskAccess.setNumber(new Date().getTime()+"");
		riskAccess.setYears(getYears());
		riskAccess.setRecognizeDate(new Date());
		riskAccess.setRecognizeBy(UserUtils.getUser().getName());
		riskAccess.setUnit(UserUtils.getUser().getOffice().getName());
		riskAccess.setIsNewRecord(true);
		super.save(riskAccess);
	}
	/**
	 * 分析
	 * @param riskAccess
	 * @return
	 */
	@Transactional(readOnly = false)
	public void  analyse(RiskAccess riskAccess) {
		RiskSaferesult riskSaferesult=null;
		riskAccess=get(riskAccess.getId());
		riskSaferesult=riskSaferesultDao.get(riskAccess.getAccessid());
	   
		if(riskSaferesult!=null){
			riskAccess.setLscore(riskSaferesult.getLscore());
			riskAccess.setEscore(riskSaferesult.getEscore());
			riskAccess.setCscore(riskSaferesult.getCscore());
			
		}else{
			RiskEnvirresult en = envirresultDao.get(riskAccess.getAccessid());
			riskAccess.setMlscore("1");
			riskAccess.setMscore(en.getMscore());
			riskAccess.setEscore(en.getLscore());
			riskAccess.setSscore(en.getSscore());
		}

		//return riskAccess;
	}

	public String getYears(){
		Calendar calendar=Calendar.getInstance();
		calendar.setTime(new Date());
		return String.valueOf(calendar.get(Calendar.YEAR));
	}
	public void analyse_envir(RiskAccess riskAccess) {
		// TODO Auto-generated method stub
		
	}
	


	//LEC法则实现
	@Transactional(readOnly = false)
	public void doLEC(RiskAccess riskAccess) {
		
		String lscore = riskAccess.getLscore().replace(",", "");
		String escore = riskAccess.getEscore().replace(",", "");
		String cscore = riskAccess.getCscore().replace(",", "");
		float dscore = 0;
		if (lscore != null && escore != null && cscore != null && !lscore.isEmpty() && !escore.isEmpty()
				&& !cscore.isEmpty()) {
			dscore = Float.parseFloat(lscore) * Float.parseFloat(escore) * Float.parseFloat(cscore);
			RiskSaferesult entity = new RiskSaferesult();
			entity.setLscore(lscore);
			entity.setEscore(escore);
			entity.setCscore(cscore);
			entity.setDscore(dscore+"");
			entity.setRecognizeid(riskAccess.getId());
			//判断等级
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
			
			//判断是否重大风险
			if(dscore>=160){
				riskAccess.setIsHeaverisk("1");
			}else{
				riskAccess.setIsHeaverisk("0");
			}
			
			entity.setRecognizeid(riskAccess.getId());
			entity.preInsert();
			riskAccess.setAccessid(entity.getId());
			riskAccess.setRiskLevel(entity.getRiskLevel());
			//插入评价
			riskSaferesultDao.insert(entity);	
		}
	
		
		
	}
	//MS法则实现
	@Transactional(readOnly = false)
	public void doMS(RiskAccess riskAccess) {
		String mlscore = riskAccess.getMlscore().replace(",", "");
		String mscore = riskAccess.getMscore().replace(",", "");
		String sscore = riskAccess.getSscore().replace(",", "");
		String escore = riskAccess.getEscore().replace(",", "");
		float dscore = 0;
		if (mlscore != null && mlscore != null && mscore != null && !mscore.isEmpty() && !sscore.isEmpty()
				&& !sscore.isEmpty()&& !escore.isEmpty()
				&& !escore.isEmpty()) {
			if("0".equals(mlscore)){
				dscore = Float.parseFloat(mlscore) * Float.parseFloat(sscore);
			}else{
				dscore = Float.parseFloat(escore) * Float.parseFloat(mscore) * Float.parseFloat(sscore);
			}
			RiskEnvirresult entity = new RiskEnvirresult();
			entity.setLscore(escore);
			entity.setMscore(mscore);
			entity.setSscore(sscore);
			
			entity.setRecognizeid(riskAccess.getId());
			//判断等级
			if("0".equals(mlscore)){//无人身伤害
				if(dscore>=50){
					entity.setRiskLevel("5");
				}else if(dscore>=20){
					entity.setRiskLevel("4");
				}else if(dscore>=8){
					entity.setRiskLevel("3");
				}else if(dscore>=4){
					entity.setRiskLevel("2");
				}else {
					entity.setRiskLevel("1");
				}
			}else{
				if(dscore>=180){
					entity.setRiskLevel("5");
				}else if(dscore>=90){
					entity.setRiskLevel("4");
				}else if(dscore>=50){
					entity.setRiskLevel("3");
				}else if(dscore>=20){
					entity.setRiskLevel("2");
				}else {
					entity.setRiskLevel("1");
				}
			}
			
			
			//判断是否重大风险
			if(dscore>=160){
				riskAccess.setIsHeaverisk("1");
			}else{
				riskAccess.setIsHeaverisk("0");
			}
			
			entity.setRecognizeid(riskAccess.getId());
			entity.preInsert();
			riskAccess.setAccessid(entity.getId());
			riskAccess.setRiskLevel(entity.getRiskLevel());
			//插入评分
			envirresultDao.insert(entity);
		}
	
		
	}
	
}