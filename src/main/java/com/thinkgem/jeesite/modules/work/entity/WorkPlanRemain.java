package com.thinkgem.jeesite.modules.work.entity;

import java.util.Date;

public class WorkPlanRemain {
	private String id;
	private String remainDesc;
	private String remainnerId;
	private String remainDeptId;
	private String workPlanId;
	private String delFlag;
	private String remark;
	private Date updateDate;
	private String updateBy;
	private Date createDate;
	private String createBy;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getRemainDesc() {
		return remainDesc;
	}
	public void setRemainDesc(String remainDesc) {
		this.remainDesc = remainDesc;
	}
	public String getRemainnerId() {
		return remainnerId;
	}
	public void setRemainnerId(String remainnerId) {
		this.remainnerId = remainnerId;
	}
	public String getRemainDeptId() {
		return remainDeptId;
	}
	public void setRemainDeptId(String remainDeptId) {
		this.remainDeptId = remainDeptId;
	}
	public String getWorkPlanId() {
		return workPlanId;
	}
	public void setWorkPlanId(String workPlanId) {
		this.workPlanId = workPlanId;
	}
	public String getDelFlag() {
		return delFlag;
	}
	public void setDelFlag(String del_flag) {
		this.delFlag = del_flag;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public Date getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}
	public String getUpdateBy() {
		return updateBy;
	}
	public void setUpdateBy(String updateBy) {
		this.updateBy = updateBy;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}
	
}
