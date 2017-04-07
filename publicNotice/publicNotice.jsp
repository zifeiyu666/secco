<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width,height=device-height,user-scalable=no,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,target-densitydpi=device-dpi" /> 
	<title>通知公告</title>
</head>
<script type="text/javascript" src='../js/jquery-3.1.1.min.js'></script>
<script type="text/javascript" src='../bootstrap-3.3.7/js/bootstrap.min.js'></script>
<script src='../wechatcp/common.js'></script>
<script src='../js/handlebars-v4.0.5.js'></script>
<link rel="stylesheet" href="../bootstrap-3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="../css/common.css">

<!-- 搜索内容 HTML模板 -->
<script id="entry-template" type="text/x-handlebars-template"> 
	<div class="searchContent">
		<input type="hidden" id="{{id}}">
		<span class='title'>{{department}}</span>
		<div class='searchItem'>
			{{title}}
		</div>
		<span class="time">{{updateDateString}}</span>
	</div>
</script>


<body>
	<div class="searchPage" style='right:0;overflow-y: auto;position: relative;'>
		<div class="main search "> 
			<div class="navBar">
				<div class='searchWrap' style='padding-right:40px'>
					<input type="text">
					<span class='SearchIcon' style='right:50px'></span>
				</div>
				
			</div>
			<div class="searContentWrap">

			</div>

		</div> 
	</div>
	
	<div class="loading">
		<img src="../img/loading.gif">
	</div>
	

</body>
<script>
	var lastPage= true;
	var token = SystemUtil.getUrlParam("token");
	//var token ='1fe47344-9af5-4112-a3d4-24a9adb6569a'
	// list ajax封装
	function getList(pageNumber,pageSize,homeType,documentType){
		var thisIndex = $(".sideTab .active").index('.sideTab .item')+1;
		jQuery.ajax({
            url: "${ctx}/api/v1/mobilehome/list?homeType="+homeType+"&pageNumber="+pageNumber+"&pageSize="+pageSize,   // 提交的页面
            contentType:"application/x-www-form-urlencoded; charset=UTF-8",
            headers: {'authentication':token},
            type: "GET",                   // 设置请求类型为"POST"，默认为"GET"
            async:true,
            error: function(request) {      // 设置表单提交出错
                // $.jGrowl('审核失败.', { sticky: true, theme: 'growl-error', header: 'Error!' });
                console.log('error');
            },
            success: function(data) {
                // $.jGrowl('审核成功.', { sticky: true, theme: 'growl-success', header: 'Success!' });
                // location.reload();
				console.log('success');
				console.log('token:'+token);
				var myData=data.content;
				lastPage = data.lastPage; //判断是不是最后一页
				console.log(data);
				for(var i =0 ;i < myData.length ; i++){
					var source = $("#entry-template").html();
					var template = Handlebars.compile(source);
					var compileTemplate = template(myData[i]);
					$('.searContentWrap').append(compileTemplate);
				}
				
				$(".loading").css({'display':'none'});
	        }
        });
	}
	getList(1,20,2);

	// 翻页
	var pageNumber=1; //存储页码
	$(window).scroll(function () {
		//最后一页提醒
		if(this.lastPage){
			if($('.lastPage').length==0){
				var lastTips = "<div class='lastPage'><h6>没有更多内容了...</h6></div>";
				$('body').append(lastTips)
			}
			
			return;
		}

            //已经滚动到上面的页面高度
	    var scrollTop = $(this).scrollTop();
	       //页面高度
	    var scrollHeight = $(document).height();
	        //浏览器窗口高度
	    var windowHeight = $(this).height();
	       //此处是滚动条到底部时候触发的事件，在这里写要加载的数据，或者是拉动滚动条的操作
	    if (scrollTop + windowHeight == scrollHeight) {
	       pageNumber++; //滚动到底部之后，页码加一
	       console.log('fanyue')
	       $(".loading").css({'display':'block'});
	       getList(pageNumber,20,3); //加载新页面的内容

	    }
});

// 搜索
$(function(){
	// 搜索list
	$(".SearchIcon").click(function(){


		var thisSearch = $(".searchWrap input").val();
		console.log(thisSearch);
		//console.log(thisIndex);
		if(thisSearch != ''){
			jQuery.ajax({
                url: "${ctx}/api/v1/mobilehome/search?homeType=2&pageNumber=1&pageSize=20&search="+thisSearch,   // 提交的页面
                contentType:"application/x-www-form-urlencoded; charset=UTF-8",
                headers: {'authentication':token},
                type: "GET",                   // 设置请求类型为"POST"，默认为"GET"
                async:true,
                error: function(request) {      // 设置表单提交出错
                    // $.jGrowl('审核失败.', { sticky: true, theme: 'growl-error', header: 'Error!' });
                },
                success: function(data) {
                    // $.jGrowl('审核成功.', { sticky: true, theme: 'growl-success', header: 'Success!' });
                    // location.reload();
                    console.log('search:success');
                    console.log('search:'+data);
                    var myData=data.content;
                    console.log(myData);
                    //console.log($('.wrap0'+thisIndex));
                    if(!myData || myData.length == 0){  
                    	$('.searContentWrap').html('<div style="padding:20px;font-size:16px">抱歉，没有找到匹配的结果。</div>')
                    }else {
                    	$('.searContentWrap').html('');
                    	for(var i =0 ;i < myData.length ; i++){
	                    	var source = $("#entry-template").html();
				            var template = Handlebars.compile(source);
				            var compileTemplate = template(myData[i]);
				            console.log(compileTemplate);
				            $('.searContentWrap').prepend(compileTemplate);
	                    }
                    }


		        }
            });
		}else{ //搜索关键字为空的情况下，点击搜索返回全部内容；
			$('.searContentWrap').html('');
			jQuery.ajax({
                url: "${ctx}/api/v1/mobilehome/list?homeType=2&pageNumber=1&pageSize=20",   // 提交的页面
                contentType:"application/x-www-form-urlencoded; charset=UTF-8",
                headers: {'authentication':token},
                type: "GET",                   // 设置请求类型为"POST"，默认为"GET"
                async:true,
                error: function(request) {      // 设置表单提交出错
                    // $.jGrowl('审核失败.', { sticky: true, theme: 'growl-error', header: 'Error!' });
                },
                success: function(data) {
                    // $.jGrowl('审核成功.', { sticky: true, theme: 'growl-success', header: 'Success!' });
                    // location.reload();
                    console.log('success');
                    var myData=data.content;
                    console.log(data);
                    for(var i =0 ;i < myData.length ; i++){
                    	var source = $("#entry-template").html();
			            var template = Handlebars.compile(source);
			            var compileTemplate = template(myData[i]);
			            $('.searContentWrap').prepend(compileTemplate);
                    }
		        }
            });
		}

	})
})

// 进入详情
$('.searContentWrap').delegate('.searchContent','click',function(){
	console.log($(this).find('input').attr('id'));
	window.location.href='${ctx}/static/custom/secco/publicNotice/publicNotice-detail.jsp?token='+token+'&id='+$(this).find('input').attr('id');
})

</script>
</html>

