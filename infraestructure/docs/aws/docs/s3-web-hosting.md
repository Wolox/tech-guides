# S3 Frontend Web Hosting

## Create the bucket

- Go the *Services -> S3* in the top left corner
- Just click in *Create bucket*, enter the name you want and click *Create* in the bottom left corner

> If you don't have permissions to access S3, ask for them to your TM, Architect or SM

## Give public permissions to access the bucket

- Enter in the bucket by clicking in the name
- Go to the *Permissions* tab
- Select *Bucket Policy*
- Copy this Policy, replacing the **BUCKET_NAME**

```
{
    "Version": "2008-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": {
                "AWS": "*"
            },
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::BUCKET_NAME/*"
        }
    ]
}
```

## Set Web Hosting

- Click in *Properties*
- Click in *Static website hosting*
- Check the option *Use this bucket to host a website*
- Write `index.html` in *Index document* and *Error document*
- You can now access the web page by clicking in the URL that appears at the top in *Endpoint*
