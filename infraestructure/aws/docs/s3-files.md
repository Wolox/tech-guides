# Storing files in S3

## Privacy
Unless specified, all files *must* be private when stored in S3. As a consequence, no one should be able to upload and/or download a file.

## Interacting with the bucket
If the user wants to upload a file that is not currently in our backend, it *must* always be done on *client-side*. This reduces server 
load.
Since our bucket does not allow any user to upload objects the following steps need to be done:

1. Ask the server for a pre-signed url. The server will use it's AWS credentials to build a pre-signed url that will have permissions to
perform the desired action on the bucket. The following code generates a URL that allows the holder to read the specified image from the
bucket for 300 seconds:
```
s3_image_obj = Aws::S3::Resource.new(region: AWS_BUCKET_REGION).bucket(IMAGE_UPLOAD_BUCKET).object('my_image.png')
s3_image_obj.presigned_url(:put, acl: 'put', expires_in: 300)
```
The resulting URL looks like this:

`https://s3.amazonaws.com/my-aws-bucket/some/path/photo.jpg?AWSAccessKeyId=SOME_ACCESSK_KEY&Expires=1501189098&Signature=SOME_SIGNATURE`

For more information on how to generate this URL please refer to the AWS SDK that corresponds to your programming language.

2. The client uses the url to perform the action.

## Flows
### GET
![S3 Get Flow](./s3-get-flow.png)
### PUT
![S3 Put Flow](./s3-put-flow.png)
