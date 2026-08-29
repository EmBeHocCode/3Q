/**
 * 设置LayaNative屏幕方向，可设置以下值
 * landscape           横屏
 * portrait            竖屏
 * sensor_landscape    横屏(双方向)
 * sensor_portrait     竖屏(双方向)
 */
window.screenOrientation = "sensor_portrait";
//一些全局配置
var appVersion = "2.1";	
var gameOrigin = window.location.protocol + "//" + window.location.hostname;
var ydwxConfig = {};
window.ydwxConfig = ydwxConfig;
ydwxConfig.version = 2026081112;															//资源版本
ydwxConfig.gameId = 10091;																	//gameId
ydwxConfig.platform = "yezixi";																//平台
ydwxConfig.basePath = window.location.origin + "/game/source/";						//资源地址
ydwxConfig.debug = false;																	//是否开启调试
ydwxConfig.loginType = 1;																	//登录方式 1 账号密码  2 platform
ydwxConfig.metaDataServer = gameOrigin + ":12345/";						//元数据服务器地址
ydwxConfig.statisticServer = gameOrigin + ":7788/";               	//打点数据地址
ydwxConfig.clientVersion = "2.0";
													//客户端版本，用来验证，前端版本是不是需要更新

loadLib(window.location.origin + "/game/source/resources/toph5super/111/toph5super.min.js");
//-----libs-begin-----
loadLib("libs/0c1cc-498bc-931f1.js");
loadLib("libs/0c12c-498bc-931f2.js"); 
loadLib("libs/b025d-4e5e6-14e03.js"); 
loadLib("libs/70b25-fd225-cca11.js");
loadLib("libs/6c019-63500-58428.js");
loadLib("libs/9e1f8-d19bc-ca79a.js");
loadLib("libs/0e8e7-bdd92-8bd5a.js");
loadLib("libs/fe8a3-bb91d-7fb1b.js");
//游戏主体
loadLib("js/laya-text-hotfix.js?v=" + appVersion);
loadLib("js/meow-global-speed.js?v=" + appVersion);
loadLib("js/bundle.js?v=" + appVersion);
loadLib("libs/v4r510n-p4ck0o0.js?v="+appVersion); 
