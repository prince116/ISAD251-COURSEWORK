var gulp = require('gulp')
var pug = require('gulp-pug')
var sass = require('gulp-sass')
var browserSync = require('browser-sync').create()
var changed = require('gulp-changed')
var imagemin = require('gulp-imagemin')
var path = require('path')
var watch = require('gulp-watch')
var gulpSequence = require('gulp-sequence')
var del = require('del')
var autoprefixer = require('gulp-autoprefixer')
var uglify = require('gulp-uglify')
var concat = require('gulp-concat');
var pump = require('pump');

gulp.task('html', function() {
    return gulp.src('./src/views/**/*.pug')
        .pipe(pug({
            doctype: 'html',
            pretty: true
        }))
        .pipe(gulp.dest('./public/'))
});

gulp.task('sass', function() {
    return gulp.src('./src/sass/**/*.sass')
        .pipe(sass().on('error', sass.logError))
    	.pipe(autoprefixer({
            browsers: ['last 12 versions'],
            cascade: false
        }))
        .pipe(gulp.dest('./public/css'))
});

gulp.task('fonts', function() {
    return gulp.src(['./src/css/fonts/*', '*!README.md'])
    .pipe(changed('./public/css/fonts')) // Ignore unchanged files
    .pipe(gulp.dest('./public/css/fonts'))
    .pipe(browserSync.stream())
});

gulp.task('css', function() {
    return gulp.src('./src/css/**/*.css')
    .pipe(changed('./public/css')) // Ignore unchanged files
    .pipe(gulp.dest('./public/css'))
    .pipe(browserSync.stream())
});

gulp.task('js', function() { 
    return gulp.src('./src/js/**/*.js')
        .pipe(gulp.dest('./public/js'))
});
// gulp.task('js', function (cb) {
//     pump([
//             gulp.src(['./src/js/vendor/jquery.min.js', './src/js/vendor/bootstrap.min.js', './src/js/script.js']),
//             concat('script.js'),
//             // uglify(),
//             gulp.dest('./public')
//         ],
//         cb
//     );
// });

gulp.task('img', function() {
    return gulp.src(['./src/img/**/*', '*!README.md'])
        .pipe(changed('./public/img')) // Ignore unchanged files
        .pipe(imagemin()) // Optimize
        .pipe(gulp.dest('./public/img'))
});

gulp.task('clean', function (cb) {
  del([path.join('./public', '/**'), path.join('!', './public')]).then(function (paths) {
    cb()
  })
})

gulp.task('server-reload', function (callback) {
  return gulpSequence(['build'], ['bs-reload'], callback)
})

gulp.task('bs-reload', function () {
  return browserSync.reload()
});

gulp.task('build', function(done) {
	gulpSequence('clean', ['html', 'sass', 'css', 'js', 'img', 'fonts'], done)
});

gulp.task('production', function(done) {
    gulpSequence('clean', ['html', 'sass', 'css', 'js', 'img', 'fonts'], done)
});

gulp.task('watch', function () {
  return gulp.watch(['./src/**/*.*'], ['server-reload'])
});

// use default task to launch Browsersync and watch JS files
gulp.task('default', ['watch'], function () {

    // Serve files from the root of this project
    return browserSync.init({
        server: {
            baseDir: "./public"
        }
        // online: true,
        // tunnel: true,
    });

});