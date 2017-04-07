
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>主页</title>
	<meta name="viewport" id="viewport" content="user-scalable=no,width=750px,target-densitydpi=device-dpi">
	<script type="text/javascript" src='../js/jquery-3.1.1.min.js'></script>
	<script type="text/javascript" src='../bootstrap-3.3.7/js/bootstrap.min.js'></script>
	<script src='../js/handlebars-v4.0.5.js'></script>
	<script src='../wechatcp/common.js'></script>
	<link rel="stylesheet" href="../css/swiper.min.css">
	<link rel="stylesheet" href="../bootstrap-3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="../css/common.css">
	<script type="text/javascript">
	    // 设置html字号
	    console.log(document.documentElement.clientWidth);
		document.getElementsByTagName('html')[0].style.fontSize=document.documentElement.clientWidth/75+'px';
	</script> 
	<style>
		.indexWrap{
			padding:0;
			position:relative;
			top:-100px;
		}
		.indexWrap .list{
			position:absolute;

		}
		.indexWrap .list h2{
			position:absolute;
			left:30px;
			top:35px;
			font-size: 34px;
			color:#fff;
			text-shadow: 1px 1px 1px #666;
		}

		.header{
			height:100px;
		}
		.header .listBtn{
			position:absolute;
			right:20px;
			line-height: 100px;
			color:#fff;
			font-size: 30px;
		}
		.header .indexBtn{
			position:absolute;
			left:20px;
			line-height: 100px;
			color:#fff;
			font-size: 30px;
		}
		.header h1{
			font-size:32px;
			color:#fff;
			line-height: 100px;
			font-weight: normal;
		}
		.jifen{
			left:30px;
			top:130px;
		}
		.diaoyan{
			left:290px;
			top:130px;
		}
		.toupiao{
			left:290px;
			top:370px;
		}
		.baoxiao{
			top:606px;
			left:30px;
		}
		.qingjia{
			top:845px;
			left:30px;
		}
		.peixun{
			left:476px;
			top:606px;
		}
		.bottom{
			top:1080px;
			left:30px;
		}
		.bottom .item{
			width: 33.333%;
		    text-align: center;
		    padding-bottom: 8px;
		    display: inline-block;
		    position: absolute;
			top:0;
		    height: 100%;
		}
		.bottom .banche{
			left:0;
		}
		.bottom .zhaopin{
			left:230px;
		}
		.bottom .jianyi{
			left:460px;
		}
		.bottom .item img{
			display:inline-block;
			margin-top:44px;
		}
		.bottom .item h4{
			font-size: 34px;
			color:#fff;
			text-shadow: 1px 1px 1px #666;
			line-height: 90px;
		}
	</style>
</head>
<body>
	<div class='indexWrap'>
		<div class="list jifen">
			<img width=247 src="../img/jifenguangou@2x.png" alt="">
			<h2>积分换购</h2>
		</div>

		<div class="list diaoyan">
			<img width=428 src="../img/diaoyan@2x.png" alt="">
			<h2>调研</h2>
		</div>

		<div class="list toupiao">
			<img width=428 src="../img/toupiao@2x.png" alt="">
			<h2>投票</h2>
		</div>

		<div class="list baoxiao">
			<img width=428  src="../img/baoxiao@2x.png" alt="">
			<h2>报销</h2>
		</div>

		<div class="list peixun">
			<img width=247 src="../img/neibupeixun@2x.png" alt="">
			<h2>内部培训</h2>
		</div>

		<div class="list qingjia">
			<img width=428 src="../img/xiujiashenqing@2x.png" alt="">
			<h2>休假申请</h2>
		</div>

		<div class="list bottom">
			<img width=690 src="../img/ditu@2x.png" alt="">
			<div class="item banche">
				<img width=46 src="../img/banchechacunicon@2x.png" alt="">
				<h4>班车查询</h2>
			</div>
			<div class="item zhaopin">
				<img width=46 src="../img/banchechacunicon@2x.png" alt="">
				<h4>招聘</h2>
			</div>
			<div class="item jianyi">
				<img width=46 src="../img/banchechacunicon@2x.png" alt="">
				<h4>建议征集</h2>
			</div>
		</div>
		
	</div>
</body>
</html>