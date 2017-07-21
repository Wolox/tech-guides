const gulp = require('gulp');
const merge = require('merge-stream');
const awspublish = require('gulp-awspublish');
const AWS = require('aws-sdk');

const deploy = publisher => {
  const zippedFiles = [
    './build/**/*.svg',
    './build/**/*.html',
    './build/**/*.css',
    './build/**/*.js',
    './build/**/*.map',
    './build/**/*.jpg'
  ];
  const unzippedFiles = ['./build/**/*'].concat(zippedFiles.map(file => `!${file}`));
  const headers = {
    'Content-Encoding': 'gzip'
  };

  const zipped = gulp.src(zippedFiles).pipe(awspublish.gzip({ ext: '' })).pipe(publisher.publish(headers));
  const unzipped = gulp.src(unzippedFiles).pipe(publisher.publish());
  return merge(zipped, unzipped).pipe(publisher.sync()).pipe(awspublish.reporter());
};

gulp.task('publish-stg', () => {
  const publisher = awspublish.create({
    params: {
      Bucket: process.env.S3_STG_BUCKET_NAME
    },
    credentials: new AWS.SharedIniFileCredentials({ profile: 'STAGING-DEPLOY-PROFILE' })
  });
  return deploy(publisher);
});

gulp.task('publish-prod', () => {
  const publisher = awspublish.create({
    params: {
      Bucket: process.env.S3_PROD_BUCKET_NAME
    },
    credentials: new AWS.SharedIniFileCredentials({ profile: 'PRODUCTION-DEPLOY-PROFILE' })
  });
  return deploy(publisher);
});
