<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>通知公告</title>
	<meta name="viewport" content="width=device-width,height=device-height,user-scalable=no,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,target-densitydpi=device-dpi" /> 
	<script type="text/javascript" src='../js/jquery-3.1.1.min.js'></script>
	<script type="text/javascript" src='../bootstrap-3.3.7/js/bootstrap.min.js'></script>
	<script src='../js/handlebars-v4.0.5.js'></script>
	<script src='../wechatcp/common.js'></script>
	<link rel="stylesheet" href="../css/swiper.min.css">
	<link rel="stylesheet" href="../bootstrap-3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="../css/common.css">
	<!--详情 handlebar 模板 -->
	<script id="entry-template" type="text/x-handlebars-template"> 
		<div class='detail'>
			<input type="hidden" data-comment={{canComment}} data-transfer={{canTransfer}}>
			<div class="detail_header">
				<h2>{{title}}</h2>
				<span>[ {{department}} ] {{updateDateString}}</span>
			</div>
			<div class="detail_body" style="overflow-y: hidden">
				<div style="overflow-y: hidden">{{{content}}}</div>
			</div>
			
		</div>
	</script>


</head>
<body>
	<div class="navBar" >
		<h1>详情</h1>
		<img class="left" id='backBtn' src='../img/fanhui@2x.png' width=12></img>
	</div>
	
	<div class="main">
		<div class="datailWrap"></div>
	</div> 
</body>
<script type="text/javascript" src='js/conmmon.js'></script>
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
	var token = SystemUtil.getUrlParam("token");
	// var token = SystemUtil.getUrlParam("token");
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
	            	jQuery.ajax({
		                url: "${ctx}/api/v1/comments?thirdPartId="+myId+"&thirdPartType="+data.type,   // 提交的页面
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
		                    
				        }
		            });
	            }
	        }
        });
	})


   // 返回
   // 这里添加token;(因为token未引入，所以暂时不能返回);
   $("#backBtn").click(function(){
   		window.location.href='publicNotice.jsp?token='+token;
   })



   $("#disSubmit").click(function(){
   		var myData={"comment":"","thirdPartId":"1","thirdPartType":"3" ,"commentType":"1"};
	   	myData.comment=$('#searchWrap input').val();
	   	console.log($('#searchWrap input').val());
   		jQuery.ajax({
            url: "${ctx}/api/v1/comments/newComment",
            contentType:"application/x-www-form-urlencoded; charset=UTF-8",
            headers: {'authentication':"1ac3efa3-b643-41f8-8cea-df7cb2015935"},
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