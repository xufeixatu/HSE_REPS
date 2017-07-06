package com.thinkgem.jeesite.modules.zsk.api;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;
/**
 * 知识库上传通用接口
 * @author guo
 *
 */
public interface ZskCommonUpload {
	
	/**
	 * 获得MultipartFile file对象和文件所属于的模块fileType 然后保存到知识库
	 * @param file 上传文件类型为MultipartFile
	 * @param fileType 上传文件的文件模块名  比如安全管理
	 * @param request
	 * @return 知识库ID
	 * @throws Exception 
	 */
	public String fileUpload(MultipartFile file,String fileType,HttpServletRequest request) throws Exception;
	
	/**
	 * 通过知识库ID获得取文件下载路径
	 * @param id 知识库ID
	 * @return 文件路径
	 */
	public String getfileWithID(String id);
		
	
}
