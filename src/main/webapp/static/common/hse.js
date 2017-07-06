/**
 * 本脚本库需要依赖“jquery”脚本库
 */

/**
 * 显示隐藏子列表项
 * @param {Object} tle
 */
function showTree(tle) {
	var jqy = $(tle);
	var s = $(jqy.parents()[1].nextSibling.nextSibling);
	if(s.is(":hidden")) {
		tle.src = "/HSE/static/images/open.jpg";
		s.show();
	} else {
		tle.src = "/HSE/static/images/close.jpg";
		s.hide();
	}
}