<%@ page contentType="text/html;charset=UTF-8" %>
	<div class="control-group">
			<label class="control-label">文件路径：</label>
			<input type="hidden" name="moduls_name"  value="{}"  /> 
			<div class="controls">
				<input type="hidden" id="filePath" name="filePath" class="input-xlarge"/>
				<sys:ckfinder input="filePath" type="files" uploadPath="/zsk/zskDocument" selectMultiple="true"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
