$(function(){
		$(".pimg").click(function(){
			var _this = $(this);//将当前的pimg元素作为_this传入函数
			imgShow("#outerdiv", "#innerdiv", "#bigimg", _this);
		});
	});
		function imgShow(outerdiv, innerdiv, bigimg, _this){
	var src = _this.attr("src");//获取当前点击的pimg元素中的src属性
	$(bigimg).attr("src", src);//设置#bigimg元素的src属性

        /*获取当前点击图片的真实大小，并显示弹出层及大图*/
	$("<img/>").attr("src", src).load(function(){
		var windowW = $(window).width();//获取当前窗口宽度
		var windowH = $(window).height();//获取当前窗口高度
		var realWidth = this.width;//获取图片真实宽度
		var realHeight = this.height;//获取图片真实高度
		var imgWidth, imgHeight;
		var scale = 0.8;//缩放尺寸，当图片真实宽度和高度大于窗口宽度和高度时进行缩放
		
		if(realHeight>windowH*scale) {//判断图片高度
			imgHeight = windowH*scale;//如大于窗口高度，图片高度进行缩放
			imgWidth = imgHeight/realHeight*realWidth;//等比例缩放宽度
			if(imgWidth>windowW*scale) {//如宽度扔大于窗口宽度
				imgWidth = windowW*scale;//再对宽度进行缩放
			}
		} else if(realWidth>windowW*scale) {//如图片高度合适，判断图片宽度
			imgWidth = windowW*scale;//如大于窗口宽度，图片宽度进行缩放
                        imgHeight = imgWidth/realWidth*realHeight;//等比例缩放高度
		} else {//如果图片真实高度和宽度都符合要求，高宽不变
			imgWidth = realWidth;
			imgHeight = realHeight;
		}
                $(bigimg).css("width",imgWidth);//以最终的宽度对图片缩放
		
		var w = (windowW-imgWidth)/2;//计算图片与窗口左边距
		var h = (windowH-imgHeight)/2;//计算图片与窗口上边距
		$(innerdiv).css({"top":h, "left":w});//设置#innerdiv的top和left属性
		$(outerdiv).fadeIn("fast");//淡入显示#outerdiv及.pimg
	});
	
	$(outerdiv).click(function(){//再次点击淡出消失弹出层
		$(this).fadeOut("fast");
	});
}

function copyMemo()
{
	switch($('#memoList1').val()){
			case '1':
					$("#memoList2").empty();
					$("#memoList2").append("<option value=''>请选择</option>"); 
					$("#memoList2").append("<option value='真实有效'>真实有效</option>"); 
					$("#memoList2").append("<option value='虚假'>虚假</option>"); 
					break;
			case '2':
					$("#memoList2").empty();
					$("#memoList2").append("<option value=''>请选择</option>"); 
					break;
			case '3':
					$("#memoList2").empty();
					$("#memoList2").append("<option value=''>请选择</option>"); 
					$("#memoList2").append("<option value='网查无信息'>网查无信息</option>"); 
					$("#memoList2").append("<option value='网查信息一致'>网查信息一致</option>");
					$("#memoList2").append("<option value='网查信息不一致'>网查信息不一致</option>");
					$("#memoList2").append("<option value='网查负面信息'>网查负面信息</option>");
					break;
			case '4':
					$("#memoList2").empty();
					$("#memoList2").append("<option value=''>请选择</option>"); 
					$("#memoList2").append("<option value='114无信息'>114无信息</option>"); 
					$("#memoList2").append("<option value='114 电话地址均一致'>114 电话地址均一致</option>");
					$("#memoList2").append("<option value='114 电话一致地址不一致'>114 电话一致地址不一致</option>");
					$("#memoList2").append("<option value='114 电话不一致地址一致'>114 电话不一致地址一致</option>");
					$("#memoList2").append("<option value='114 电话地址均不一致'>114 电话地址均不一致</option>");
					break;
			case '5':
					$("#memoList2").empty();
					$("#memoList2").append("<option value=''>请选择</option>"); 
					$("#memoList2").append("<option value='机主名与地址均一致'>机主名与地址均一致</option>"); 
					$("#memoList2").append("<option value='机主名一致，地址不一致'>机主名一致，地址不一致</option>");
					$("#memoList2").append("<option value='机主名不一致，地址一致'>机主名不一致，地址一致</option>");
					$("#memoList2").append("<option value='机主名与地址均不一致'>机主名与地址均不一致</option>");
					break;
			case '6':
					$("#memoList2").empty();
					$("#memoList2").append("<option value=''>请选择</option>"); 
					$("#memoList2").append("<option value='信息确认'>信息确认</option>"); 
					$("#memoList2").append("<option value='涉嫌欺诈'>涉嫌欺诈</option>");
					$("#memoList2").append("<option value='验证失败'>验证失败</option>");
					$("#memoList2").append("<option value='其他'>其他</option>");
					break;
			case '7':
					$("#memoList2").empty();
					$("#memoList2").append("<option value=''>请选择</option>"); 
					$("#memoList2").append("<option value='信息确认'>信息确认</option>"); 
					$("#memoList2").append("<option value='涉嫌欺诈'>涉嫌欺诈</option>");
					$("#memoList2").append("<option value='验证失败'>验证失败</option>");
					$("#memoList2").append("<option value='无人接听或占线'>无人接听或占线</option>");
					$("#memoList2").append("<option value='其他'>其他</option>");
					break;
			case '8':
					$("#memoList2").empty();
					$("#memoList2").append("<option value=''>请选择</option>"); 
					$("#memoList2").append("<option value='信息确认'>信息确认</option>"); 
					$("#memoList2").append("<option value='涉嫌欺诈'>涉嫌欺诈</option>");
					$("#memoList2").append("<option value='验证失败'>验证失败</option>");
					$("#memoList2").append("<option value='无人接听或占线'>无人接听或占线</option>");
					$("#memoList2").append("<option value='其他'>其他</option>");
					break;
			case '9':
					$("#memoList2").empty();
					$("#memoList2").append("<option value=''>请选择</option>"); 
					$("#memoList2").append("<option value='信息确认'>信息确认</option>"); 
					$("#memoList2").append("<option value='涉嫌欺诈'>涉嫌欺诈</option>");
					$("#memoList2").append("<option value='验证失败'>验证失败</option>");
					$("#memoList2").append("<option value='其他'>其他</option>");
					break;
			case '10':
					$("#memoList2").empty();
					$("#memoList2").append("<option value=''>请选择</option>"); 
					$("#memoList2").append("<option value='信息确认'>信息确认</option>"); 
					$("#memoList2").append("<option value='涉嫌欺诈'>涉嫌欺诈</option>");
					$("#memoList2").append("<option value='验证失败'>验证失败</option>");
					$("#memoList2").append("<option value='无人接听或占线'>无人接听或占线</option>");
					$("#memoList2").append("<option value='其他'>其他</option>");
					break;
			case '11':
					$("#memoList2").empty();
					$("#memoList2").append("<option value=''>请选择</option>"); 
					$("#memoList2").append("<option value='满意'>满意</option>"); 
					$("#memoList2").append("<option value='不满意'>不满意</option>");
					$("#memoList2").append("<option value='其他'>其他</option>");
					break;
			case '12':
					$("#memoList2").empty();
					$("#memoList2").append("<option value=''>请选择</option>"); 
					$("#memoList2").append("<option value='满意'>满意</option>"); 
					$("#memoList2").append("<option value='不满意'>不满意</option>");
					$("#memoList2").append("<option value='其他'>其他</option>");
					break;
			case '13':
					$("#memoList2").empty();
					$("#memoList2").append("<option value=''>请选择</option>"); 
					break;

			default:
					$("#memoList2").empty();
					$("#memoList2").append("<option value=''>请选择</option>"); 
					break;
		}
}