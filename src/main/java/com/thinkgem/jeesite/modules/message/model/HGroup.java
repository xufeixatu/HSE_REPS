package com.thinkgem.jeesite.modules.message.model;

import java.io.Serializable;

public class HGroup implements Serializable{
	/**
	 * @author jiachao
	 */
	private static final long serialVersionUID = 1L;
	private String groupId;
	private String groupName;
	private String avatarUrl;
	private String avatarUrlNative;
	private String avatarFile;
	private String groupTime;
	private String groupText;
	private String remark;
	
	
	public HGroup() {
		super();
	}
	public HGroup(String groupId, String groupName, String avatarUrl,
			String avatarUrlNative, String avatarFile, String groupTime,
			String groupText, String remark) {
		super();
		this.groupId = groupId;
		this.groupName = groupName;
		this.avatarUrl = avatarUrl;
		this.avatarUrlNative = avatarUrlNative;
		this.avatarFile = avatarFile;
		this.groupTime = groupTime;
		this.groupText = groupText;
		this.remark = remark;
	}
	public String getGroupId() {
		return groupId;
	}
	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}
	public String getGroupName() {
		return groupName;
	}
	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}
	public String getAvatarUrl() {
		return avatarUrl;
	}
	public void setAvatarUrl(String avatarUrl) {
		this.avatarUrl = avatarUrl;
	}
	public String getAvatarUrlNative() {
		return avatarUrlNative;
	}
	public void setAvatarUrlNative(String avatarUrlNative) {
		this.avatarUrlNative = avatarUrlNative;
	}
	public String getAvatarFile() {
		return avatarFile;
	}
	public void setAvatarFile(String avatarFile) {
		this.avatarFile = avatarFile;
	}
	public String getGroupTime() {
		return groupTime;
	}
	public void setGroupTime(String groupTime) {
		this.groupTime = groupTime;
	}
	public String getGroupText() {
		return groupText;
	}
	public void setGroupText(String groupText) {
		this.groupText = groupText;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	@Override
	public String toString() {
		return "Group [groupId=" + groupId + ", groupName=" + groupName
				+ ", avatarUrl=" + avatarUrl + ", avatarUrlNative="
				+ avatarUrlNative + ", avatarFile=" + avatarFile
				+ ", groupTime=" + groupTime + ", groupText=" + groupText
				+ ", remark=" + remark + "]";
	}

	
	
}
