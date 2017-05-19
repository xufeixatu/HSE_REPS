package com.thinkgem.jeesite.modules.message.model;


import java.io.Serializable;

public class HUser implements Serializable {
	/**
	 * @author jiachao
	 */
	private static final long serialVersionUID = 1L;
	private String userId;
	private String userName;
	private String loginName;
	private String password;
	private String avatarUrl;
	private String avatarUrlNative;
	private String avatarFile;
	private String groupId;
	private String token;
	private String remark;
	
	
	
	public HUser() {
		super();
	}
	public HUser(String userId, String userName, String loginName,
			String password, String avatarUrl, String avatarUrlNative,
			String avatarFile, String groupId, String token, String remark) {
		super();
		this.userId = userId;
		this.userName = userName;
		this.loginName = loginName;
		this.password = password;
		this.avatarUrl = avatarUrl;
		this.avatarUrlNative = avatarUrlNative;
		this.avatarFile = avatarFile;
		this.groupId = groupId;
		this.token = token;
		this.remark = remark;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getLoginName() {
		return loginName;
	}
	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
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
	public String getGroupId() {
		return groupId;
	}
	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}
	public String getToken() {
		return token;
	}
	public void setToken(String token) {
		this.token = token;
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
		return "User [userId=" + userId + ", userName=" + userName
				+ ", loginName=" + loginName + ", password=" + password
				+ ", avatarUrl=" + avatarUrl + ", avatarUrlNative="
				+ avatarUrlNative + ", avatarFile=" + avatarFile + ", groupId="
				+ groupId + ", token=" + token + ", remark=" + remark + "]";
	}
}
