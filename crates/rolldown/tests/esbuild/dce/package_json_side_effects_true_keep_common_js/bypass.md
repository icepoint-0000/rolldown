# Reason
1. different file system
# Diff
## /out.js
### esbuild
```js
// Users/user/project/node_modules/demo-pkg/index.js
var require_demo_pkg = __commonJS({
  "Users/user/project/node_modules/demo-pkg/index.js"(exports) {
    exports.foo = 123;
    console.log("hello");
  }
});

// Users/user/project/src/entry.js
var import_demo_pkg = __toESM(require_demo_pkg());
console.log("unused import");
```
### rolldown
```js


//#region node_modules/demo-pkg/index.js
var require_demo_pkg_index = __commonJS({ "node_modules/demo-pkg/index.js"(exports) {
	exports.foo = 123;
	console.log("hello");
} });

//#endregion
//#region src/entry.js
var import_demo_pkg_index = __toESM(require_demo_pkg_index());
console.log("unused import");

//#endregion
```
### diff
```diff
===================================================================
--- esbuild	/out.js
+++ rolldown	src_entry.js
@@ -1,8 +1,8 @@
-var require_demo_pkg = __commonJS({
-    "Users/user/project/node_modules/demo-pkg/index.js"(exports) {
+var require_demo_pkg_index = __commonJS({
+    "node_modules/demo-pkg/index.js"(exports) {
         exports.foo = 123;
         console.log("hello");
     }
 });
-var import_demo_pkg = __toESM(require_demo_pkg());
+var import_demo_pkg_index = __toESM(require_demo_pkg_index());
 console.log("unused import");

```