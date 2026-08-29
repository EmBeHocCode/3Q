(function () {
  "use strict";

  var SPEED_KEY = "meow_3q_global_speed";
  var OPEN_KEY = "meow_3q_global_speed_open";
  var HIDDEN_KEY = "meow_3q_global_speed_hidden";
  var POS_KEY = "meow_3q_global_speed_pos";
  var SPEEDS = [1, 2, 3, 5];
  var currentSpeed = readSpeed();
  var isOpen = localStorage.getItem(OPEN_KEY) === "1";
  var isHidden = localStorage.getItem(HIDDEN_KEY) === "1";
  var panel = null;
  var clickWasDrag = false;

  function readSpeed() {
    var value = Number(localStorage.getItem(SPEED_KEY) || 1);
    return SPEEDS.indexOf(value) !== -1 ? value : 1;
  }

  function saveSpeed(value) {
    currentSpeed = SPEEDS.indexOf(value) !== -1 ? value : 1;
    localStorage.setItem(SPEED_KEY, String(currentSpeed));
  }

  function applySpeed() {
    if (!window.Laya || !Laya.timer) return false;
    Laya.timer.scale = currentSpeed;
    if (Laya.stage) Laya.stage.renderingEnabled = true;
    refreshPanel();
    return true;
  }

  function setSpeed(value) {
    saveSpeed(value);
    applySpeed();
  }

  function setOpen(value) {
    isOpen = !!value;
    localStorage.setItem(OPEN_KEY, isOpen ? "1" : "0");
    refreshPanel();
  }

  function setHidden(value) {
    isHidden = !!value;
    if (isHidden) isOpen = false;
    localStorage.setItem(HIDDEN_KEY, isHidden ? "1" : "0");
    localStorage.setItem(OPEN_KEY, isOpen ? "1" : "0");
    refreshPanel();
  }

  function refreshPanel() {
    if (!panel) return;
    panel.classList.toggle("is-open", isOpen && !isHidden);
    panel.classList.toggle("is-hidden", isHidden);
    panel.querySelectorAll("[data-speed]").forEach(function (button) {
      var speed = Number(button.getAttribute("data-speed"));
      button.classList.toggle("is-active", speed === currentSpeed);
    });
    panel.querySelectorAll(".MeowSpeed__CurrentText").forEach(function (label) {
      label.textContent = "x" + currentSpeed;
    });
  }

  function readPosition() {
    try {
      var pos = JSON.parse(localStorage.getItem(POS_KEY) || "null");
      if (pos && isFinite(pos.left) && isFinite(pos.top)) return pos;
    } catch (e) {}
    return {
      left: 8,
      top: Math.max(86, Math.round(window.innerHeight * 0.44))
    };
  }

  function savePosition(left, top) {
    localStorage.setItem(POS_KEY, JSON.stringify({ left: left, top: top }));
  }

  function clampPosition(left, top) {
    var maxLeft = Math.max(4, window.innerWidth - 64);
    var maxTop = Math.max(4, window.innerHeight - 48);
    return {
      left: Math.min(Math.max(4, left), maxLeft),
      top: Math.min(Math.max(56, top), maxTop)
    };
  }

  function placePanel() {
    if (!panel) return;
    var pos = clampPosition(readPosition().left, readPosition().top);
    panel.style.left = pos.left + "px";
    panel.style.top = pos.top + "px";
  }

  function getPoint(event) {
    var source = event.touches && event.touches[0] ? event.touches[0] : event;
    return { x: source.clientX, y: source.clientY };
  }

  function enableDrag(handle) {
    var dragging = false;
    var start = null;
    var origin = null;

    function move(event) {
      if (!dragging) return;
      var point = getPoint(event);
      var dx = point.x - start.x;
      var dy = point.y - start.y;
      if (Math.abs(dx) + Math.abs(dy) > 6) clickWasDrag = true;
      var next = clampPosition(origin.left + dx, origin.top + dy);
      panel.style.left = next.left + "px";
      panel.style.top = next.top + "px";
      event.preventDefault();
    }

    function end() {
      if (!dragging) return;
      dragging = false;
      savePosition(parseInt(panel.style.left, 10) || 8, parseInt(panel.style.top, 10) || 86);
      window.removeEventListener("mousemove", move);
      window.removeEventListener("mouseup", end);
      window.removeEventListener("touchmove", move);
      window.removeEventListener("touchend", end);
      setTimeout(function () { clickWasDrag = false; }, 0);
    }

    function down(event) {
      var target = event.target;
      if (target && target.getAttribute && target.getAttribute("data-speed")) return;
      dragging = true;
      clickWasDrag = false;
      start = getPoint(event);
      origin = {
        left: parseInt(panel.style.left, 10) || 8,
        top: parseInt(panel.style.top, 10) || 86
      };
      window.addEventListener("mousemove", move, { passive: false });
      window.addEventListener("mouseup", end);
      window.addEventListener("touchmove", move, { passive: false });
      window.addEventListener("touchend", end);
    }

    handle.addEventListener("mousedown", down);
    handle.addEventListener("touchstart", down, { passive: true });
  }

  function createPanel() {
    if (panel || document.getElementById("MeowGlobalSpeed")) return;

    panel = document.createElement("div");
    panel.id = "MeowGlobalSpeed";
    panel.innerHTML =
      '<button class="MeowSpeed__Wake" title="Hiện điều khiển tốc độ">⚡</button>' +
      '<div class="MeowSpeed__Dock">' +
        '<button class="MeowSpeed__Handle" title="Bấm để mở/thu, kéo để đổi vị trí">' +
          '<span class="MeowSpeed__Bolt">⚡</span><span class="MeowSpeed__CurrentText">x' + currentSpeed + '</span>' +
        '</button>' +
        '<div class="MeowSpeed__Options">' +
          SPEEDS.map(function (speed) {
            return '<button data-speed="' + speed + '">x' + speed + '</button>';
          }).join("") +
          '<button class="MeowSpeed__Hide" title="Ẩn nút speed">Ẩn</button>' +
        '</div>' +
      '</div>';

    var style = document.createElement("style");
    style.textContent =
      '#MeowGlobalSpeed{position:fixed;left:8px;top:44vh;z-index:2147483647;font-family:Arial,"Microsoft YaHei",sans-serif;pointer-events:auto;user-select:none;-webkit-user-select:none;touch-action:none}' +
      '#MeowGlobalSpeed *{box-sizing:border-box}' +
      '#MeowGlobalSpeed button{border:0;outline:0;font-family:inherit;cursor:pointer;-webkit-tap-highlight-color:transparent}' +
      '#MeowGlobalSpeed .MeowSpeed__Dock{display:flex;align-items:center;gap:5px;padding:4px;border:1px solid rgba(255,220,117,.76);border-radius:18px;background:linear-gradient(135deg,rgba(47,30,16,.94),rgba(13,18,38,.92));box-shadow:0 6px 16px rgba(0,0,0,.38),inset 0 1px 0 rgba(255,255,255,.18),0 0 14px rgba(255,183,55,.22)}' +
      '#MeowGlobalSpeed .MeowSpeed__Handle{height:30px;min-width:52px;padding:0 9px;display:flex;align-items:center;justify-content:center;gap:4px;border-radius:15px;color:#2b1502;background:linear-gradient(180deg,#fff2a4,#e7a63d 55%,#9f5b17);box-shadow:inset 0 1px 0 rgba(255,255,255,.75),0 2px 5px rgba(0,0,0,.25);font-size:12px;font-weight:900;text-shadow:0 1px 0 rgba(255,255,255,.42)}' +
      '#MeowGlobalSpeed .MeowSpeed__Bolt{font-size:13px;color:#6d3300}' +
      '#MeowGlobalSpeed .MeowSpeed__Options{display:none;align-items:center;gap:4px;overflow:hidden}' +
      '#MeowGlobalSpeed.is-open .MeowSpeed__Options{display:flex}' +
      '#MeowGlobalSpeed [data-speed],#MeowGlobalSpeed .MeowSpeed__Hide{height:28px;min-width:32px;padding:0 8px;border:1px solid rgba(255,255,255,.18);border-radius:14px;color:#f9ead2;background:linear-gradient(180deg,rgba(80,58,41,.96),rgba(28,34,55,.94));font-size:11px;font-weight:900;text-shadow:0 1px 2px rgba(0,0,0,.75)}' +
      '#MeowGlobalSpeed [data-speed].is-active{color:#032015;border-color:rgba(161,255,223,.95);background:linear-gradient(180deg,#7dffe3,#24d6a3 58%,#13926e);box-shadow:0 0 10px rgba(38,232,174,.45),inset 0 1px 0 rgba(255,255,255,.65)}' +
      '#MeowGlobalSpeed .MeowSpeed__Hide{min-width:34px;color:#ffe7c0;background:linear-gradient(180deg,#8b3d33,#4a1f25)}' +
      '#MeowGlobalSpeed .MeowSpeed__Wake{display:none;width:30px;height:30px;border-radius:15px;color:#2b1502;background:linear-gradient(180deg,#fff2a4,#e7a63d 55%,#9f5b17);box-shadow:0 4px 12px rgba(0,0,0,.36),0 0 12px rgba(255,183,55,.25);font-size:14px;font-weight:900}' +
      '#MeowGlobalSpeed.is-hidden .MeowSpeed__Dock{display:none}' +
      '#MeowGlobalSpeed.is-hidden .MeowSpeed__Wake{display:block}' +
      '@media (max-width:520px){#MeowGlobalSpeed.is-open .MeowSpeed__Dock{border-radius:16px}#MeowGlobalSpeed.is-open .MeowSpeed__Options{display:grid;grid-template-columns:repeat(3,32px);gap:4px}#MeowGlobalSpeed.is-open .MeowSpeed__Hide{grid-column:auto}}';

    document.head.appendChild(style);
    document.body.appendChild(panel);
    placePanel();

    var handle = panel.querySelector(".MeowSpeed__Handle");
    enableDrag(handle);
    handle.addEventListener("click", function () {
      if (clickWasDrag) return;
      setOpen(!isOpen);
    });
    panel.querySelector(".MeowSpeed__Wake").addEventListener("click", function () {
      setHidden(false);
    });
    panel.querySelector(".MeowSpeed__Hide").addEventListener("click", function () {
      setHidden(true);
    });
    panel.querySelectorAll("[data-speed]").forEach(function (button) {
      button.addEventListener("click", function () {
        setSpeed(Number(button.getAttribute("data-speed")));
      });
    });

    window.addEventListener("resize", placePanel);
    refreshPanel();
  }

  function boot() {
    createPanel();
    applySpeed();
    setInterval(applySpeed, 500);
  }

  if (document.readyState === "loading") document.addEventListener("DOMContentLoaded", boot, { once: true });
  else boot();
}());
