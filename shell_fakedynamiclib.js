{
  var newModule = function(fb, parentModule) {
    var Module = {};
    var args = [];
    Module.arguments = [];
    Module.print = parentModule.print;
    Module.printErr = parentModule.printErr;

    Module.cleanups = [];

    var gb = 0;
     // Each module has its own stack
    var STACKTOP = getMemory(TOTAL_STACK);
    assert(STACKTOP % 8 == 0);
    var STACK_MAX = STACKTOP + TOTAL_STACK;
      Module.cleanups.push(function() {
        parentModule['_free'](STACKTOP); // XXX ensure exported
        parentModule['_free'](gb);
    });

    {{BODY}}

    // {{MODULE_ADDITIONS}}

    return Module;
  };

  var lib_module = newModule(Runtime.alignFunctionTables(), Module);
  var handle = 1;
  var filename = "{{{ WEBSOCKET_URL }}}"; // WEBSOCKET_URL unused in side modules, so use it to pass module name

  for (var key in Module.DLFCN.loadedLibs) {
    if (Module.DLFCN.loadedLibs.hasOwnProperty(key)) handle++;
  }

  Module.DLFCN.loadedLibs[handle] = {
    refcount: 999, //dlclose will crash, so prevent it
    name: filename,
    module: lib_module,
    cached_functions: {}
  };

  Module.DLFCN.loadedLibNames[filename] = handle;
  Module.print('Module ' + filename +' loaded as '+ handle);
};