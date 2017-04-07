
			/*新增/删除子项目按钮通用,复用联系人或者产品的功能*/
	/*新建、删除联系人*/
	$('#btnCreateContent').click(function(){
		var $List=$('#contactListHide');
		$List.clone(true).prependTo($(this).parent().next()).attr('id','');
	})
	$('.closeContact').click(function(){
		var r=confirm("是否确定删除？")
		  if (r==true)
		    {
		    	$(this).parents('.line').remove();
		    }
		
	})
	/*新建、删除赛科产品*/
	$('#btnCreateProduct').click(function(){
		var $List=$('#productListHide');

		$List.clone(true).prependTo($(this).parent().next()).attr('id','');
	})
	$('.closeProduct').click(function(){
		var r=confirm("是否确定删除？")
		  if (r==true)
		    {
		    	$(this).parents('.line').remove();
		    }
		

	})

	




	/*下拉菜单功能*/
	$(".dropdown a").click(function(){

		$Val=$(this).html();

		$(this).parents('ul').prevAll('button').html($Val+'<span class="arrdown"></span>');
		//alert($(this).parents('ul').prevAll('button').html());
	})

	/**/

	/*搜索界面控制*/
	$('.searchIcon').click(function(){
		$(".searchWrap").animate({'height':'100%'},200);
	})
	$(".searchClose").click(function(){
		$(".searchWrap").animate({'height':'0'},200);
	})
	$(".searchBtn").click(function(){
		$(".searchWrap").animate({'height':'0'},200);
	})
	

	/*订单查询分条件搜索界面*/
	/*条件1*/
	$('.searchIcon1').click(function(){
		$(".searchWrap1").animate({'height':'100%'},200);
	})
	$(".searchClose").click(function(){
		$(".searchWrap1").animate({'height':'0'},200);
	})
	$(".searchBtn").click(function(){
		$(".searchWrap1").animate({'height':'0'},200);
	})
	/*条件2*/
	$('.searchIcon2').click(function(){
		$(".searchWrap2").animate({'height':'100%'},200);
	})
	$(".searchClose").click(function(){
		$(".searchWrap2").animate({'height':'0'},200);
	})
	$(".searchBtn").click(function(){
		$(".searchWrap2").animate({'height':'0'},200);
	})
	

	
/*全屏模态窗*/
	/*结构模板*/
	/*<div class="modalModule" id='modal1'>
		<div class="modalTitle">
			<span class="modalClose glyphicon glyphicon-remove"></span>
			<h1>全屏模态窗头部</h1>
		</div>

		<div class="panel panel-primary">
		  <div class="panel-heading">模态窗标题</div>
		  <div class="panel-body">

		  </div>
		</div>

		<button class="btn btn-primary form-control searchBtn">
			查询
		</button>
	</div>*/
	function fnModal(id1,id2){
		$("#"+id1).click(function(){
			console.log(222);
			$("#"+id2).animate({'height':'100%'},200);
			return false;
		})
		$("#"+id2).find('.modalClose').click(function(){
			$("#"+id2).animate({'height':'0'},200);
		})
		$("#"+id2).find('button').click(function(){
			$("#"+id2).animate({'height':'0'},200);
		})
	}
	function fnObjectModal(obj1,id2){
		obj1.click(function(){
			console.log(222);
			$("#"+id2).animate({'height':'100%'},200);
			return false;
		})
		$("#"+id2).find('.modalClose').click(function(){
			$("#"+id2).animate({'height':'0'},200);
		})
	}

/*页面底部模态窗*/
	/*结构模板*/
	/*<div class="bottomMask">
		<div class="myBtn" >
			<button class="btn btn-primary form-control btnList" id='btnCreate'>
				按钮1
			</button>
			<button class="btn btn-primary form-control btnList" id='btnCreate'>
				按钮2
			</button>
			...
		</div>
	</div>*/
	$('.listBtn').click(function(){
		var $h = $('.bottomMask .btnList').css('height');
		var $num = $('.bottomMask .btnList').length;
		var $l = 10+(parseInt($h)+5)*$num;
		$('.bottomMask').fadeToggle(200,function(){

			if($(".bottomMask").css('display')!='none')
			{
				$('.myBtn').animate({'height':$l+'px'},200)
			}
			else{
				$('.myBtn').animate({'height':'0px'},200)
			}
		});
		$('.bottomMask').click(function(){
			$(this).css('display','none');
		})
	})
	$('.myBtn').click(function(){
		$('.bottomMask').css('display','none');
	})

/*新增/删除子项目*/
	/*模板*/
	/*<div class="panel panel-primary"> 
	  <div class="panel-heading">标题<span class='glyphicon glyphicon-plus createItem'></span></div>
	  <div class="panel-body">
	    <form role="form" class='line hideModule'>
	    	
		</form>
	  </div>
	</div>*/
	$('.createItem').click(function(){
		var $List=$(this).parent().next().find('.hideModule');
		$List.clone(true).prependTo($(this).parent().next()).removeClass('hideModule');
	})
	$('.closeItem').click(function(){
		var r=confirm("是否确定删除？")
		  if (r==true)
		    {
		    	$(this).parents('.line').remove();
		    }
		
	})

/*单独的删除功能*/
$('.closeOrder').click(function(){
	  var r=confirm("是否确定删除？")
	  if (r==true)
	    {
	    	$(this).parents('li.line').remove();
	    }
	})

	

