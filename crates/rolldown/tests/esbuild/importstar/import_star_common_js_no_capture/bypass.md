# Reason
1. sub optimal
2. esbuild will reuse `ns` variable
# Diff
## /out.js
### esbuild
```js
// foo.js
var require_foo = __commonJS({
  "foo.js"(exports) {
    exports.foo = 123;
  }
});

// entry.js
var ns = __toESM(require_foo());
var foo2 = 234;
console.log(ns.foo, ns.foo, foo2);
```
### rolldown
```js

const { default: assert } = __toESM(require("node:assert"));

//#region foo.js
var require_foo = __commonJS({ "foo.js"(exports) {
	exports.foo = 123;
} });

//#endregion
//#region entry.js
var import_foo = __toESM(require_foo());
let foo = 234;
assert.equal(import_foo.foo, 123);
assert.equal(import_foo.foo, 123);
assert.equal(foo, 234);

//#endregion
```
### diff
```diff
===================================================================
--- esbuild	/out.js
+++ rolldown	entry.js
@@ -1,8 +1,9 @@
+var {default: assert} = __toESM(require("node:assert"));
 var require_foo = __commonJS({
     "foo.js"(exports) {
         exports.foo = 123;
     }
 });
-var ns = __toESM(require_foo());
-var foo2 = 234;
-console.log(ns.foo, ns.foo, foo2);
+var import_foo = __toESM(require_foo());
+var foo = 234;
+console.log(import_foo.foo, import_foo.foo, foo);

```