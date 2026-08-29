<?php
error_reporting(0);
$qu = $_POST['qu'];
$sqm = $_POST['sqm'];
$usr = $_POST['usr'];
$bao = $_POST['bao'];
$num = $_POST['num'];
$item = $_POST['item'];
$xbag = $_POST['xbag'];
$xmag = $_POST['xmag'];
$gnxz = $_POST['gnxz'];
$sqm = str_replace(array(' ','%'),'',$sqm);
$usr = str_replace(array(' ','%'),'',$usr);
$gnxz = str_replace(array(' ','%'),'',$gnxz);
$usr = str_replace(array(' ','%'),'',$usr);
$qu =='' && (die('大区必须选择'));
$usr =='' && (die('请输入角色名称'));
$sqm =='' && (die('请输入后台密码'));
$gnxz == 0 && (die('请选择功能'));
include "../config/config.php";
$mysql = mysqli_connect($PZ['DB_HOST'],$PZ['DB_USER'],$PZ['DB_PWD'],$PZ['DB_NAME'],$PZ['DB_PORT']) or die("数据库连接错误");
$mysql->query('set names utf8');
$roleName = urlencode($usr);//转url
$headers[]  =  "Content-Type: application/json";
$headers[]  =  "Login-Token:{$res}";
//查询角色
//var_dump($res1);die;
$url = $PZ['NAME_URL']."role/record/list?srvCode={$qu}&roleName={$roleName}&page=1&pageSize=10"; 
$res = get_content($url, $headers);
$uid = json_decode($res); 

$rid = $uid->data->records['0']->roleId; //roleId
$aid = $uid->data->records['0']->accountUid;//accountUid
$platformCode = $uid->data->records['0']->platformCode; //platformCode
$aid =='' && (die('无此角色ID,请检查后再试'));
$rid =='' && (die('无此角色名,请检查后再试'));
$ss = mysqli_fetch_assoc($mysql->query("SELECT pass,type FROM cdk WHERE uid = '$rid' limit 1"));
if($gnxz==3){
    //$xbag != '确认清理道具' && (die('请输入"确认清理道具"'));
    $url = $PZ['GM_URL']."role/bag/query?srvCode={$qu}&roleId={$rid}&bagType=3"; 
    //查询道具
    $res = get_content($url, $headers);
    $daoju = json_decode($res, true); 
	$res = $daoju['data']['list'];
	$res == NULL && (die('你还没有道具！'));
	foreach ($res as $item) {
 	$itemUid = $item['id'];   // 循环
 	$num = $item['num'];
 	$url = $PZ['GM_URL']."role/bag/reduce?cmdMode=uid&srvCode={$qu}&roleId={$rid}&bagType=3&num={$num}&itemUid={$itemUid}&note=%E5%88%A0%E9%99%A4%E7%89%A9%E5%93%81"; 
	$res = get_content($url, $headers);  
	}	
	curl_close($ch);	
	if($res['errorCode']==0){die('清理成功');}else{die($res['reason']);}
}elseif($gnxz==4){
    //$xmag != '确认清理装备' && (die('请输入"确认清理装备"'));
    $url = $PZ['GM_URL']."role/bag/query?srvCode={$qu}&roleId={$rid}&bagType=2"; 
    //查询道具
    $res = get_content($url, $headers);
    $daoju = json_decode($res, true); 
	$res = $daoju['data']['list'];
	$res == NULL && (die('你还没有装备！'));
	foreach ($res as $item) {
 	$itemUid = $item['id'];   // 循环
 	$num = $item['num'];
 	$url = $PZ['GM_URL']."role/bag/reduce?cmdMode=uid&srvCode={$qu}&roleId={$rid}&bagType=2&num={$num}&itemUid={$itemUid}&note=%E5%88%A0%E9%99%A4%E7%89%A9%E5%93%81"; 
	$res = get_content($url, $headers);  
	}	
	curl_close($ch);
	curl_close($ch);	
	if($res['errorCode']==0){die('清理成功');}else{die($res['reason']);}	
}
elseif($gnxz==5){
   // $xmag != '确认清理英雄' && (die('请输入"确认清理英雄"'));
    $url = $PZ['GM_URL']."role/bag/query?srvCode={$qu}&roleId={$rid}&bagType=1"; 
    //查询道具
    $res = get_content($url, $headers);
    $daoju = json_decode($res, true); 
	$res = $daoju['data']['list'];
	$res == NULL && (die('你还没有英雄！'));
	foreach ($res as $item) {
 	$itemUid = $item['id'];   // 循环
 	$num = $item['num'];
 	$url = $PZ['GM_URL']."role/bag/reduce?cmdMode=uid&srvCode={$qu}&roleId={$rid}&bagType=1&num={$num}&itemUid={$itemUid}&note=%E5%88%A0%E9%99%A4%E7%89%A9%E5%93%81"; 
	$res = get_content($url, $headers);  
	}	
	curl_close($ch);
	curl_close($ch);	
	if($res['errorCode']==0){die('清理成功');}else{die($res['reason']);}	
}elseif($gnxz==6){
   // $xmag != '确认清理碎片' && (die('请输入"确认清理碎片"'));
    $url = $PZ['GM_URL']."role/bag/query?srvCode={$qu}&roleId={$rid}&bagType=4"; 
    //查询道具
    $res = get_content($url, $headers);
    $daoju = json_decode($res, true); 
	$res = $daoju['data']['list'];
	$res == NULL && (die('你还没有碎片！'));
	foreach ($res as $item) {
 	$itemUid = $item['id'];   // 循环
 	$num = $item['num'];
 	$url = $PZ['GM_URL']."role/bag/reduce?cmdMode=uid&srvCode={$qu}&roleId={$rid}&bagType=4&num={$num}&itemUid={$itemUid}&note=%E5%88%A0%E9%99%A4%E7%89%A9%E5%93%81"; 
	$res = get_content($url, $headers);  
	}	
	curl_close($ch);
	curl_close($ch);	
	if($res['errorCode']==0){die('清理成功');}else{die($res['reason']);}	
}elseif($gnxz==7){
   // $xmag != '确认清理墨印' && (die('请输入"确认清理墨印"'));
    $url = $PZ['GM_URL']."role/bag/query?srvCode={$qu}&roleId={$rid}&bagType=5"; 
    //查询道具
    $res = get_content($url, $headers);
    $daoju = json_decode($res, true); 
	$res = $daoju['data']['list'];
	$res == NULL && (die('你还没有墨印！'));
	foreach ($res as $item) {
 	$itemUid = $item['id'];   // 循环
 	$num = $item['num'];
 	$url = $PZ['GM_URL']."role/bag/reduce?cmdMode=uid&srvCode={$qu}&roleId={$rid}&bagType=5&num={$num}&itemUid={$itemUid}&note=%E5%88%A0%E9%99%A4%E7%89%A9%E5%93%81"; 
	$res = get_content($url, $headers);  
	}	
	curl_close($ch);
	curl_close($ch);	
	if($res['errorCode']==0){die('清理成功');}else{die($res['reason']);}	
}elseif($gnxz==8){
   // $xmag != '确认清理兽魂' && (die('请输入"确认清理兽魂"'));
    $url = $PZ['GM_URL']."role/bag/query?srvCode={$qu}&roleId={$rid}&bagType=6"; 
    //查询道具
    $res = get_content($url, $headers);
    $daoju = json_decode($res, true); 
	$res = $daoju['data']['list'];
	$res == NULL && (die('你还没有兽魂！'));
	foreach ($res as $item) {
 	$itemUid = $item['id'];   // 循环
 	$num = $item['num'];
 	$url = $PZ['GM_URL']."role/bag/reduce?cmdMode=uid&srvCode={$qu}&roleId={$rid}&bagType=6&num={$num}&itemUid={$itemUid}&note=%E5%88%A0%E9%99%A4%E7%89%A9%E5%93%81"; 
	$res = get_content($url, $headers);  
	}	
	curl_close($ch);
	curl_close($ch);	
	if($res['errorCode']==0){die('清理成功');}else{die($res['reason']);}	
}elseif($gnxz==9){
  //  $xmag != '确认清理仙器' && (die('请输入"确认清理仙器"'));
    $url = $PZ['GM_URL']."role/bag/query?srvCode={$qu}&roleId={$rid}&bagType=7"; 
    //查询道具
    $res = get_content($url, $headers);
    $daoju = json_decode($res, true); 
	$res = $daoju['data']['list'];
	$res == NULL && (die('你还没有仙器！'));
	foreach ($res as $item) {
 	$itemUid = $item['id'];   // 循环
 	$num = $item['num'];
 	$url = $PZ['GM_URL']."role/bag/reduce?cmdMode=uid&srvCode={$qu}&roleId={$rid}&bagType=7&num={$num}&itemUid={$itemUid}&note=%E5%88%A0%E9%99%A4%E7%89%A9%E5%93%81"; 
	$res = get_content($url, $headers);  
	}	
	curl_close($ch);
	curl_close($ch);	
	if($res['errorCode']==0){die('清理成功');}else{die($res['reason']);}	
}elseif($gnxz==10){
  //  $xmag != '确认清理藏品' && (die('请输入"确认清理藏品"'));
    $url = $PZ['GM_URL']."role/bag/query?srvCode={$qu}&roleId={$rid}&bagType=13"; 
    //查询道具
    $res = get_content($url, $headers);
    $daoju = json_decode($res, true); 
	$res = $daoju['data']['list'];
	$res == NULL && (die('你还没有藏品！'));
	foreach ($res as $item) {
 	$itemUid = $item['id'];   // 循环
 	$num = $item['num'];
 	$url = $PZ['GM_URL']."role/bag/reduce?cmdMode=uid&srvCode={$qu}&roleId={$rid}&bagType=13&num={$num}&itemUid={$itemUid}&note=%E5%88%A0%E9%99%A4%E7%89%A9%E5%93%81"; 
	$res = get_content($url, $headers);  
	}	
	curl_close($ch);
	curl_close($ch);	
	if($res['errorCode']==0){die('清理成功');}else{die($res['reason']);}	
}elseif($gnxz==11){
   // $xmag != '确认清理仙器碎片' && (die('请输入"确认清理仙器碎片"'));
    $url = $PZ['GM_URL']."role/bag/query?srvCode={$qu}&roleId={$rid}&bagType=8"; 
    //查询道具
    $res = get_content($url, $headers);
    $daoju = json_decode($res, true); 
	$res = $daoju['data']['list'];
	$res == NULL && (die('你还没有仙器碎片！'));
	foreach ($res as $item) {
 	$itemUid = $item['id'];   // 循环
 	$num = $item['num'];
 	$url = $PZ['GM_URL']."role/bag/reduce?cmdMode=uid&srvCode={$qu}&roleId={$rid}&bagType=8&num={$num}&itemUid={$itemUid}&note=%E5%88%A0%E9%99%A4%E7%89%A9%E5%93%81"; 
	$res = get_content($url, $headers);  
	}	
	curl_close($ch);
	curl_close($ch);	
	if($res['errorCode']==0){die('清理成功');}else{die($res['reason']);}	
}
$ss['type'] < $gnxz && (die('此角色未授权此功能'));
$ss['pass'] != $sqm && (die('后台密码错误'));
if($gnxz==1){
    $bao == 0 && (die('请选择充值项目'));
	$array=explode(',',$bao);
	$item_tid	= $array[0];
	$item_name = $array[1];
    $pay_amount = $array[2];
	//充值
	$time = date('Y-m-d', time());
	$orderNo = time().mt_rand(100,999);
	if(!$mysql->query("INSERT INTO `tcg`.`pay_approval` (`order_type`, `status`, `platform_order_id`, `item_tid`, `item_count`, `item_name`, `pay_amount`, `srv_code`, `platform_code`, `channel_code`, `platform_open_id`, `account_uid`, `master_id_hex`, `master_name`, `submit_username`, `submit_nickname`, `submit_time`, `approve_username`, `approve_nickname`, `approve_time`, `currency_code`) VALUES ('2', '1', '{$orderNo}', '{$item_tid}', '1', '{$item_name}', '{$pay_amount}', '{$qu}', '{$platformCode}', NULL, '', '{$aid}', '{$rid}', '{$usr}', 'admin', '超管', '{$time}', NULL, NULL, NULL, 'CNY')")){die("插入充值数据连接失败");}
	$id = $mysql->insert_id; 
	//审核
	$post = array ( 
    'status' => '2', 
    'id' => $id, //订单自增ID
	); 
	$data = json_encode($post); 
	$url = $PZ['GM_URL']."gm/pay/completeApproval"; 
	$res = curl_post($url, $data , $headers);
	curl_close($ch);
	if($res['errorCode']==0){die('Thành Công');}else{die($res['reason']);}
}elseif($gnxz==2){
    $item =='0' && (die('请选择物品'));
	$find=false;
	$file = fopen("item.txt", "r");
	while(!feof($file)){
		$line=fgets($file);
		$txts=explode('|',$line);
		if(trim($txts[0]) == trim($item)){
			$find=true;
			break;
		}
	}
	fclose($file);
	if($find==false){die('此物品您无权发送');}
	$num =='' && ($num = 1); 
	if($item > 99){$num > 100 && ($num = 100);}else{$num > 999999999 && ($num = 999999999);}	
	//邮件
	$data = array ( 
   'gmMailEntity' => array (
    'type' => 2, 
    'operation' => 12, 
    'title' => $PZ['title'], 
    'reward' => $item.':'.$num, 
    'content' => $PZ['content'],
	),	
	'gmMailTars' => array ([
    'type' => 2, 
    'srvCode' => $qu, 
    'masterIdHex' => $rid, 
    'name' => $usr, 
    'masterName' => $usr, 
    'roleId' => $rid, 
    'roleName' => $usr, 
    'platformCode' => $platformCode, 
	]),
    'reward' => $item.':'.$num, 
		
    );
	$data = json_encode($data);  
	$url = $PZ['GM_URL']."gm/mail/x/create";  
	$res = curl_post($url, $data , $headers);
	$sql = "SELECT * FROM tcg.gm_mail_approval WHERE status = '1'";	
	foreach ($mysql->query($sql) as $row) {
	$id = $row['id'];	
	$post = array ( 
    'status' => '2', 
    'id' => $id, //邮件自增ID
	); 
	$data = json_encode($post); 
	$url = $PZ['GM_URL']."gm/mail/x/complete"; 
	$res = curl_post($url, $data , $headers);
	curl_close($ch);	
	}	
	if($res['errorCode']==0){die('Thành Công');}else{die($res['reason']);}
}else{
    die('error');
}

?>