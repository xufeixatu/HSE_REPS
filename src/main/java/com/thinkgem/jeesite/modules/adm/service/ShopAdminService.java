/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.adm.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.adm.entity.ShopAdmin;
import com.thinkgem.jeesite.modules.adm.dao.ShopAdminDao;

/**
 * 管理员Service
 * @author 小文
 * @version 2017-05-21
 */
@Service
@Transactional(readOnly = true)
public class ShopAdminService extends CrudService<ShopAdminDao, ShopAdmin> {

	public ShopAdmin get(String id) {
		return super.get(id);
	}
	
	public List<ShopAdmin> findList(ShopAdmin shopAdmin) {
		return super.findList(shopAdmin);
	}
	
	public Page<ShopAdmin> findPage(Page<ShopAdmin> page, ShopAdmin shopAdmin) {
		return super.findPage(page, shopAdmin);
	}
	
	@Transactional(readOnly = false)
	public void save(ShopAdmin shopAdmin) {
		super.save(shopAdmin);
	}
	
	@Transactional(readOnly = false)
	public void delete(ShopAdmin shopAdmin) {
		super.delete(shopAdmin);
	}
	
}