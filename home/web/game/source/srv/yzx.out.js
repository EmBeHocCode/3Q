window.tools = {
    postForm: function(url, bodyStr, respCallback) {
        let httpRequest = new XMLHttpRequest();
        httpRequest.open('POST', url, true);
        httpRequest.setRequestHeader("Content-type","application/x-www-form-urlencoded");
        httpRequest.send(encodeURI(bodyStr));
        httpRequest.onreadystatechange = function () {
            respCallback(httpRequest);
        };
    }
}

window.qq = {
    hi: function() {
        alert("hello，沙雕");
    },
    h115: function () {
        TopSuper.mockHost = "160.191.50.225";
    },
    h: function (ipEnd) {
        TopSuper.mockHost = "192.168.10."+ipEnd;
    },
}

window.TopSuper = {
    mockHost: "160.191.50.225",
    login: function(callback) {
        alert("未模拟登陆，请通过develop登陆");
    },
    save: function(params) {
        console.log("TopSuper:save:", params);
    },
    pay: function (clientOrderParam, payCallback) {
        console.log("客户端提交的参数clientOrderParam=", clientOrderParam);
        let ok = confirm("点击确定给红八字会赞助？");
        console.log("用户操作：" + ok);
        if(ok) {
            let MOCK_HOST = this.mockHost;
            let url = "http://"+MOCK_HOST+":10010/pay/yezixi/mock";
            let cop = clientOrderParam;
            let bodyStr = "warename="+cop.warename+"&count="+cop.count+"&paybill="+cop.paybill+
                "&serverid="+cop.serverid+"&roleid="+cop.roleid+"&extstr="+cop.extstr;
            window.tools.postForm(url, bodyStr, function (httpRequest) {
                if (httpRequest.readyState == 4 && httpRequest.status == 200) {
                    let resp = httpRequest.responseText;
                    console.log("收到服务器返回=", resp);
                    let r_pcb = JSON.parse(resp);
                    console.log("转为对象", r_pcb);
                    if(r_pcb.errorcode != 0) {
                        payCallback({status: -300, statusText: r_pcb.errormsg});
                        return
                    }
                    let pcb = r_pcb.data;
                    let urlCB = "http://"+MOCK_HOST+":10010/payback/yezixi";
                    let bodyCB = "appid="+pcb.appid+"&extstr="+pcb.extstr+"&feemoney="+pcb.feemoney+"&openid="+pcb.openid+
                        "&orderid="+pcb.orderid+"&paystatus="+pcb.paystatus+"&paytime="+pcb.paytime+"&prover="+pcb.prover+
                        "&serverid="+pcb.serverid+"&sign="+pcb.sign;
                    window.tools.postForm(urlCB, bodyCB, function(req) {
                        if (httpRequest.readyState == 4 && httpRequest.status == 200) {
                            console.log("服务器回调回应:", req.responseText);
                            payCallback({status: 200, statusText: "支付成功"});
                        } else {
                            alert("模拟回调故障");
                        }
                    });
                }
            })
        } else {
            payCallback({status: -300, statusText: "取消支付"});
        }
    },
    setShareInfo: function(params, callback) {
        //
    },
    share: function(params, callback) {
        //
    },
    isSubscribe: function(callback) {
        //
    },
    dialog: function() {
        //
    },
}