# Deploy Create React App project to S3

## Dependencies
To install them just run
```
npm install --save gulp gulp-awspublish aws-sdk merge-stream
```
## Configuration
* Copy the [deploy script](./scripts/deploy-s3.js) inside the project's directory. The recommended route is `./gulp/tasks/deploy-s3.js`

* Create `gulpfile.js` if the project wasn't using gulp alredy or else edit `gulpfile.js` and add:
```
require('./gulp/tasks/deploy-s3.js')
```
* Edit `deploy-s3.js` changing `S3_STG_BUCKET_NAME` and `S3_PROD_BUCKET_NAME` for the env variables containing both the staging and production s3 bucket names. Also change `STAGING-DEPLOY-PROFILE` and `PRODUCTION-DEPLOY-PROFILE` for the staging and production deploy aws profile names.

* You can edit the list of files to be zipped according to your project by changing the `zippedFiles` array.

> If you need to create the bucket follow this [instructions](../../../infrastructure/docs/aws/docs/s3-web-hosting.md)

## Use
After running `npm run build` run `gulp publish-stg` to deploy to the staging bucket or `gulp publish-prod` to deploy to the production one.
