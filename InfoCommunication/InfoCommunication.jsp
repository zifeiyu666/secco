<%@ page import="com.gushxue.jfs.utils.ServiceManager" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%String qiniu_url = ServiceManager.getProperties("qiniu_url", "");%>
<c:set var="qiniu_url" value="<%=qiniu_url%>"/>
<c:set var="default_title"  value="全部"/>
<!DOCTYPE html>
<html lang="en"> 
<head> 
	<meta charset="UTF-8">
	<title>信息沟通</title>
	<meta name="viewport" content="width=device-width,height=device-height,user-scalable=no,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,target-densitydpi=device-dpi" /> 
	<script type="text/javascript" src='../js/jquery-3.1.1.min.js'></script>
	<script type="text/javascript" src='../bootstrap-3.3.7/js/bootstrap.min.js'></script>
	<script src='../js/handlebars-v4.0.5.js'></script>
	<script src='../wechatcp/common.js'></script>
	<link rel="stylesheet" href="../bootstrap-3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="../css/common.css">
	<style type="text/css">
		
		.swiper-slide{
			text-align: center;
			font-size: 16px;
			/*font-weight: bold;*/
			height: 30px;
			line-height: 30px;
		}
		.swiper-wrapper .active{
			color:#173c76;
		}
		.media-heading{
			font-size: 18px;
			line-height: 20px;
		}
		.media_navHeading{
			font-size: 12px;
			color:#666;
			line-height: 15px;
		}
		.media_info{
			line-height: 15px;
			font-size: 12px;
			color:#999;
			margin-top:10px;
		}
	</style>
</head>

<!-- 列表 HTML模板 -->
<script id="entry-template" type="text/x-handlebars-template"> 
		<DIV class="listItem">
			<input type="hidden" id="{{id}}">
			<div class="title"> 
				<h2 id='listItemTitle'>{{documentTypeString}}</h2>
				<span>{{updateDateString}}</span>
			</div>
			<img width=100% src="${qiniu_url}/{{pictureUrl}}" alt="">
			<h1>{{title}}</h1>
		</DIV>
	</script>
	<!-- 搜索内容 HTML模板 -->
	<script id="entry-template02" type="text/x-handlebars-template"> 
		<div class="searchContent">
			<input type="hidden" id="{{id}}">
			<span class='title'>{{department}}</span>
			<div class='searchItem'>
				{{title}}
			</div>
			<span class="time">{{updateDateString}}</span>
		</div>
	</script>
	<!-- ajax -->
	<script>
		var token = SystemUtil.getUrlParam("token");
		//var token = '1fe47344-9af5-4112-a3d4-24a9adb6569a'
		var lastPage= true;
		// list ajax封装
		function getList(pageNumber,pageSize,homeType,documentType){
			var thisIndex = $(".sideTab .active").index('.sideTab .item')+1;
			$("#listItemTitle").val(documentType);

			jQuery.ajax({
                url: "${ctx}/api/v1/mobilehome/list?homeType="+homeType+"&pageNumber="+pageNumber+"&pageSize="+pageSize,   // 提交的页面
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
					lastPage = data.lastPage;
					console.log(data);
					for(var i =0 ;i < myData.length ; i++){
						console.log("document is "+documentType);
						console.log("documentType is "+myData[i].documentType);
						if(documentType==0||documentType==myData[i].documentType){
							var source = $("#entry-template").html();
							var template = Handlebars.compile(source);
							var compileTemplate = template(myData[i]);
							$('.wrap0'+thisIndex).append(compileTemplate);
						}

					}
					
					$(".loading").css({'display':'none'});
		        }
            });
		}

		// 获取list
		$(function(){

			// 各个tab翻页初始化参数
			var pageNumber01 = 1;
			var pageNumber02 = 1;
			var pageNumber03 = 1;
			var pageNumber04 = 1;
			var pageNumber05 = 1;
			var pageNumber06 = 1;
			var pageNumber07 = 1;
			var pageNumber08 = 1;
			var pageNumber09 = 1;

			// 赛科经验(窗口加载时当前tab获取list)
			getList(pageNumber01,20,3,0);

			// 各tab翻页公用方法
			$(window).scroll(function () {
				//最后一页提醒
				if(this.lastPage){
					if($('.lastPage').length==0){
						var lastTips = "<div class='lastPage'><h6>没有更多内容了...</h6></div>";
						$('body').append(lastTips)
					}
					
					return;
				}
				var thisIndex = $(".sideTab .active").index('.sideTab .item')+1;
				var data_document_type = $(".sideTab .active").attr('data-document-type');
		            //已经滚动到上面的页面高度
			    var scrollTop = $(this).scrollTop();
			       //页面高度
			    var scrollHeight = $(document).height();
			        //浏览器窗口高度
			    var windowHeight = $(this).height();
			       //此处是滚动条到底部时候触发的事件，在这里写要加载的数据，或者是拉动滚动条的操作
		       switch(thisIndex)
		       {
			       	case 1:
			       		if (scrollTop + windowHeight == scrollHeight) {
					       pageNumber01++;

					       $(".loading").css({'display':'block'});
					       getList(pageNumber01,20,3,data_document_type);

					    }
					    break;
				    case 2:
			       		if (scrollTop + windowHeight == scrollHeight) {
					       pageNumber02++;

					       $(".loading").css({'display':'block'});
					       getList(pageNumber02,20,3,data_document_type);

					    }
					    break;
				    case 3:
			       		if (scrollTop + windowHeight == scrollHeight) {
					       pageNumber03++;

					       $(".loading").css({'display':'block'});
					       getList(pageNumber03,20,3,data_document_type);

					    }
				    	break;
				    case 4:
			       		if (scrollTop + windowHeight == scrollHeight) {
					       pageNumber04++;

					       $(".loading").css({'display':'block'});
					       getList(pageNumber04,20,3,data_document_type);

					    }
					    break;
				    case 5:
			       		if (scrollTop + windowHeight == scrollHeight) {
					       pageNumber05++;

					       $(".loading").css({'display':'block'});
					       getList(pageNumber05,20,3,data_document_type);

					    }
					    break;
				    case 6:
			       		if (scrollTop + windowHeight == scrollHeight) {
					       pageNumber06++;

					       $(".loading").css({'display':'block'});
					       getList(pageNumber06,20,3,data_document_type);

					    }
					    break;
				    case 7:
			       		if (scrollTop + windowHeight == scrollHeight) {
					       pageNumber07++;

					       $(".loading").css({'display':'block'});
					       getList(pageNumber07,20,3,data_document_type);

					    }
					    break;
				    case 8:
			       		if (scrollTop + windowHeight == scrollHeight) {
					       pageNumber08++;

					       $(".loading").css({'display':'block'});
					       getList(pageNumber08,20,3,data_document_type);

					    }
					    break;
					case 9:
			       		if (scrollTop + windowHeight == scrollHeight) {
					       pageNumber08++;

					       $(".loading").css({'display':'block'});
					       getList(pageNumber08,20,3,data_document_type);

					    }
					    break;
		       }

			 });

			// 各tab点击切换时获取list内容方法
			$(".sideTab .item").click(function(){
				var thisIndex = $(".sideTab .active").index('.sideTab .item')+1;
				console.log(thisIndex);
				var data_document_type = $(".sideTab .active").attr('data-document-type');
				switch(thisIndex)
				{
					case 1:
						if($('.wrap0'+thisIndex).html()==''){
							getList(pageNumber01,20,3,data_document_type);
						};
						break;
					case 2:
						if($('.wrap0'+thisIndex).html()==''){
							getList(pageNumber02,20,3,data_document_type);
						};
						break;
					case 3:
						if($('.wrap0'+thisIndex).html()==''){
							getList(pageNumber03,20,3,data_document_type);
						};
						break;
					case 4:
						if($('.wrap0'+thisIndex).html()==''){
							getList(pageNumber04,20,3,data_document_type);
						};
						break;
					case 5:
						if($('.wrap0'+thisIndex).html()==''){
							getList(pageNumber05,20,3,data_document_type);
						};
						break;
					case 6:
						if($('.wrap0'+thisIndex).html()==''){
							getList(pageNumber06,20,3,data_document_type);
						};
						break;
					case 7:
						if($('.wrap0'+thisIndex).html()==''){
							getList(pageNumber07,20,3,data_document_type);
						};
						break;
					case 8:
						if($('.wrap0'+thisIndex).html()==''){
							getList(pageNumber08,20,3,data_document_type);
						};
						break;
					case 9:
						if($('.wrap0'+thisIndex).html()==''){
							getList(pageNumber08,20,3,data_document_type);
						};
						break;
				}


			})


            // 搜索list
			$(".searchWrap .SearchIcon").click(function(){

				//console.log($(".sideTab .active").attr('data-homeType'));

				var thisHomeType = $(".sideTab .active").attr('data-homeType');
				console.log(thisHomeType);
				var thisIndex = $(".sideTab .active").index('.sideTab .item')+1;
				var thisSearch = $(".searchWrap input").val();
				//console.log(thisSearch);
				//console.log(thisIndex);
				if(thisSearch != ''){
					jQuery.ajax({
		                url: "${ctx}/api/v1/mobilehome/search?homeType="+thisHomeType+"&pageNumber=1&pageSize=20&search="+thisSearch,   // 提交的页面
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
		                    //console.log(myData);
		                    //console.log($('.wrap0'+thisIndex));
		                    if(!myData || myData.length == 0){
		                    	$('.searContentWrap').html('<div style="padding:20px;font-size:16px">抱歉，没有找到匹配的结果。</div>')
		                    }else {
		                    	$('.searContentWrap').html('');
		                    	for(var i =0 ;i < myData.length ; i++){
			                    	var source = $("#entry-template02").html();
						            var template = Handlebars.compile(source);
						            var compileTemplate = template(myData[i]);
						            console.log(compileTemplate);
						            $('.searContentWrap').prepend(compileTemplate);
			                    }
		                    }


				        }
		            });
				}else{
					$('.searContentWrap').html('');
					jQuery.ajax({
		                url: "${ctx}/api/v1/mobilehome/list?homeType="+thisHomeType+"&pageNumber=1&pageSize=20",   // 提交的页面
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
		                    	var source = $("#entry-template02").html();
					            var template = Handlebars.compile(source);
					            var compileTemplate = template(myData[i]);
					            $('.searContentWrap').prepend(compileTemplate);
		                    }
				        }
		            });
				}

			})

		})



	</script>
<body>


	<!-- 侧边栏 -->
	<div class="sideTab">
		<div class="sideTabWrap">
			<div class='item active' name='all' data-homeType='3' data-document-type="0">
				<div>
					<img width=20 src="../img/quanbu@2x.png" alt="" >全部
				</div>
			</div>
			<div class='item'  data-homeType='3' name='skjy' data-document-type="3">
				<div>
					<img width=20 src="../img/saikejingyan@2x.png" alt="" >赛科经验
				</div>
			</div>
			<div class='item'  data-homeType='3' name='gsyw' data-document-type="4">
				<div>
					<img width=20 src="../img/gongsiyaowen@2x.png" alt="" >公司要闻
				</div>
			</div>
			<div class='item'  data-homeType='3' name='cxgj' data-document-type="5">
				<div>
					<img width=20 src="../img/chixugaijin@2x.png" alt="" >持续改进
				</div>
			</div>
			<div class='item'  data-homeType='3' name='hsse' data-document-type="6">
				<div>
					<img width=35 src="../img/HSSE@2x.png" alt="" >HSSE之窗
				</div>
			</div>
			<div class='item'  data-homeType='3' name='scyx' data-document-type="7">
				<div>
					<img width=20 src="../img/shichangyingxiao@2x.png" alt="" >市场营销
				</div>
			</div>
			<div class='item'  data-homeType='3' name='skmk' data-document-type="8">
				<div>
					<img width=20 src="../img/saikemiankong@2x.png" alt="" >赛科面孔
				</div>
			</div>
			<div class='item'  data-homeType='3' name='bmzq' data-document-type="9">
				<div>
					<img width=20 src="../img/bumenzhuanqu@2x.png" alt="" >部门专区
				</div>
			</div>
			<div class='item'  data-homeType='3' name='nwt' data-document-type="10">
				<div>
					<img width=20 src="../img/niwota@2x.png" alt="" >你我他
				</div>
			</div>
		</div>
		<div class="sideBarMask">
		</div>
	</div>

	
	<!-- 全部 -->
	<div class="main all activeMain"> 
		<div class="navBar">
			<span class='ListIcon'></span>
			<h1>全部</h1>
			<span class='SearchIcon'></span>
		</div>
		<div class="wrap wrap01"></div>

	</div> 

	<!-- 赛科经验 -->
	<div class="main skjy myHide"> 
		
		<div class="navBar">
			<span class='ListIcon'></span>
			<h1>赛科经验</h1>
			<span class='SearchIcon'></span>
		</div>
		<div class="wrap wrap02"></div>

	</div> 
	<!-- 公司要闻 -->
	<div class="main gsyw myHide"> 
		
		<div class="navBar">
			<span class='ListIcon'></span>
			<h1>公司要闻</h1>
			<span class='SearchIcon'></span>
		</div>
		<div class="wrap wrap03"></div>

	</div>
	<!-- 持续改进 -->
	<div class="main cxgj myHide">
		
		<div class="navBar">
			<span class='ListIcon'></span>
			<h1>持续改进</h1>
			<span class='SearchIcon'></span>
		</div>
		<div class="wrap wrap04"></div> 

	</div>
	<!-- HSSE之窗 -->
	<div class="main hsse myHide">
		 
		<div class="navBar">
			<span class='ListIcon'></span>
			<h1>HSSE之窗</h1>
			<span class='SearchIcon'></span>
		</div>
		<div class="wrap wrap05"></div>

	</div>
	<!-- 市场营销 -->
	<div class="main scyx myHide">

		<div class="navBar">
			<span class='ListIcon'></span>
			<h1>市场营销</h1>
			<span class='SearchIcon'></span>
		</div>
		<div class="wrap wrap06"></div> 

	</div>   
	<!-- 赛科面孔 -->
	<div class="main skmk myHide"> 
		<div class="navBar">
			<span class='ListIcon'></span>
			<h1>赛科面孔</h1>
			<span class='SearchIcon'></span>
		</div>
		<div class="wrap wrap07"></div>

	</div>  
	<!-- 部门专区 -->
	<div class="main bmzq myHide"> 
		<div class="navBar">
			<span class='ListIcon'></span>
			<h1>部门专区</h1>
			<span class='SearchIcon'></span>
		</div>
		<div class="wrap wrap08"></div>
	</div> 
	<!-- 你我他 -->
	<div class="main nwt myHide"> 
		<div class="navBar">
			<span class='ListIcon'></span>
			<h1>你我他</h1>
			<span class='SearchIcon'></span>
		</div>
		<div class="wrap wrap09"></div>

	</div> 

	<!-- 搜索页 -->
	<div class="searchPage">
		<div class="main search"> 
			<div class="navBar">
				<span class='backBtn'></span>
				<div class=searchWrap>
					<input type="text">
					<span class='SearchIcon'></span>
				</div>
				
			</div>
			<div class="searContentWrap"></div>

		</div> 
	</div>

	<div class="loading">
		<img src="../img/loading.gif">
	</div>
	
		
	
</body>
<script>        

  	// 进入详情页
	$(".main .listItem").click(function(){
	    window.location.href='qy-notice-communication-detail.html';
	})       

  	// 侧边栏
  	$(".ListIcon").click(function(){
  		$(".sideTab").css({"display":'block'});
  		$(".sideTabWrap").animate({"left":"0"},200);
  	})
  	$(".sideTab").click(function(){
  		$(".sideTabWrap").animate({"left":"-50%"},200,function(){
  			$(".sideTab").css({"display":"none"});
  		});
  		
  	})
  	// tab切换
  	$(".sideTab .item").click(function(){
  		$("."+$(this).attr('name') ).show().addClass('activeMain').siblings('.main').hide().removeClass('activeMain');
  		$(this).addClass('active').siblings('.item').removeClass('active');
  	})

  	// 搜索功能
  		// 搜索页面调出
  		$(".SearchIcon").click(function(){
  			$(".searchPage").animate({'left':0},200);
  			$(".activeMain").css({'display':'none'});//


  		})
  		$(".searchPage .backBtn").click(function(){
  			console.log('a');
  			$(".searchPage").animate({'left':'100%'},200);//
  			$(".activeMain").css({'display':'block'});//
  		})
	// 进入详情
	$('.wrap').delegate('.listItem','click',function(){
	  	console.log($(this).find('input').attr('id'));
	  	window.location.href='${ctx}/static/custom/secco/InfoCommunication/InfoCommunication-detail.jsp?id='+$(this).find('input').attr('id')+"&token="+token;
	  })
	$('.searContentWrap').delegate('.searchContent','click',function(){
		console.log($(this).find('input').attr('id'));
		window.location.href='${ctx}/static/custom/secco/InfoCommunication/InfoCommunication-detail.jsp?id='+$(this).find('input').attr('id')+"&token="+token;
	})
  </script>
</html>