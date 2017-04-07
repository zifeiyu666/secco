<%@ page import="com.gushxue.jfs.utils.ServiceManager" %>
<%@ page import="com.gushxue.common.date.DateFormatUtil" %>
<%@ page import="java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%String qiniu_url = ServiceManager.getProperties("qiniu_url", "");%>
<c:set var="qiniu_url" value="<%=qiniu_url%>"/>
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
	<link rel="stylesheet" href="../css/swiper.min.css">
	<link rel="stylesheet" href="../bootstrap-3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="../css/common.css">
	<style type="text/css">

		.discuss{
			margin-top:15px;
			background: #fff;
			padding:0 10px;
		}
		.disList{
			border-bottom: 1px solid #ccc;
			margin-top: 15px;
		}
		.discuss .disHeader{
			padding:20px 0;
			border-bottom: 1px solid #ccc;
		}
		.discuss .disHeader span{
			display:inline-block;
			font-size: 18px;
			line-height: 24px;
			font-weight: bold;
			margin-bottom: 20px;
			padding-left:20px;
			color:#ff9900;
			border-left:4px solid #ff9900;
		}
		.discuss .media-body{
			padding-top:10px;
		}
		.discuss .media-body .media-heading{
			font-size: 16px;
			font-weight: bold;
			color:#666;
		}
		.disBody{
			padding:10px;
			color:#666;
			line-height: 24px;
			font-size: 16px;
		}
		.disFeedback{
			padding:0px 20px;
		}
		.disFeedback h4{
			font-size: 14px;
			font-weight: normal;
			padding-left: 10px;
			margin:10px 0;
			line-height: 20px;
			border-left: 2px solid #ccc;
		}
		.disFeedback p{
			font-size: 12px;
			padding:0 10px;
		}
		.loading{
			bottom: 50px;
			z-index: 100;
		}
	</style>
	<!--详情 handlebar 模板 -->
	<script id="entry-template" type="text/x-handlebars-template"> 
		<div class='detail'>
			<input type="hidden" data-comment={{canComment}} data-transfer={{canTransfer}}>
			<div class="detail_header">
				<h2>{{title}}</h2>
				<span>[ {{department}} ] {{updateDateString}}</span>
			</div>
			<div class="detail_body">
				<div>{{{content}}}</div>
			</div>

			<div class='zan'>
				<span id="zanBtn" class='zanWrap' ><img height=20 src="../img/dianzan@2x.png"><span id='zanNum'>{{userCommentCountVO.goodCommentCount}}</span></span>
				<h4 >点个赞再走呗！</h4>
			</div>
			
		</div>
	</script>
						<!--评论 handlebar 模板 -->
					<script id="entry-template02" type="text/x-handlebars-template">
							<div class="disList">
							<div class="media">
							<div class="media-left">
							<a href="#">
							<img class="media-object" src="../img/touxiang.png" width="60" alt="...">
							</a>
							</div>
							<div class="media-body">
							<h4 class="media-heading">{{userName}}</h4>
				<span class='media_navHeading'>{{department}}</span>
				</div>
				<div class="media-right media_navHeading">
				<span style="position: relative;top: 35px;width:140px;display:inline-block">{{createDate}}</span>
		<!-- <button class='btn btn-default btn-sm pull-right' data-toggle="modal" data-target="#myModal" style='margin-top:5px'>回复</button> -->
				</div>

				</div>
				<p class='disBody'>{{{comment}}}</p>
		</div>
	</script>
	<!-- ajax -->
	<script>
		var canComment=true;
		function GetQueryString(name)
		{
			var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
			var r = window.location.search.substr(1).match(reg);
			if(r!=null)return  unescape(r[2]); return null;
		}
		// 获取前一页面的list ID；
		var myId = GetQueryString("id");
		console.log(myId);
		//var token = SystemUtil.getUrlParam("token");
		var token = '6c6dfcb0-7c57-4e50-a2f8-94ac625df3a8';
		$(function(){
			// 获取详情
			jQuery.ajax({
				url: "${ctx}/api/v1/mobilehome/detail?id="+myId,   // 提交的页面
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
                    console.log(data);
                    console.log(data.id);
                    console.log(data.type);
                    // 编译详情页html模板
                    var source = $("#entry-template").html();
		            var template = Handlebars.compile(source);
		            var compileTemplate = template(data);
		            // 加载详情页
		            $('.datailWrap').append(compileTemplate);
		            // 判断点赞数量
		            if(!$('#zanNum').text()){
			   			$('#zanNum').text(0);
			   		}
		            // 判断是否有评论
					this.canComment = data.canComment==1;
					if(!this.canComment){
						$("#div_footer").hide();
					}
		            if(data.canComment == 1){
		            	// 获取评论内容
		            	var lastPage= true;
		            	var pageSize=20,pageNumber=1;

		            	
		            	jQuery.ajax({
			                url: "${ctx}/api/v1/comments?thirdPartId="+myId+"&thirdPartType="+data.type+"&pageSize="+pageSize+"&pageNumber="+pageNumber,   // 提交的页面
			                contentType:"application/x-www-form-urlencoded; charset=UTF-8",
			                headers: {'authentication':token},
			                type: "GET",                   // 设置请求类型为"POST"，默认为"GET"
			                async:true,
			                error: function(request) {      // 设置表单提交出错
			                    console.log('error');
			                },
			                success: function(data) {
			                    console.log('success');
			                    console.log("data.content:"+data.content);
			                    var myData = data.content;
			                    // 编译评论html模板
			                    var source = $("#entry-template02").html();
		            			var template = Handlebars.compile(source);
		            			// 加载评论内容
			                    if(myData.length!=0){
			                    	for( var i=0; i<myData.length; i++){
			                    		var compileTemplate = template(myData[i]);
			                    		$(".disWrap").append(compileTemplate);
				                    }
			                    }

			                    lastPage = data.lastPage;

			                    // 隐藏加载动画
			                    $(".loading").css({'display':'none'});
			                    
					        }
			            });
			            $(window).scroll(function () {
			            	var scrollTop = $(this).scrollTop();
						       //页面高度
						    var scrollHeight = $(document).height();
						        //浏览器窗口高度
						    var windowHeight = $(this).height();

		            		//最后一页提醒()
							if(this.lastPage){
								if($('.lastPage').length==0){
									var lastTips = "<div class='lastPage'><h6>没有更多内容了...</h6></div>";
									$('body').append(lastTips)
								}
								
								return;
							}
							// 翻页
							if (scrollTop + windowHeight == scrollHeight) {
						       pageNumber++;

						       $(".loading").css({'display':'block'});
						       jQuery.ajax({
					                url: "${ctx}/api/v1/comments?thirdPartId="+myId+"&thirdPartType="+data.type+"&pageSize="+pageSize+"&pageNumber="+pageNumber,   // 提交的页面
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
					                    console.log(data);
					                    var myData = data.content;
					                    // 编译评论html模板
					                    var source = $("#entry-template02").html();
				            			var template = Handlebars.compile(source);
				            			// 加载评论内容
					                    if(myData.length!=0){
					                    	for( var i=0; i<myData.length; i++){
					                    		var compileTemplate = template(myData[i]);
					                    		$(".disWrap").append(compileTemplate);
						                    }
					                    }

					                    // 隐藏加载动画
					                    $(".loading").css({'display':'none'});
					                    
							        }
					            });

						    }
		            	})
		            }
		        }
            });
		})

		// 返回
		$(function(){
			// 这里添加token;
		   $("#backBtn").click(function(){
		   	window.location.href='InfoCommunication.jsp?token='+token;
		   })
		})
		
	</script>
</head>
<body>
	<div class="navBar" >
		<h1>详情</h1>
		<img class="left" id='backBtn' src='../img/fanhui@2x.png' width=12></img>
	</div>
	
	<div class="main"> <!-- 主体内容 -->
		<div class="datailWrap"></div>

		<div class="discuss">
			<h2 class="disHeader">
				<span>最新评论</span>
			</h2>
			<div class="disWrap"></div>
		</div>

	</div> <!-- 主题内容结束 -->




	<div class="footer" id="div_footer">
		<div class='row' id="searchWrap">
			<div class='col-xs-10' style='padding:10px 20px'>
				<input class='form-control' type="text" placeholder="评论..." style='width:90%;margin-left:10px'>
			</div>
			<div class="col-xs-2" style='padding:10px 20px'>
				<button id='disSubmit' class="btn btn-primary pull-right" style='margin-right:10px'>发布</button>
			</div>
			
		</div>
	</div>

	<div class="loading">
		<img src="../img/loading.gif">
	</div>

</body>
<script type="text/javascript" src='js/conmmon.js'></script>
<script>        

   // 点赞
   var bTrue=true;
   var data = '';
   $('.datailWrap').delegate('#zanBtn','click',function(){

   		
   		
   		//if(bTrue){
	   		data = parseInt($('#zanNum').text())+1;
	   		$('#zanNum').html(data)
//	   	}else{
//	   		data = parseInt($('#zanNum').text())-1;
//	   		$('#zanNum').html(data)
//	   	}
	   	console.log("点赞数："+$('#zanNum').text());
//	   	bTrue=!bTrue;

	   	var myData={"comment":"","thirdPartId":myId,"thirdPartType":"3" ,"commentType":"1"};
	   	myData.comment=data;
	   	jQuery.ajax({
            url: "${ctx}/api/v1/comments/newComment",
            contentType:"application/x-www-form-urlencoded; charset=UTF-8",
            headers: {'authentication':token},
            type: "POST",                   // 设置请求类型为"POST"，默认为"GET"
            async:true,
            data:myData,
            error: function(request) {      // 设置表单提交出错
                // $.jGrowl('审核失败.', { sticky: true, theme: 'growl-error', header: 'Error!' });
            },
            success: function(data) {
                // $.jGrowl('审核成功.', { sticky: true, theme: 'growl-success', header: 'Success!' });
                // location.reload();
                console.log('dis01success'); 
	        }
        });

   })


   
   // 评论提交及前台新增显示

   $("#disSubmit").click(function(){

   		// 前台显示
   		// 通过token获取当前用户的信息
	   var adminData={
		   'userName':'',
		   'department':'',
		   'comment':"",
		   'createDate':'<%=DateFormatUtil.getLocalDate(new Date(System.currentTimeMillis()))%>'
	   }
   		adminData.comment="<span style='color:red'>[待审批]</span>"+$('#searchWrap input').val();
   		// 编译评论html模板
        var source = $("#entry-template02").html();
		var template = Handlebars.compile(source);
		// 添加内容
   		var compileTemplate = template(adminData);
		$(".disWrap").append(compileTemplate);

   		// 评论内容提交后台审核
   		var myData={"comment":$('#searchWrap input').val(),"thirdPartId":myId,"thirdPartType":"3" ,"commentType":"0"};
	   	myData.comment=$('#searchWrap input').val();


	   	console.log("评论内容:"+$('#searchWrap input').val());
   		jQuery.ajax({
            url: "${ctx}/api/v1/comments/newComment",
            contentType:"application/x-www-form-urlencoded; charset=UTF-8",
            headers: {'authentication':token},
            type: "POST",                   // 设置请求类型为"POST"，默认为"GET"
            async:true,
            data:myData,
            error: function(request) {      // 设置表单提交出错
                // $.jGrowl('审核失败.', { sticky: true, theme: 'growl-error', header: 'Error!' });
            },
            success: function(data) {
                // $.jGrowl('审核成功.', { sticky: true, theme: 'growl-success', header: 'Success!' });
                // location.reload();
                console.log('dissuccess');
                $('#searchWrap input').val(''); 

	        }
        });
   })
  </script>
</html>