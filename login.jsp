<%@ page language="java" pageEncoding="utf-8"%>

<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf8" />
<title>暴雪后台登录</title>

<link href="css/login-box.css" rel="stylesheet" type="text/css" />
<link href="css/ui-lightness/jquery-ui-1.9.2.custom.css"
	rel="stylesheet" />
<script src="js/jquery-1.8.3.js"></script>
<script src="js/jquery-ui-1.9.2.custom.js"></script>
<script>
var mysubmit;
var keysubmit = function(event){
	if(event.which==13){
		mysubmit();
	}
};
function chgUrl(url) {
	var timestamp = (new Date()).valueOf();
	if ((url.indexOf("?") >= 0)) {
		url = url + "&t=" + timestamp;
	} else {
		url = url + "?t=" + timestamp;
	}
	return url;
}
$(function()
{
	 var imageCode = $("#imgCode");
	 var imageCodeUrl = imageCode.attr("src");
	$("#form1").dialog({closeText: "hide",closeOnEscape: false,resizable: false,width: 510,buttons:[{text:"登录",click:function(){
		mysubmit();
		}}]}
	);
	$("input").keydown(keysubmit);
	var form = $("#form1");
	form.submit(mysubmit);
	mysubmit =function(){
		$.post(form.attr("action"),form.serialize(),
				function(result,status){
					if(status == 'success'){
						if(result.success==1){
							$("#lblMsg").text("");
							window.location.href=result.url;
						}else{
							$("#lblMsg").text(result.message);
							imageCode.attr("src", chgUrl(imageCodeUrl));
						}
					}
			});
		};
		
		imageCode.click(function(){ imageCode.attr("src", chgUrl(imageCodeUrl))});
}
);	
</script>
</head>

<body>

	<s:form id="form1" action="login" method="post" title="暴雪后台">
		<div id="dialog">

			<div id="login-box">

				<h2>登录</h2>
				<br /> <br />
				<div id="login-box-name" style="margin-top: 20px;">用户名:</div>
				<div id="login-box-field" style="margin-top: 20px;">
					<input name="userName" class="form-login" title="Username" value=""
						size="30" maxlength="2048" />
				</div>
				<div id="login-box-name">密码:</div>
				<div id="login-box-field">
					<input type="password" class="form-login" title="Password" value=""
						size="30" name="password" maxlength="2048" />
				</div>
				<div id="login-box-name">验证码:</div>
				<div id="login-box-field">
					<input name="imgCode" class="form-login" value="" size="30"
						maxlength="2048" /> <img id="imgCode" src="<s:url action="imgCode" ></s:url>" />
				</div>
				<%-- <br /> <br /> <br /> <input type="image"
					src="images/login-btn.png" style="margin-left: 90px;"></input>
				<s:label name="msg" cssStyle="color:red;"></s:label> --%>
			</div>
			<%-- <s:label name="msg" cssStyle="color:red;"></s:label> --%>
			<label id="lblMsg" style="color:red;"></label>
		</div>
	</s:form>

</body>
</html>
