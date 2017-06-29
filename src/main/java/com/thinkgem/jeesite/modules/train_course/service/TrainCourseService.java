/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.train_course.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.FileUtils;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.VideoConvertUtils;
import com.thinkgem.jeesite.modules.train_course.entity.TrainCourse;
import com.thinkgem.jeesite.modules.course_catelog.dao.CourseCatelogDao;
import com.thinkgem.jeesite.modules.course_catelog.entity.CourseCatelog;
import com.thinkgem.jeesite.modules.train_course.dao.TrainCourseDao;

/**
 * 培训课件Service
 * @author 王少昌
 * @version 2017-05-17
 */
@Service
@Transactional(readOnly = true)
public class TrainCourseService extends CrudService<TrainCourseDao, TrainCourse> {
	@Autowired
	private CourseCatelogDao courseCatelogDao;
	
	public TrainCourse get(String id) {
		TrainCourse trainCourse = super.get(id);
		trainCourse.setCourseCatelogList(courseCatelogDao.findList(new CourseCatelog(trainCourse)));
		return trainCourse;
	}

	
	public List<TrainCourse> findList(TrainCourse trainCourse) {
		return super.findList(trainCourse);
	}
	
	public Page<TrainCourse> findPage(Page<TrainCourse> page, TrainCourse trainCourse) {
		return super.findPage(page, trainCourse);
	}
	
	
	@Transactional(readOnly = false)
	public void save(TrainCourse trainCourse) {
		super.save(trainCourse);
		
		for (CourseCatelog courseCatelog : trainCourse.getCourseCatelogList()){
			if (courseCatelog.getId() == null){
				continue;
			}
			if (CourseCatelog.DEL_FLAG_NORMAL.equals(courseCatelog.getDelFlag())){
				if (StringUtils.isBlank(courseCatelog.getId())){
					courseCatelog.setTrainCourse(trainCourse);
					courseCatelog.preInsert();
					courseCatelogDao.insert(courseCatelog);
				}else{
					courseCatelog.preUpdate();
					courseCatelogDao.update(courseCatelog);
				}
			}else{
				courseCatelogDao.delete(courseCatelog);
			}
		}
	}
	
	@Transactional(readOnly = false)
	public void delete(TrainCourse trainCourse) {
		super.delete(trainCourse);
	}
	
	public  void videoConvert(TrainCourse trainCourse, String ServletRealPath){
		for (CourseCatelog courseCatelog : trainCourse.getCourseCatelogList()){
			if (courseCatelog.getId() == null){
				continue;
			}		
			
/*			1.第一步，首先拿到整个文件的路径，
			2.第二步，然后对于路径进行截取，截取到文件的存放目录，和文件的名称（不带文件后缀）
			3.第三步，首先进行字符串拼接得到，原始文件的存放路径，
			4.第四步，其次，判断原始文件的后缀名，如果文件的后缀名为.mp4，则不进行转码操作，如果文件名后缀不为mp4，拿到原始文件名，将其后缀改为.mp4，则进行转码操作*/
			
			
			//ServletRealPath 格式为F:\HSE2\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\HSE\
			//然而完整的文件路径为：F:\HSE2\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\HSE + userfiles\1\files\train_course\trainCourse\2017\05\movie.mp4
			String fileDir = ServletRealPath  + ".." + courseCatelog.getAttachId().substring(0,56);		//F:\HSE2\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\HSE\\userfiles\1\files\train_course\trainCourse\2017\05\
			
			//courseCatelog.getAttachId() = /HSE/userfiles/1/files/train_course/trainCourse/2017/06/movie.mp4
			String str = courseCatelog.getAttachId().split("\\/")[9];
			String fileName = str.split("\\.")[0];				//movie 
			String extension = "." + str.split("\\.")[1];				//.mp4
					
			System.out.println("###############################################" );
			System.out.println("附件路径为：" + courseCatelog.getAttachId());
			System.out.println("附件目录为：" + fileDir);
			System.out.println("文件名为：" + fileName);
			System.out.println("后缀名为路径为：" + extension);
			System.out.println("###############################################" );
			
			
			
			if(extension ==".mp4" || extension == ".MP4"){
				continue;
			}

			//拿到原文件路径
			String filePath = fileDir + fileName + extension;
			
			//设置输出文件路径 
			String codcFilePath = fileDir + fileName + ".mp4";
			
			//对数据库进行更新操作
			String newAttachId = FileUtils.getFileNameWithoutExtension(courseCatelog.getAttachId()) + ".mp4" ;
			System.out.println("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  "+ "\n" + newAttachId);
			courseCatelog.setAttachId(newAttachId);
			/*如果需要将乱码变成中文存储*/
		/*	courseCatelog.setAttachId(Encodes.urlDecode(newAttachId));*/
			
			// 获取配置的转换工具（ffmpeg.exe）的存放路径
			String ffmpegPath = ServletRealPath  + "\\tools\\ffmpeg.exe";	
			
			//获取视频时长
			/*courseCatelog.setRemarks(videoDuarationUtils.getVideoTime(filePath, ffmpegPath));
			*/
			
			//转码
			try {
				boolean flag = VideoConvertUtils.executeCodecs(ffmpegPath, filePath, codcFilePath);
				if(flag == true){
					//TODO
				}
				else{
					//TODO
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}	
	}
	
}