(function () {
  "use strict";

  function installTextHotfix() {
    if (!window.Laya || !Laya.Text || Laya.Text.prototype.__meowTextHotfix) return false;

    var proto = Laya.Text.prototype;
    proto.__meowTextHotfix = true;

    var originalContextFont = proto._getContextFont;
    proto._getContextFont = function () {
      var font = originalContextFont.call(this);
      return font
        .replace(/SimSun|宋体|Microsoft YaHei|微软雅黑|Arial|Times/gi, "msyh, Microsoft YaHei, Arial")
        .replace(/sans-serif/gi, "msyh, Microsoft YaHei, Arial, sans-serif");
    };

    var originalWordWrapWidth = proto._getWordWrapWidth;
    proto._getWordWrapWidth = function () {
      var width = originalWordWrapWidth.call(this);
      var text = String(this._text || "");
      if (!text) return width;

      var stroke = Number(this.stroke || 0);
      var fontSize = Number(this.fontSize || 20);
      var hasVietnamese = /[À-ỹ]/.test(text);
      var hasLatin = /[A-Za-z]/.test(text);
      var extra = Math.ceil(Math.max(10, fontSize * 0.42) + stroke * 2);

      if (this.overflow === Laya.Text.HIDDEN || hasVietnamese || hasLatin || stroke > 0) {
        return width + extra;
      }
      return width + 4;
    };

    var originalEvalTextSize = proto._evalTextSize;
    proto._evalTextSize = function () {
      originalEvalTextSize.call(this);
      var stroke = Number(this.stroke || 0);
      var fontSize = Number(this.fontSize || 20);
      var text = String(this._text || "");
      if (!text || this._textWidth <= 0) return;
      this._textWidth += Math.ceil(Math.max(4, fontSize * 0.12) + stroke * 2);
    };

    return true;
  }

  if (!installTextHotfix()) {
    var tries = 0;
    var timer = setInterval(function () {
      tries += 1;
      if (installTextHotfix() || tries > 60) clearInterval(timer);
    }, 50);
  }
}());
