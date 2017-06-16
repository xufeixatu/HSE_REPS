/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.adm.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 管理员Entity
 * @author 小文
 * @version 2017-05-21
 */
public class ShopAdmin extends DataEntity<ShopAdmin> {
	
	private static final long serialVersionUID = 1L;
	private String shopAdminId;		// shop_admin_id
	private String shopAdminName;		// shop_admin_name
	private String shopAdminPassword;		// shop_admin_password
	
	public ShopAdmin() {
		super();
	}

	public ShopAdmin(String id){
		super(id);
	}

	@Length(min=1, max=100, message="shop_admin_id长度必须介于 1 和 100 之间")
	public String getShopAdminId() {
		return shopAdminId;
	}

	public void setShopAdminId(String shopAdminId) {
		this.shopAdminId = shopAdminId;
	}
	
	@Length(min=0, max=20, message="shop_admin_name长度必须介于 0 和 20 之间")
	public String getShopAdminName() {
		return shopAdminName;
	}

	public void setShopAdminName(String shopAdminName) {
		this.shopAdminName = shopAdminName;
	}
	
	@Length(min=0, max=20, message="shop_admin_password长度必须介于 0 和 20 之间")
	public String getShopAdminPassword() {
		return shopAdminPassword;
	}

	public void setShopAdminPassword(String shopAdminPassword) {
		this.shopAdminPassword = shopAdminPassword;
	}
	
}