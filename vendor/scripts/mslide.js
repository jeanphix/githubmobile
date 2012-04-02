(function() {
  var mSlide,
    __indexOf = Array.prototype.indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  mSlide = (function() {

    function mSlide(holder, options) {
      this.holder = typeof holder === 'object' ? holder : document.getElementById(holder);
      this.slider = this.holder.firstElementChild;
      this.segmentCount = 0;
      this.position = 1;
      this.duration = '0.4s';
      this._previousPosition = 1;
      this._initVendor();
      this._initEvents();
      this.refresh();
    }

    mSlide.prototype.refresh = function() {
      var segment, _i, _len, _ref;
      this.segmentCount = this.slider.children.length;
      this._width = this.holder.clientWidth;
      this.slider.style.width = "" + (this.segmentCount * this._width) + "px";
      this._segments = this.slider.children;
      _ref = this._segments;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        segment = _ref[_i];
        segment.style.width = "" + this._width + "px";
      }
      return this.slide(this.position, '0s');
    };

    mSlide.prototype.slide = function(segment, duration) {
      var transform, translation;
      if ((0 < segment && segment <= this.segmentCount)) {
        duration = duration ? duration : this.duration;
        translation = -(segment - 1) * this._width;
        transform = this._support3D ? 'translate3d' : 'translate';
        this.slider.style["" + this._vendor + "Transform"] = "" + transform + "(" + translation + "px, 0)";
        this.slider.style["" + this._vendor + "Transition"] = "all " + duration + " ease-in";
        return this.position = segment;
      }
    };

    mSlide.prototype.slidePrevious = function() {
      return this.slide(this.position - 1);
    };

    mSlide.prototype.slideNext = function() {
      return this.slide(this.position + 1);
    };

    mSlide.prototype._initEvents = function() {
      var _this = this;
      this.slider.addEventListener(this._endEvent, (function() {
        if (_this.position > _this._previousPosition) {
          if (_this.onNext) _this.onNext.apply(_this);
        } else if (_this.position < _this._previousPosition) {
          if (_this.onPrevious) _this.onPrevious.apply(_this);
        }
        return _this._previousPosition = _this.position;
      }));
      return window.addEventListener("resize", (function() {
        return _this.refresh();
      }));
    };

    mSlide.prototype._initVendor = function() {
      var prefix, vendor, vendors, _ref;
      this._support3D = false;
      vendors = {
        Webkit: 'webkit',
        Moz: null,
        O: 'o',
        ms: 'MS'
      };
      for (vendor in vendors) {
        prefix = vendors[vendor];
        if (this.holder.style["" + vendor + "TransitionProperty"] !== void 0) {
          this._vendor = vendor;
          this._endEvent = prefix ? "" + prefix + "TransitionEnd" : "transitionend";
          break;
        }
      }
      if (_ref = "" + this._vendor + "Perspective", __indexOf.call(this.holder.style, _ref) >= 0) {
        return this._support3D = true;
      }
    };

    return mSlide;

  })();

  window.mSlide = mSlide;

}).call(this);
