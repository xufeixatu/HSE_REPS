		

		/*
		生成一级菜单
		*/
		function createFirstMenu(parentul,name){
			var span1 = $("<span></span>").attr("class","nav-label").text(name);
			var span2 = $("<span></span>").attr("class","fa arrow");
			var a = $("<a></a>").attr("href","#").append(span1).append(span2);
			var li = $("<li></li>").append(a);
			parentul.append(li);
			return li;
		}
		
		/*
		生成二级菜单
		*/
		function createSecondMenu(parentli,ul_second,name){
			var ul_second_span = $("<span></span>").attr("class","fa arrow");
			var ul_second_a = $("<a></a>").text(name).attr("href","#").append(ul_second_span);
			var ul_second_li = $("<li></li>").append(ul_second_a);
			ul_second.append(ul_second_li);
			parentli.append(ul_second);
			return ul_second_li;
		}
		
		/*
		生成三级菜单
		*/
		function createThirdMenu(parentli,ul_third,href,name){
			var ul_third_li_a = $("<a></a>").attr({"class":"J_menuItem","href":href}).text(name);
			var ul_third_li = $("<li></li>").append(ul_third_li_a);
			ul_third.append(ul_third_li);
			parentli.append(ul_third);
		}
		