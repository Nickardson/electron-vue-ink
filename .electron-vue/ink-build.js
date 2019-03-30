var exec = require('child_process').exec;
var path = require('path');
var fs = require('fs');

// directory containing the ink files.
var dirpath = 'static/ink';

fs.readdir(dirpath, function(err, files) {
  var inkFiles = files.filter(el => /\.ink$/.test(el));

  inkFiles.forEach((file) => {
    console.log('Building ' + file);
    exec(
      // TODO: allow for non-windows/linux building
      "\".electron-vue/inklecate/inklecate.exe\" \"" + path.join(dirpath, file) + "\"",
      (err, stdout, stderr) => {
        if (err) {
          console.error(err);
        }
        if (stderr) {
          console.error(stderr);
        }
        console.log(stdout)
      });
  });
});
