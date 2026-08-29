(function () {
  "use strict";

  var enhanced = new WeakSet();
  var fallbackImages = {
    item: "/client/images/icon/item_game.png",
    news: "/client/images/news.png",
    avatar: "/client/images/avatar/0.webp"
  };
  var routeMap = {
    home: "Trang chủ",
    game: "Chơi ngay",
    pay: "Nạp Xu",
    shop: "Cửa Hàng",
    event: "Sự Kiện",
    mission: "Nhiệm Vụ",
    wheel: "Vòng Quay",
    rank: "Xếp Hạng",
    giftcode: "GiftCode"
  };
  var cp1252Decode = {
    128: "€", 130: "‚", 131: "ƒ", 132: "„", 133: "…", 134: "†", 135: "‡", 136: "ˆ", 137: "‰",
    138: "Š", 139: "‹", 140: "Œ", 142: "Ž", 145: "‘", 146: "’", 147: "“", 148: "”",
    149: "•", 150: "–", 151: "—", 152: "˜", 153: "™", 154: "š", 155: "›", 156: "œ",
    158: "ž", 159: "Ÿ"
  };
  var cp1252Encode = {
    "€": 128, "‚": 130, "ƒ": 131, "„": 132, "…": 133, "†": 134, "‡": 135, "ˆ": 136, "‰": 137,
    "Š": 138, "‹": 139, "Œ": 140, "Ž": 142, "‘": 145, "’": 146, "“": 147, "”": 148,
    "•": 149, "–": 150, "—": 151, "˜": 152, "™": 153, "š": 154, "›": 155, "œ": 156,
    "ž": 158, "Ÿ": 159
  };
  var vietMojibakeMap;

  function activeLabel() {
    var segment = location.pathname.split("/").filter(Boolean).pop() || "home";
    return routeMap[segment] || "";
  }

  function cp1252ByteToChar(byte) {
    return cp1252Decode[byte] || String.fromCharCode(byte);
  }

  function buildVietMojibakeMap() {
    if (vietMojibakeMap) return vietMojibakeMap;
    var chars = "ÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚÝàáâãèéêìíòóôõùúýĂăĐđĨĩŨũƠơƯưẠạẢảẤấẦầẨẩẪẫẬậẮắẰằẲẳẴẵẶặẸẹẺẻẼẽẾếỀềỂểỄễỆệỈỉỊịỌọỎỏỐốỒồỔổỖỗỘộỚớỜờỞởỠỡỢợỤụỦủỨứỪừỬửỮữỰựỲỳỴỵỶỷỸỹ";
    var encoder = window.TextEncoder ? new TextEncoder() : null;
    vietMojibakeMap = {};
    if (!encoder) return vietMojibakeMap;
    Array.prototype.forEach.call(chars, function (char) {
      var bytes = encoder.encode(char);
      var bad = Array.prototype.map.call(bytes, cp1252ByteToChar).join("");
      if (bad !== char) vietMojibakeMap[bad] = char;
    });
    return vietMojibakeMap;
  }

  function looksMojibake(text) {
    return /(?:Ã|Â|Æ|Ä|Å|áº|á»|â|ð|Ð|¤|¥|»|º)/.test(text);
  }

  function decodeWholeMojibake(text) {
    if (!window.TextDecoder || !looksMojibake(text)) return text;
    var bytes = [];
    for (var i = 0; i < text.length; i += 1) {
      var ch = text.charAt(i);
      var code = text.charCodeAt(i);
      if (code <= 255) bytes.push(code);
      else if (cp1252Encode[ch] != null) bytes.push(cp1252Encode[ch]);
      else return text;
    }
    try {
      var decoded = new TextDecoder("utf-8", { fatal: false }).decode(new Uint8Array(bytes));
      if (!decoded || decoded === text || decoded.indexOf("�") !== -1) return text;
      return decoded;
    } catch (_) {
      return text;
    }
  }

  function polishText(text) {
    if (!text) return text;
    return text
      .replace(/Admin\s+Pannel/g, "Admin Panel")
      .replace(/Gifttcode/g, "GiftCode")
      .replace(/Chiến Ma Â· Neon Realm/g, "Chiến Ma · Neon Realm")
      .replace(/\s+([,.!?;:])/g, "$1");
  }

  function decodeMojibake(text) {
    if (!text) return text;
    if (!looksMojibake(text)) return polishText(text);
    var next = decodeWholeMojibake(text);
    var map = buildVietMojibakeMap();
    Object.keys(map).sort(function (a, b) { return b.length - a.length; }).forEach(function (bad) {
      next = next.split(bad).join(map[bad]);
    });
    return polishText(next);
  }

  function fixMojibake(root) {
    root = root || document.body;
    if (!root) return;

    var walker = document.createTreeWalker(root, NodeFilter.SHOW_TEXT, {
      acceptNode: function (node) {
        if (!node.nodeValue || (!looksMojibake(node.nodeValue) && node.nodeValue.indexOf("Pannel") === -1 && node.nodeValue.indexOf("Gifttcode") === -1)) return NodeFilter.FILTER_REJECT;
        var parent = node.parentElement;
        if (!parent || /SCRIPT|STYLE|TEXTAREA|CODE|PRE/.test(parent.tagName)) return NodeFilter.FILTER_REJECT;
        return NodeFilter.FILTER_ACCEPT;
      }
    });
    var nodes = [];
    while (walker.nextNode()) nodes.push(walker.currentNode);
    nodes.forEach(function (node) {
      var decoded = decodeMojibake(node.nodeValue);
      if (decoded !== node.nodeValue) node.nodeValue = decoded;
    });

    root.querySelectorAll("[placeholder],[title],[aria-label],input[value],button[value]").forEach(function (element) {
      ["placeholder", "title", "aria-label", "value"].forEach(function (attr) {
        if (!element.hasAttribute(attr)) return;
        var value = element.getAttribute(attr);
        var decoded = decodeMojibake(value);
        if (decoded !== value) element.setAttribute(attr, decoded);
      });
    });
  }

  function addTilt(element, strength) {
    if (!element || enhanced.has(element) || matchMedia("(prefers-reduced-motion: reduce)").matches) return;
    enhanced.add(element);
    element.addEventListener("pointermove", function (event) {
      if (event.pointerType === "touch") return;
      var rect = element.getBoundingClientRect();
      var x = (event.clientX - rect.left) / rect.width - 0.5;
      var y = (event.clientY - rect.top) / rect.height - 0.5;
      element.style.setProperty("--neo-rx", (-y * strength).toFixed(2) + "deg");
      element.style.setProperty("--neo-ry", (x * strength).toFixed(2) + "deg");
    }, { passive: true });
    element.addEventListener("pointerleave", function () {
      element.style.setProperty("--neo-rx", "0deg");
      element.style.setProperty("--neo-ry", "0deg");
    }, { passive: true });
  }

  function imageFallback(image) {
    if (!image || image.tagName !== "IMG" || image.dataset.neoFallback) return;
    var src = image.currentSrc || image.src || "";
    var alt = (image.alt || "").toLowerCase();
    var fallback = alt === "news" ? fallbackImages.news :
      (src.indexOf("/avatar/") !== -1 ? fallbackImages.avatar : fallbackImages.item);
    if (src.indexOf(fallback) !== -1) return;
    image.dataset.neoFallback = "true";
    image.src = fallback;
  }

  function portalDialogs() {
    var dialogs = Array.prototype.slice.call(document.querySelectorAll(".UiDialog"));
    var hasDialogs = dialogs.length > 0;
    dialogs.forEach(function (dialog) {
      if (!dialog) return;
      dialog.classList.add("neo-dialog-portal");
      dialog.dataset.neoPortal = "body";
      dialog.style.position = "fixed";
      dialog.style.inset = "0";
      dialog.style.zIndex = "2147483647";
      dialog.style.width = "100vw";
      dialog.style.height = "100dvh";
      var content = dialog.querySelector(".UiDialog__Content");
      if (content) {
        content.style.zIndex = "2";
        content.style.position = "relative";
      }
      var overlay = dialog.querySelector(".UiDialog__Overlay");
      if (overlay) {
        overlay.style.zIndex = "0";
      }
      if (dialog.parentNode !== document.body) {
        document.body.appendChild(dialog);
      }
      setTimeout(function () {
        if (dialog.parentNode !== document.body && document.body.contains(dialog)) {
          document.body.appendChild(dialog);
        }
      }, 0);
    });
    document.body.classList.toggle("neo-dialog-open", hasDialogs);
  }

  function closeTopDialog() {
    var dialogs = Array.prototype.slice.call(document.querySelectorAll("body > .UiDialog, .UiDialog"));
    var dialog = dialogs.reverse().find(function (item) {
      return item && item.getClientRects().length > 0;
    });
    if (!dialog) return false;
    var overlay = dialog.querySelector(".UiDialog__Overlay");
    if (!overlay) return false;
    overlay.dispatchEvent(new MouseEvent("click", {
      bubbles: true,
      cancelable: true,
      view: window
    }));
    return true;
  }

  function closeOnBlankClick(event) {
    var target = event.target;
    if (!target || !(target instanceof Element)) return;

    var menu = target.closest(".GameLayoutMenu");
    if (!menu) return;

    var interactive = target.closest(
      "button,a,input,select,textarea,.UiButton,.UiChip,.UiItem,.UiCard,.UiBox,.UiTab,.Tab,.UiInput,.UiSelect,img"
    );
    if (interactive) return;

    if (target === menu || target.classList.contains("MenuView") || target.closest(".MenuView")) {
      if (closeTopDialog()) {
        event.preventDefault();
        event.stopPropagation();
      }
    }
  }

  function findVueRouter() {
    var app = document.querySelector("#app");
    if (app && app.__vue__ && app.__vue__.$router) return app.__vue__.$router;

    var nodes = document.querySelectorAll("#app *");
    for (var i = 0; i < nodes.length; i += 1) {
      if (nodes[i].__vue__ && nodes[i].__vue__.$router) return nodes[i].__vue__.$router;
    }
    return null;
  }

  function normalizeClientRoute(href) {
    try {
      var url = new URL(href, window.location.origin);
      if (url.origin !== window.location.origin || url.pathname.indexOf("/client/") !== 0) return null;
      return url.pathname.replace(/^\/client/, "") + url.search + url.hash;
    } catch (error) {
      return null;
    }
  }

  function updateAdminQuickDeckActive() {
    document.querySelectorAll(".NeoAdminQuickDeck a[href]").forEach(function (link) {
      var path = normalizeClientRoute(link.getAttribute("href"));
      link.classList.toggle("is-active", !!path && window.location.pathname === "/client" + path.split(/[?#]/)[0]);
    });
  }

  function handleAdminQuickDeckClick(event) {
    var link = event.target && event.target.closest ? event.target.closest(".NeoAdminQuickDeck a[href]") : null;
    if (!link) return;

    var routePath = normalizeClientRoute(link.getAttribute("href"));
    if (!routePath) return;

    event.preventDefault();
    event.stopPropagation();

    var router = findVueRouter();
    if (router && router.currentRoute && router.currentRoute.fullPath !== routePath) {
      var pushed = router.push(routePath);
      if (pushed && pushed.catch) pushed.catch(function () {});
    } else if (!router && window.location.pathname + window.location.search + window.location.hash !== "/client" + routePath) {
      window.history.pushState({}, "", "/client" + routePath);
      window.dispatchEvent(new PopStateEvent("popstate", { state: history.state }));
    }

    setTimeout(function () {
      updateAdminQuickDeckActive();
      enhance();
    }, 60);
  }

  function addAdminQuickDeck() {
    var sidebar = document.querySelector(".AdminLayoutSidebar__Body");
    if (!sidebar || sidebar.querySelector(".NeoAdminQuickDeck")) return;
    var deck = document.createElement("div");
    deck.className = "NeoAdminQuickDeck";
    deck.innerHTML =
      '<div class="NeoAdminQuickDeck__Title">GM / S&#7921; ki&#7879;n nhanh</div>' +
      '<div class="NeoAdminQuickDeck__Grid">' +
      '<a href="/client/admin/activate-event">S&#7921; ki&#7879;n n&#7841;p/ti&#234;u</a>' +
      '<a href="/client/admin/shop-recharge">G&#243;i n&#7841;p</a>' +
      '<a href="/client/admin/shop-item">Shop v&#7853;t ph&#7849;m</a>' +
      '<a href="/client/admin/shop-currency">Ti&#7873;n t&#7879;</a>' +
      '<a href="/client/admin/action-send">G&#7917;i GM</a>' +
      '<a href="/client/admin/log-event">Log nh&#7853;n qu&#224;</a>' +
      '</div>';
    sidebar.insertBefore(deck, sidebar.firstChild);
    updateAdminQuickDeckActive();
    return;
    deck.innerHTML =
      '<div class="NeoAdminQuickDeck__Title">GM / Sự kiện nhanh</div>' +
      '<div class="NeoAdminQuickDeck__Grid">' +
      '<a href="/client/admin/activate-event">Sự kiện nạp/tiêu</a>' +
      '<a href="/client/admin/shop-recharge">Gói nạp</a>' +
      '<a href="/client/admin/shop-item">Shop vật phẩm</a>' +
      '<a href="/client/admin/shop-currency">Tiền tệ</a>' +
      '<a href="/client/admin/action-send">Gửi GM</a>' +
      '<a href="/client/admin/log-event">Log nhận quà</a>' +
      '</div>';
    sidebar.insertBefore(deck, sidebar.firstChild);
  }

  function normalizeCurrencyPresentation(root) {
    root = root || document.body;
    if (!root) return;

    root.querySelectorAll("img").forEach(function (img) {
      var src = img.getAttribute("src") || "";
      if (/\/999999\.png(?:$|\?)/.test(src)) {
        img.setAttribute("src", src.replace(/\/999999\.png(?:$|\?)/, "/wealth999999.png"));
      }
      if ((img.getAttribute("alt") || "").indexOf("Huy Ch") !== -1) img.setAttribute("alt", "Linh Ngọc");
      if ((img.getAttribute("title") || "").indexOf("Huy Ch") !== -1) img.setAttribute("title", "Linh Ngọc");
    });

    var walker = document.createTreeWalker(root, NodeFilter.SHOW_TEXT, {
      acceptNode: function (node) {
        if (!node.nodeValue || node.nodeValue.indexOf("Huy Ch") === -1) return NodeFilter.FILTER_REJECT;
        var parent = node.parentElement;
        if (!parent || /SCRIPT|STYLE|TEXTAREA|CODE|PRE/.test(parent.tagName)) return NodeFilter.FILTER_REJECT;
        return NodeFilter.FILTER_ACCEPT;
      }
    });
    var nodes = [];
    while (walker.nextNode()) nodes.push(walker.currentNode);
    nodes.forEach(function (node) {
      node.nodeValue = node.nodeValue
        .replace(/Huy Chương Trải Nghiệm/g, "Linh Ngọc")
        .replace(/Huy chương kỷ niệm dành cho người chơi trải nghiệm Meow 3Q/g, "Tiền tệ nạp dùng để mua gói VIP, ưu đãi và vật phẩm đặc biệt.");
    });
  }

  function hardenItemDialogLayout() {
    var open = document.querySelectorAll("body > .UiDialog, .UiDialog").length > 0;
    document.body.classList.toggle("neo-dialog-open", open);
    if (!open) return;
    document.querySelectorAll(".EventView .UiScrollX, .EventList .UiScrollX, .EventMilestone .ListGift").forEach(function (list) {
      list.style.maxWidth = "100%";
      list.style.overflowX = "auto";
      list.style.overflowY = "hidden";
    });
  }

  function repairLinhNgocText(root) {
    root = root || document.body;
    if (!root) return;

    root.querySelectorAll("img").forEach(function (img) {
      ["alt", "title"].forEach(function (attr) {
        var value = img.getAttribute(attr) || "";
        if (value.indexOf("Huy Ch") !== -1 || value.indexOf("Linh Ng") !== -1) {
          img.setAttribute(attr, "Linh Ng\u1ecdc");
        }
      });
    });

    var walker = document.createTreeWalker(root, NodeFilter.SHOW_TEXT, {
      acceptNode: function (node) {
        if (!node.nodeValue) return NodeFilter.FILTER_REJECT;
        if (node.nodeValue.indexOf("Huy Ch") === -1 && node.nodeValue.indexOf("Linh Ng") === -1) {
          return NodeFilter.FILTER_REJECT;
        }
        var parent = node.parentElement;
        if (!parent || /SCRIPT|STYLE|TEXTAREA|CODE|PRE/.test(parent.tagName)) return NodeFilter.FILTER_REJECT;
        return NodeFilter.FILTER_ACCEPT;
      }
    });
    var nodes = [];
    while (walker.nextNode()) nodes.push(walker.currentNode);
    nodes.forEach(function (node) {
      node.nodeValue = node.nodeValue
        .replace(/Huy Chương Trải Nghiệm/g, "Linh Ng\u1ecdc")
        .replace(/Huy ChÆ°Æ¡ng Tráº£i Nghiá»‡m/g, "Linh Ng\u1ecdc")
        .replace(/Linh Ngá»c/g, "Linh Ng\u1ecdc")
        .replace(/Huy chương kỷ niệm dành cho người chơi trải nghiệm Meow 3Q/g, "Ti\u1ec1n t\u1ec7 n\u1ea1p d\u00f9ng \u0111\u1ec3 mua g\u00f3i VIP, \u01b0u \u0111\u00e3i v\u00e0 v\u1eadt ph\u1ea9m \u0111\u1eb7c bi\u1ec7t.")
        .replace(/Huy chÆ°Æ¡ng ká»· niá»‡m dÃ nh cho ngÆ°á»i chÆ¡i tráº£i nghiá»‡m Meow 3Q/g, "Ti\u1ec1n t\u1ec7 n\u1ea1p d\u00f9ng \u0111\u1ec3 mua g\u00f3i VIP, \u01b0u \u0111\u00e3i v\u00e0 v\u1eadt ph\u1ea9m \u0111\u1eb7c bi\u1ec7t.");
    });
  }

  function tuneAdminPageLabels() {
    if (window.location.pathname.indexOf("/client/admin/") !== 0) return;

    var labels = {
      "/client/admin/shop-recharge": "Gói nạp / Mốc nạp",
      "/client/admin/shop-item": "Shop vật phẩm",
      "/client/admin/shop-currency": "Tiền tệ",
      "/client/admin/shop-effect": "Hiệu ứng",
      "/client/admin/action-gift": "Bộ quà tặng dùng chung",
      "/client/admin/log-shop": "Lịch sử cửa hàng",
      "/client/admin/log-event": "Lịch sử nhận sự kiện",
      "/client/admin/activate-event": "Sự kiện nạp / tiêu phí"
    };
    var label = labels[window.location.pathname];
    if (!label) return;

    document.title = label + " - 3Q Chiến Ma";
    document.querySelectorAll(".AdminLayoutHeader .UiText, .AdminLayoutHeader [class*='Title'], .AdminLayoutHeader b").forEach(function (node) {
      var text = (node.textContent || "").trim();
      if (!text || text.length > 40) return;
      if (text.indexOf("Bộ quà") !== -1 || text.indexOf("Gói nạp") !== -1 || text.indexOf("Cửa hàng") !== -1 || text.indexOf("Sự kiện") !== -1) {
        node.textContent = label;
      }
    });
  }

  function enhance() {
    document.documentElement.classList.add("neo-2026");

    var themeColor = document.querySelector('meta[name="theme-color"]');
    if (!themeColor) {
      themeColor = document.createElement("meta");
      themeColor.name = "theme-color";
      document.head.appendChild(themeColor);
    }
    themeColor.content = "#060812";

    var label = activeLabel().toLowerCase();
    document.querySelectorAll(".ServiceLayoutSidebar .Item").forEach(function (item) {
      var text = (item.textContent || "").trim().toLowerCase();
      item.classList.toggle("neo-active", text === label);
    });

    var banner = document.querySelector(".ServiceLayoutBanner");
    if (banner && !banner.querySelector(".NeoHeroMeta")) {
      var meta = document.createElement("div");
      meta.className = "NeoHeroMeta";
      meta.innerHTML =
        '<div><span class="NeoHeroMeta__eyebrow">3Q // NEXT GENERATION</span>' +
        '<strong class="NeoHeroMeta__title">Chiến Ma · Neon Realm</strong></div>' +
        '<span class="NeoHeroMeta__status">S1 Online</span>';
      banner.appendChild(meta);
    }
    addTilt(banner, 3.2);
    document.querySelectorAll(".HomeNews .News").forEach(function (card) { addTilt(card, 4.4); });
    document.querySelectorAll("img").forEach(function (image) {
      if (image.complete && image.naturalWidth === 0) imageFallback(image);
    });
    fixMojibake(document.body);
    normalizeCurrencyPresentation(document.body);
    repairLinhNgocText(document.body);
    tuneAdminPageLabels();
    addAdminQuickDeck();
    updateAdminQuickDeckActive();
    portalDialogs();
    hardenItemDialogLayout();
  }

  function boot() {
    document.addEventListener("error", function (event) {
      imageFallback(event.target);
    }, true);
    enhance();
    var queued = false;
    new MutationObserver(function () {
      if (queued) return;
      queued = true;
      requestAnimationFrame(function () {
        queued = false;
        enhance();
      });
    }).observe(document.body, { childList: true, subtree: true });
    document.addEventListener("pointerup", function () { setTimeout(enhance, 0); }, true);
    document.addEventListener("click", function () { setTimeout(enhance, 0); }, true);
    document.addEventListener("click", handleAdminQuickDeckClick, true);
    document.addEventListener("click", closeOnBlankClick, true);
    window.addEventListener("popstate", function () { setTimeout(enhance, 0); });
    window.addEventListener("hashchange", function () { setTimeout(enhance, 0); });
  }

  if (document.readyState === "loading") document.addEventListener("DOMContentLoaded", boot, { once: true });
  else boot();
}());
