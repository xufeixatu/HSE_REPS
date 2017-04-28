<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<%@ attribute name="moduls_name" type="java.lang.String" required="false" description="模块名字"%>
<div class="control-group">
	<label class="control-label">文件路径：</label> <input type="hidden"
		name="moduls_name" value="${moduls_name}" />
	<div class="controls">
		<input type="hidden" id="filePath" name="filePath"
			class="input-xlarge" />
		<sys:ckfinder input="filePath" type="files"
			uploadPath="/zsk/zskDocument" selectMultiple="true" />
		<span class="help-inline"><font color="red">*</font> </span>
	</div>
</div>
