(function () {
  "use strict";

  var processing = new Set();
  var walletPolling = false;

  function getCookie(name) {
    var prefix = name + "=";
    var parts = decodeURIComponent(document.cookie || "").split(";");
    for (var i = 0; i < parts.length; i += 1) {
      var value = parts[i].trim();
      if (value.indexOf(prefix) === 0) return value.substring(prefix.length);
    }
    return "";
  }

  function api(action, data) {
    return fetch("/api/index.php", {
      method: "POST",
      credentials: "same-origin",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        token: getCookie("token"),
        controller: "service",
        action: action,
        data: data
      })
    }).then(function (response) { return response.json(); }).then(function (body) {
      if (!body || body.code !== 200) throw new Error(body && body.msg ? body.msg : "Máy chủ không phản hồi");
      return body;
    });
  }

  function money(value) {
    return Number(value || 0).toLocaleString("vi-VN");
  }

  function callback(source, origin, status, text) {
    if (!source || typeof source.postMessage !== "function") return;
    source.postMessage({ type: "TFPayCallback", data: { status: status, statusText: text } }, origin);
  }

  function compactNumber(value) {
    var number = Number(value || 0);
    var units = [[1000000000, "b"], [1000000, "m"], [1000, "k"]];
    for (var i = 0; i < units.length; i += 1) {
      if (Math.abs(number) >= units[i][0]) {
        return (Math.round(number / units[i][0] * 10) / 10).toString().replace(".0", "") + units[i][1];
      }
    }
    return money(number);
  }

  function syncWalletChip(name, value) {
    var chips = document.querySelectorAll(".UiChip");
    var color = "var(--ui-" + name + ")";
    for (var i = 0; i < chips.length; i += 1) {
      if ((chips[i].getAttribute("style") || "").indexOf(color) === -1) continue;
      var textNode = chips[i].querySelector(".UiText");
      if (textNode) textNode.textContent = compactNumber(value);
    }
  }

  function syncWallet(wallet) {
    if (!wallet) return;
    if (wallet.coin != null) syncWalletChip("coin", wallet.coin);
    if (wallet.coin_lock != null) syncWalletChip("coin-lock", wallet.coin_lock);
    if (wallet.diamond != null) syncWalletChip("diamond", wallet.diamond);
    if (wallet.wheel != null) syncWalletChip("wheel", wallet.wheel);
    try {
      var app = document.getElementById("app");
      var vm = app && app.__vue__;
      var profile = vm && vm.$store && vm.$store.state.user.profile;
      if (!profile) return;
      var next = Object.assign({}, profile, wallet);
      vm.$store.commit("setUser", next);
    }
    catch (error) {}
  }

  function showGMNotifications(notifications) {
    if (!notifications || !notifications.length) return;
    var message = notifications.map(function (item) { return item.content; }).join("\n\n");
    if (window.swal) {
      window.swal("Số dư vừa được cập nhật", message, "success");
      return;
    }
    window.alert(message);
  }

  function pollWallet() {
    if (walletPolling || !getCookie("token")) return;
    walletPolling = true;
    api("pollWallet", {}).then(function (body) {
      var data = body.data || {};
      syncWallet(data.wallet);
      showGMNotifications(data.notifications || []);
    }).catch(function (error) {
      console.warn("[GM wallet sync]", error && error.message ? error.message : error);
    }).then(function () {
      walletPolling = false;
    });
  }

  window.setTimeout(pollWallet, 1500);
  window.setInterval(pollWallet, 4000);

  function alertError(message) {
    if (window.swal) return window.swal("Không thể mua", message, "error");
    window.alert(message);
    return Promise.resolve();
  }

  function confirmQuote(quote) {
    var text = "Gói: " + quote.item_name + "\n" +
      "Giá: " + money(quote.price) + " Xu\n" +
      "Xu vàng: " + money(quote.coin) + "\n" +
      "Số dư nạp thực: " + money(quote.cash_coin) + "\n" +
      "Có thể thanh toán: " + money(quote.total) + "\n" +
      "Xu xanh lá: " + money(quote.coin_lock) + " (không dùng cho gói VNĐ)\n\n" + quote.wallet_policy;
    if (!window.swal) return Promise.resolve(window.confirm(text));
    return window.swal({
      title: "Xác nhận mua gói",
      text: text,
      icon: "warning",
      buttons: { cancel: "Hủy", confirm: "Mua ngay" },
      dangerMode: false
    });
  }

  window.addEventListener("message", function (event) {
    if (event.origin !== window.location.origin || !event.data || event.data.type !== "TFPay2") return;
    var frame = document.querySelector("iframe");
    if (!frame || event.source !== frame.contentWindow) return;

    var order = event.data.data || {};
    var orderUid = String(order.extstr || "");
    if (!orderUid || processing.has(orderUid)) {
      callback(event.source, event.origin, -300, "Đơn mua đang được xử lý");
      return;
    }
    processing.add(orderUid);

    api("quoteGameOrder", order).then(function (body) {
      var quote = body.data;
      if (!quote.can_afford) throw new Error("Không đủ số dư nạp thực. Cần " + money(quote.price) + " nhưng chỉ có thể thanh toán " + money(quote.total) + ".");
      return confirmQuote(quote).then(function (accepted) {
        if (!accepted) throw { cancelled: true, message: "Bạn đã hủy giao dịch" };
        return api("buyGameOrder", order);
      });
    }).then(function (body) {
      var result = body.data || {};
      syncWallet(result.wallet);
      callback(event.source, event.origin, 200, "Thanh toán thành công");
      if (window.swal) {
        window.swal("Mua thành công", "Đã trừ " + money(result.price) + " Xu và giao vật phẩm trong game.", "success");
      }
    }).catch(function (error) {
      callback(event.source, event.origin, -300, error.message || "Thanh toán thất bại");
      if (!error.cancelled) alertError(error.message || "Thanh toán thất bại");
    }).then(function () {
      processing.delete(orderUid);
    });
  }, false);
}());
