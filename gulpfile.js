const { src, dest, series } = require('gulp');
const uglify = require('gulp-uglify');
const rename = require('gulp-rename');
const gulpsass = require('gulp-sass')(require('sass'));
const autoprefixer = require('gulp-autoprefixer');
const sourcemaps = require('gulp-sourcemaps');
const pipeline = require('readable-stream').pipeline;
const markdown = require('gulp-markdown');
const footer = require('gulp-footer');
const fs = require('fs');

const sassSrc = 'docs/assets/sass/*.scss';
const sassDest = 'docs/assets/css/';
const jsSrc = 'index.js';
const jsDest = 'demo/DemoMbPseudofrm/assets/js';

function sass() {
  return src(sassSrc)
    .pipe(autoprefixer())
    .pipe(gulpsass().on('error', (err) => console.log(err)))
    .pipe(dest(sassDest));
}

function documentation() {
  return src('README.md')
    .pipe(markdown())
    .pipe(rename('documentation.xml'))
    .pipe(dest('docs'))
}

function documentationIt() {
  return src('LEGGIMI.md')
    .pipe(markdown())
    .pipe(rename('documentation-it.xml'))
    .pipe(dest('docs'))
}

function sasscompress() {
  return src(sassSrc)
    .pipe(autoprefixer())
    .pipe(sourcemaps.init())
    .pipe(gulpsass({ outputStyle: 'compressed' }))
    .pipe(rename({ extname: '.min.css' }))
    .pipe(sourcemaps.write('.'))
    .pipe(dest(sassDest));
}

function compressjs() {
  return pipeline(
    src(jsSrc),
    uglify(),
    rename('MB_PseudoForm.min.js'),
    dest(jsDest),
    src(jsSrc),
    rename('MB_PseudoForm.js'),
    dest(jsDest)
  );
}

// function createAutoInstall() {
//   const cssContent = fs.readFileSync(cssFile);
//   return pipeline(
//     src(jsSrc),
//     footer(`;(function (win, doc) {
//                 win.Swal = win.swal = win.Sweetalert = win.sweetalert = new Swalstrap();
//                   const style = doc.createElement('style');
//                   style.innerText = \`${cssContent}\`;
//                   doc.head.appendChild(style);
//             })(window, document)`),
//     uglify(),
//     rename('swalstrap_all.min.js'),
//     dest(jsDest),
//     src(jsSrc),
//     footer(`
//     ;(function (win, doc) {
//         win.Swal = win.swal = win.Sweetalert = win.sweetalert = new Swalstrap();
//           const style = doc.createElement('style');
//           style.innerText = \`${cssContent}\`;
//           doc.head.appendChild(style);
//     })(window, document)`),
//     rename('swalstrap_all.js'),
//     dest(jsDest)
//   );
// }

function creadist() {
  return pipeline(
    src('demo/DemoMbPseudofrm/assets/js/**'),
    dest('dist/')
  )
}

exports.default = series(/* sass, sasscompress, */ compressjs, creadist, documentation, documentationIt);
//exports.sass = sass;
exports.compressjs = compressjs;
//exports.sasscompress = sasscompress;
exports.creadist = creadist;
exports.documentation = documentation;
exports.documentationIt = documentationIt;