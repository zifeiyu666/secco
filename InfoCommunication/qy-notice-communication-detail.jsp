<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Document</title>
	<meta name="viewport" content="width=device-width,height=device-height,user-scalable=no,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,target-densitydpi=device-dpi" /> 
	<script type="text/javascript" src='js/jquery-3.1.1.min.js'></script>
	<script type="text/javascript" src='bootstrap-3.3.7/js/bootstrap.min.js'></script>
	<script src='js/swiper.min.js'></script>
	<link rel="stylesheet" href="css/swiper.min.css">
	<link rel="stylesheet" href="bootstrap-3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="css/common.css">
	<style type="text/css">

		.discuss{
			margin-top:20px;
		}
		.disList{
			border-bottom: 1px solid #ccc;
			margin-top: 15px;
		}
		.discuss .disHeader{
			font-size: 16px;
			line-height: 20px;
			margin-bottom: 20px;
		}
		.disBody{
			padding:10px;
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
	</style>
	<script>
		
		function GetQueryString(name)
		{
		     var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
		     var r = window.location.search.substr(1).match(reg);
		     if(r!=null)return  unescape(r[2]); return null;
		}

		alert(GetQueryString("name"));
	</script>
</head>
<body>
	<div class="header">
		<h1>消息沟通</h1>
		<span class='glyphicon glyphicon-remove indexBtn'"></span>
		<span class="glyphicon glyphicon-th-large listBtn"></span>
	</div>
	<div class="navBar" >
		<h1>详情</h1>
		<span class='glyphicon glyphicon-menu-left left' id='backBtn'></span>
	</div>
	
	<div class="main"> <!-- 主体内容 -->
		<div class='detail'>
			<div class="detail_header">
				<h2>检修经验分享 EXPERIENCE OF TAR</h2>
				<span>生产部 2017/01/02</span>
			</div>
			<p class="detail_body">
				这里是内容这里是内容这里是内容这里是内容这里是内容这里是内容这里是内容这里是内容这里是内容这里是内容这里是内容这里是内容这里是内容这里是内容
				
				
			</p>
			<img width=100% src="img/logo.jpg" alt="">
			<p class="detail_body">
				这里是内容这里是内容这里是内容这里是内容这里是内容这里是内容这里是内容这里是内容这里是内容这里是内容这里是内容这里是内容这里是内容这里是内容
			</p>
			<div>
				<button class='btn btn-default' id='zanBtn'><span class='glyphicon glyphicon-thumbs-up'></span>135</button>
			</div>
			
		</div>

		<div class="discuss">
			<h2 class="disHeader">
				最新评论
			</h2>
			<div class="disList">
				<div class="media">
				  <div class="media-left">
				    <a href="#">
				      <img class="media-object" src="img/touxiang.png" width="40" alt="...">
				    </a>
				  </div>
				  <div class="media-body">
				    <h4 class="media-heading">张三</h4>
				    <span class='media_navHeading'>生产部</span>
				  </div>
				  <div class="media-right media_navHeading">
				  	<span>2016/01/02&nbsp;12:00</span>
				  	<button class='btn btn-default btn-sm pull-right' data-toggle="modal" data-target="#myModal" style='margin-top:5px'>回复</button>
				  </div>

				</div>
				<p class='disBody'>这里是评论内容这里是评论内容这里是评论内容这里是评论内容</p>
				<div class="disFeedback">
					<h4>作者回复</h4>
					<p>
						这里是回复这里是回复这里是回复这里是回复这里是回复这里是回复
					</p>
				</div>
			</div>
			<div class="disList">
				<div class="media">
				  <div class="media-left">
				    <a href="#">
				      <img class="media-object" src="img/touxiang.png" width="40" alt="...">
				    </a>
				  </div>
				  <div class="media-body">
				    <h4 class="media-heading">张三</h4>
				    <span class='media_navHeading'>生产部</span>
				  </div>
				  <div class="media-right media_navHeading">
				  	<span>2016/01/02&nbsp;12:00</span>
				  	<button class='btn btn-default btn-sm pull-right' data-toggle="modal" data-target="#myModal" style='margin-top:5px'>回复</button>
				  </div>
				</div>
				<p class='disBody'>这里是评论内容这里是评论内容这里是评论内容这里是评论内容</p>
			</div>
			<div class="disList">
				<div class="media">
				  <div class="media-left">
				    <a href="#">
				      <img class="media-object" src="img/touxiang.png" width="40" alt="...">
				    </a>
				  </div>
				  <div class="media-body">
				    <h4 class="media-heading">张三</h4>
				    <span class='media_navHeading'>生产部</span>
				  </div>
				  <div class="media-right media_navHeading">
				  	<span>2016/01/02&nbsp;12:00</span>
				  	<button class='btn btn-default btn-sm pull-right' data-toggle="modal" data-target="#myModal" style='margin-top:5px'>回复</button>
				  </div>
				</div>
				<p class='disBody'>这里是评论内容这里是评论内容这里是评论内容这里是评论内容</p>
			</div>
		</div>

	</div> <!-- 主题内容结束 -->



	<!-- Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">请输入回复内容</h4>
	      </div>
	      <div class="modal-body">
	        <textarea  class="form-control"></textarea>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
	        <button type="button" class="btn btn-primary">提交</button>
	      </div>
	    </div>
	  </div>
	</div>
		
	
	<!-- <div class="bottomMask">
		<div class="myBtn" >
			<button class="btn btn-primary form-control btnList" id='CreateCustom'>
				...
			</button>
		</div>
	</div> -->

	<div class="footer">
		<div class='row'>
			<div class='col-xs-10' style='padding:10px 20px'>
				<input class='form-control' type="text" placeholder="评论..." style='width:90%;margin-left:10px'>
			</div>
			<div class="col-xs-2" style='padding:10px 20px'>
				<button class="btn btn-primary pull-right" style='margin-right:10px'>发布</button>
			</div>
			
		</div>
	</div>
</body>
<script type="text/javascript" src='js/conmmon.js'></script>
<script>        
  var mySwiper = new Swiper ('.swiper-container', {
    direction: 'horizontal',
    loop: false,
    slidesPerView : 4,
  })  

   // 点赞
   $('#zanBtn').click(function(){
   		$(this).toggleClass('btn-primary'); 
   })

   // 返回
   $("#backBtn").click(function(){
   	window.location.href='qy-notice-communication.html';
   })
  </script>
</html>