//! [then/promise](https://github.com/then/promise)

var asap = Qt.callLater;

function noop() {}

// States:
//
// 0 - pending
// 1 - fulfilled with _value
// 2 - rejected with _value
// 3 - adopted the state of another promise, _value
//
// once the state is no longer pending (0) it is immutable

// All `_` prefixed properties will be reduced to `_{random number}`
// at build time to obfuscate them and discourage their use.
// We don't use symbols or Object.defineProperty to fully hide them
// because the performance isn't good enough.


// to avoid using try/catch inside critical functions, we
// extract them to here.
var LAST_ERROR = null;
var IS_ERROR = {};
function getThen(obj) {
    try {
        return obj.then;
    } catch (ex) {
        LAST_ERROR = ex;
        return IS_ERROR;
    }
}

function tryCallOne(fn, a) {
    try {
        return fn(a);
    } catch (ex) {
        LAST_ERROR = ex;
        return IS_ERROR;
    }
}

function tryCallTwo(fn, a, b) {
    try {
        fn(a, b);
    } catch (ex) {
        LAST_ERROR = ex;
        return IS_ERROR;
    }
}

function Promise(fn) {
    if (typeof this !== 'object') {
        throw new TypeError('Promises must be constructed via new');
    }
    if (typeof fn !== 'function') {
        throw new TypeError('Promise constructor\'s argument is not a function');
    }
    this._deferredState = 0;
    this._state = 0;
    this._value = null;
    this._deferreds = null;
    if (fn === noop) return;
    doResolve(fn, this);
}

Promise._onHandle = null;
Promise._onReject = null;
Promise._noop = noop;

Promise.prototype.then = function(onFulfilled, onRejected) {
    if (this.constructor !== Promise) {
        return safeThen(this, onFulfilled, onRejected);
    }
    var res = new Promise(noop);
    handle(this, new Handler(onFulfilled, onRejected, res));
    return res;
};

function safeThen(self, onFulfilled, onRejected) {
    return new self.constructor(function (resolve, reject) {
        var res = new Promise(noop);
        res.then(resolve, reject);
        handle(self, new Handler(onFulfilled, onRejected, res));
    });
}

function handle(self, deferred) {
    while (self._state === 3) {
        self = self._value;
    }
    if (Promise._onHandle) {
        Promise._onHandle(self);
    }
    if (self._state === 0) {
        if (self._deferredState === 0) {
            self._deferredState = 1;
            self._deferreds = deferred;
            return;
        }
        if (self._deferredState === 1) {
            self._deferredState = 2;
            self._deferreds = [self._deferreds, deferred];
            return;
        }
        self._deferreds.push(deferred);
        return;
    }
    handleResolved(self, deferred);
}

function handleResolved(self, deferred) {
    asap(function() {
        var cb = self._state === 1 ? deferred.onFulfilled : deferred.onRejected;
        if (cb === null) {
            if (self._state === 1) {
                resolve(deferred.promise, self._value);
            } else {
                reject(deferred.promise, self._value);
            }
            return;
        }
        var ret = tryCallOne(cb, self._value);
        if (ret === IS_ERROR) {
            reject(deferred.promise, LAST_ERROR);
        } else {
            resolve(deferred.promise, ret);
        }
    });
}

function resolve(self, newValue) {
    // Promise Resolution Procedure: https://github.com/promises-aplus/promises-spec#the-promise-resolution-procedure
    if (newValue === self) {
        return reject(
                    self,
                    new TypeError('A promise cannot be resolved with itself.')
                    );
    }
    if (
            newValue &&
            (typeof newValue === 'object' || typeof newValue === 'function')
            ) {
        var then = getThen(newValue);
        if (then === IS_ERROR) {
            return reject(self, LAST_ERROR);
        }
        if (
                then === self.then &&
                newValue instanceof Promise
                ) {
            self._state = 3;
            self._value = newValue;
            finale(self);
            return;
        } else if (typeof then === 'function') {
            doResolve(then.bind(newValue), self);
            return;
        }
    }
    self._state = 1;
    self._value = newValue;
    finale(self);
}

function reject(self, newValue) {
    self._state = 2;
    self._value = newValue;
    if (Promise._onReject) {
        Promise._onReject(self, newValue);
    }
    finale(self);
}

function finale(self) {
    if (self._deferredState === 1) {
        handle(self, self._deferreds);
        self._deferreds = null;
    }
    if (self._deferredState === 2) {
        for (var i = 0; i < self._deferreds.length; i++) {
            handle(self, self._deferreds[i]);
        }
        self._deferreds = null;
    }
}

function Handler(onFulfilled, onRejected, promise){
    this.onFulfilled = typeof onFulfilled === 'function' ? onFulfilled : null;
    this.onRejected = typeof onRejected === 'function' ? onRejected : null;
    this.promise = promise;
}

/**
 * Take a potentially misbehaving resolver function and make sure
 * onFulfilled and onRejected are only called once.
 *
 * Makes no guarantees about asynchrony.
 */
function doResolve(fn, promise) {
    var done = false;
    var res = tryCallTwo(fn, function (value) {
        if (done) return;
        done = true;
        resolve(promise, value);
    }, function (reason) {
        if (done) return;
        done = true;
        reject(promise, reason);
    });
    if (!done && res === IS_ERROR) {
        done = true;
        reject(promise, LAST_ERROR);
    }
}

(function(){
    Promise.prototype.done = function (onFulfilled, onRejected) {
        var self = arguments.length ? this.then.apply(this, arguments) : this;
        self.then(null, function (err) {
            setTimeout(function () {
                throw err;
            }, 0);
        });
    };
})();

(function(){
    Promise.prototype['finally'] = function (f) {
        return this.then(function (value) {
            return Promise.resolve(f()).then(function () {
                return value;
            });
        }, function (err) {
            return Promise.resolve(f()).then(function () {
                throw err;
            });
        });
    };
})();

(function(){
    /* Static Functions */
    function valuePromise(value) {
        var p = new Promise(Promise._noop);
        p._state = 1;
        p._value = value;
        return p;
    }

    var TRUE = valuePromise(true);
    var FALSE = valuePromise(false);
    var NULL = valuePromise(null);
    var UNDEFINED = valuePromise(undefined);
    var ZERO = valuePromise(0);
    var EMPTYSTRING = valuePromise('');

    Promise.resolve = function (value) {
        if (value instanceof Promise) return value;

        if (value === null) return NULL;
        if (value === undefined) return UNDEFINED;
        if (value === true) return TRUE;
        if (value === false) return FALSE;
        if (value === 0) return ZERO;
        if (value === '') return EMPTYSTRING;

        if (typeof value === 'object' || typeof value === 'function') {
            try {
                var then = value.then;
                if (typeof then === 'function') {
                    return new Promise(then.bind(value));
                }
            } catch (ex) {
                return new Promise(function (resolve, reject) {
                    reject(ex);
                });
            }
        }
        return valuePromise(value);
    };

    Promise.all = function (arr) {
        var args = Array.prototype.slice.call(arr);

        return new Promise(function (resolve, reject) {
            if (args.length === 0) return resolve([]);
            var remaining = args.length;
            function res(i, val) {
                if (val && (typeof val === 'object' || typeof val === 'function')) {
                    if (val instanceof Promise && val.then === Promise.prototype.then) {
                        while (val._state === 3) {
                            val = val._value;
                        }
                        if (val._state === 1) return res(i, val._value);
                        if (val._state === 2) reject(val._value);
                        val.then(function (val) {
                            res(i, val);
                        }, reject);
                        return;
                    } else {
                        var then = val.then;
                        if (typeof then === 'function') {
                            var p = new Promise(then.bind(val));
                            p.then(function (val) {
                                res(i, val);
                            }, reject);
                            return;
                        }
                    }
                }
                args[i] = val;
                if (--remaining === 0) {
                    resolve(args);
                }
            }
            for (var i = 0; i < args.length; i++) {
                res(i, args[i]);
            }
        });
    };

    Promise.reject = function (value) {
        return new Promise(function (resolve, reject) {
            reject(value);
        });
    };

    Promise.race = function (values) {
        return new Promise(function (resolve, reject) {
            values.forEach(function(value){
                Promise.resolve(value).then(resolve, reject);
            });
        });
    };

    /* Prototype Methods */

    Promise.prototype['catch'] = function (onRejected) {
        return this.then(null, onRejected);
    };
})();


(function(){
    // This file contains then/promise specific extensions that are only useful
    // for node.js interop


    /* Static Functions */

    Promise.denodeify = function (fn, argumentCount) {
      if (
        typeof argumentCount === 'number' && argumentCount !== Infinity
      ) {
        return denodeifyWithCount(fn, argumentCount);
      } else {
        return denodeifyWithoutCount(fn);
      }
    };

    var callbackFn = (
      'function (err, res) {' +
      'if (err) { rj(err); } else { rs(res); }' +
      '}'
    );
    function denodeifyWithCount(fn, argumentCount) {
      var args = [];
      for (var i = 0; i < argumentCount; i++) {
        args.push('a' + i);
      }
      var body = [
        'return function (' + args.join(',') + ') {',
        'var self = this;',
        'return new Promise(function (rs, rj) {',
        'var res = fn.call(',
        ['self'].concat(args).concat([callbackFn]).join(','),
        ');',
        'if (res &&',
        '(typeof res === "object" || typeof res === "function") &&',
        'typeof res.then === "function"',
        ') {rs(res);}',
        '});',
        '};'
      ].join('');
      return Function(['Promise', 'fn'], body)(Promise, fn);
    }
    function denodeifyWithoutCount(fn) {
      var fnLength = Math.max(fn.length - 1, 3);
      var args = [];
      for (var i = 0; i < fnLength; i++) {
        args.push('a' + i);
      }
      var body = [
        'return function (' + args.join(',') + ') {',
        'var self = this;',
        'var args;',
        'var argLength = arguments.length;',
        'if (arguments.length > ' + fnLength + ') {',
        'args = new Array(arguments.length + 1);',
        'for (var i = 0; i < arguments.length; i++) {',
        'args[i] = arguments[i];',
        '}',
        '}',
        'return new Promise(function (rs, rj) {',
        'var cb = ' + callbackFn + ';',
        'var res;',
        'switch (argLength) {',
        args.concat(['extra']).map(function (_, index) {
          return (
            'case ' + (index) + ':' +
            'res = fn.call(' + ['self'].concat(args.slice(0, index)).concat('cb').join(',') + ');' +
            'break;'
          );
        }).join(''),
        'default:',
        'args[argLength] = cb;',
        'res = fn.apply(self, args);',
        '}',

        'if (res &&',
        '(typeof res === "object" || typeof res === "function") &&',
        'typeof res.then === "function"',
        ') {rs(res);}',
        '});',
        '};'
      ].join('');

      return Function(
        ['Promise', 'fn'],
        body
      )(Promise, fn);
    }

    Promise.nodeify = function (fn) {
      return function () {
        var args = Array.prototype.slice.call(arguments);
        var callback =
          typeof args[args.length - 1] === 'function' ? args.pop() : null;
        var ctx = this;
        try {
          return fn.apply(this, arguments).nodeify(callback, ctx);
        } catch (ex) {
          if (callback === null || typeof callback == 'undefined') {
            return new Promise(function (resolve, reject) {
              reject(ex);
            });
          } else {
            asap(function () {
              callback.call(ctx, ex);
            })
          }
        }
      }
    };

    Promise.prototype.nodeify = function (callback, ctx) {
      if (typeof callback != 'function') return this;

      this.then(function (value) {
        asap(function () {
          callback.call(ctx, null, value);
        });
      }, function (err) {
        asap(function () {
          callback.call(ctx, err);
        });
      });
    };
})();

(function(){
    Promise.enableSynchronous = function () {
      Promise.prototype.isPending = function() {
        return this.getState() == 0;
      };

      Promise.prototype.isFulfilled = function() {
        return this.getState() == 1;
      };

      Promise.prototype.isRejected = function() {
        return this.getState() == 2;
      };

      Promise.prototype.getValue = function () {
        if (this._state === 3) {
          return this._value.getValue();
        }

        if (!this.isFulfilled()) {
          throw new Error('Cannot get a value of an unfulfilled promise.');
        }

        return this._value;
      };

      Promise.prototype.getReason = function () {
        if (this._state === 3) {
          return this._value.getReason();
        }

        if (!this.isRejected()) {
          throw new Error('Cannot get a rejection reason of a non-rejected promise.');
        }

        return this._value;
      };

      Promise.prototype.getState = function () {
        if (this._state === 3) {
          return this._value.getState();
        }
        if (this._state === -1 || this._state === -2) {
          return 0;
        }

        return this._state;
      };
    };

    Promise.disableSynchronous = function() {
      Promise.prototype.isPending = undefined;
      Promise.prototype.isFulfilled = undefined;
      Promise.prototype.isRejected = undefined;
      Promise.prototype.getValue = undefined;
      Promise.prototype.getReason = undefined;
      Promise.prototype.getState = undefined;
    };
})();
