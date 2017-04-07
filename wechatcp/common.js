
/**
 * 系统配置
 */
var SystemConfig = {
	getBaseHtmlUrl : function() {
		return SystemUtil.getBaseUrl() + '/static/custom/secco/';
	},
	getBaseServiceUrl : function() {
		return SystemUtil.getBaseUrl() + '/api/v1/';
	}
}

/**
 * 工具类
 */
var SystemUtil = {
	injection : function(language) {
		$.each($('span[field-label]'), function(i, obj) {
			var tag = $(this).attr('field-label');
            if (!SystemUtil.isNull(language[tag])) $(this).text(language[tag]);
		});
		$.each($('input[field-label]'), function(i, obj) {
			var tag = $(this).attr('field-label');
			if (!SystemUtil.isNull(language[tag])) $(this).attr('placeholder', language[tag]);
		});
		$.each($('textarea[field-label]'), function(i, obj) {
			var tag = $(this).attr('field-label');
			if (!SystemUtil.isNull(language[tag])) $(this).attr('placeholder', language[tag]);
		});
	},
	changeBodyStyle : function() {
		$('body').removeClass();$('body').addClass("ios7");
	},
	/**
	 * 日期格式化
	 * @param {} date 日期 可以传
	 * @param {} format 格式化字符串 例如：yyyy-MM-dd hh:mm:ss
	 */
	format : function(date, formatString) {
		if(SystemUtil.isNull(date)) return null;
		var time;
		if (typeof date == "number") time = new Date(date);
		if (date instanceof Date) time = date;
		var o = {
			"M+" : time.getMonth()+ 1, // month
			"d+" : time.getDate(), // day
			"h+" : time.getHours(), // hour
			"m+" : time.getMinutes(), // minute
			"s+" : time.getSeconds(), // second
			"q+" : Math.floor((time.getMonth() + 3) / 3), // quarter
			"S" : time.getMilliseconds()
		}
		if (/(y+)/.test(formatString)) {
			formatString = formatString.replace(RegExp.$1,(time.getFullYear() + "").substr(4 - RegExp.$1.length));
		}

		for ( var k in o) {
			if (new RegExp("(" + k + ")").test(formatString)) {
				formatString = formatString.replace(RegExp.$1,RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));
			}
		}
		return formatString;
	},
	/**
	 * @author 字符类型的日期转换为Date类型, 传入的参数必须如下 2014-9-19 19:30:23
	 */
	parseDate : function(date) {
		return new Date(date.replace(/-/g, "/"));
	},
	getHost : function() {
		return window.location.protocol + "//" + window.location.host;
	},
	getBaseUrl : function() {
		var url = window.location.href;
		var index = url.indexOf("/static/");
		if (index <= -1) {
			$('body').modalAlert({message:"请求根路径错误" + url});
			return "";
		}
		return url.substring(0, index);
	},
	//获取URL参数列表
	getJsUrl : function() {
		var pos, str, para, parastr;
		var array = [];	str = location.href;
		parastr = str.split("?")[1];
		if (null == parastr) return;
		var arr = parastr.split("&");
		for (var i = 0; i < arr.length; i++) {
			array[arr[i].split("=")[0]] = arr[i].split("=")[1];
		}
		return array;
	},
	// 获取URL对应参数值
	getUrlParam : function(name) {
		var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); // 构造一个含有目标参数的正则表达式对象
		var r = window.location.search.substr(1).match(reg); // 匹配目标参数
		return (r!=null)?decodeURIComponent(r[2]).replace('#',''):null;
	},
    // 获取URL对应参数值
    getParamValue : function(url,name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); // 构造一个含有目标参数的正则表达式对象
        var r = url.match(reg); // 匹配目标参数
        return (r!=null)?decodeURIComponent(r[2]).replace('#',''):null;
    },
	// 判断是否为空
	isNull : function(value) {
		var type = jQuery.type(value);
		if (type === "undefined" || type === "" || type === "null" || value === "null"
			|| value === null || value === "" || value === "undefined") {
			return true;
		} else {
			return false;
		}
	},
	uuid : function(len, radix) {
		var chars = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'.split('');
		var uuid = [], i;
		radix = radix || chars.length;
		if (len) {
			for (i = 0; i < len; i++) uuid[i] = chars[0 | Math.random() * radix];
		} else {
			var r;uuid[8] = uuid[13] = uuid[18] = uuid[23] = '-';	uuid[14] = '4';
			for (i = 0; i < 36; i++) {
				if (!uuid[i]) {
					r = 0 | Math.random() * 16;
					uuid[i] = chars[(i == 19) ? (r & 0x3) | 0x8 : r];
				}
			}
		}
		return uuid.join('');
	},
	// 手机号码验证
	isMobileNum : function(v) {
		var filter = /^1[3|5|7|8|][0-9]{9}$/;
		return filter.test(v);
	},
	formatMoney : function(s, type) {
	    if (/[^0-9\.]/.test(s)) return "0";
	    if (s == null || s == "") return "0";
	    s = s.toString().replace(/^(\d*)$/, "$1.");
	    s = (s + "00").replace(/(\d*\.\d\d)\d*/, "$1");
	    s = s.replace(".", ",");
	    var re = /(\d)(\d{3},)/;
	    while (re.test(s))
	        s = s.replace(re, "$1,$2");
	    s = s.replace(/,(\d\d)$/, ".$1");
	    if (type == 0) {// 不带小数位(默认是有小数位)
	        var a = s.split(".");
	        if (a[1] == "00") s = a[0];
	    }
	    return s;
	}
};

