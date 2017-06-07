# Deploying in AWS S3 Bucket

## Create the policy

The policy will grant the permissions to the bucket.

1. Access the IAM Service Dashboard
2. Click on "Policies" on the left side panel
3. Click on "Create Policy"
4. Click on "Select" button in the "Create Your Own Policy" option
5. Policy Name: "frontend-deployment"
6. Description: Policy for Frontend Deployment in an S3 Bucket
7. Policy Document:

```
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetBucketLocation",
        "s3:ListAllMyBuckets"
      ],
      "Resource": "arn:aws:s3:::*"
    },
    {
      "Effect": "Allow",
      "Action": ["s3:ListBucket"],
      "Resource": ["arn:aws:s3:::bucket-name"]
    },
    {
      "Sid": "Stmt1492797402000",
      "Effect": "Allow",
      "Action": [
          "s3:DeleteObject",
          "s3:DeleteObjectVersion",
          "s3:GetBucketAcl",
          "s3:GetBucketCORS",
          "s3:GetBucketLocation",
          "s3:GetBucketWebsite",
          "s3:GetObject",
          "s3:GetObjectAcl",
          "s3:GetObjectTagging",
          "s3:GetObjectTorrent",
          "s3:GetObjectVersion",
          "s3:GetObjectVersionAcl",
          "s3:GetObjectVersionTagging",
          "s3:GetObjectVersionTorrent",
          "s3:ListBucket",
          "s3:PutObject",
          "s3:PutObjectAcl",
          "s3:PutObjectTagging",
          "s3:PutObjectVersionAcl",
          "s3:PutObjectVersionTagging",
          "s3:ReplicateObject",
          "s3:RestoreObject"
      ],
      "Resource": [
          "arn:aws:s3:::bucket-name/*"
      ]
  }
  ]
}
```

8. Click on "Create Policy"

## Create the Group

This group will grant all the users that belongs to it, all the permissions from the policy attached.

1. Click on Groups on the left side panel
2. Click on Create New Group
3. Group Name: FrontendDeployment
4. Filter the policies by the name frontend-deployment
5. Select the checkbox from the policy frontend-deployment and click Next Step
6. Click on Create Group

## Add Users to the Group

Finally you can add users to this group, to give to all of them, the permissions to deploy to the S3 bucket and interact with it through the AWS console.

1. Click on "Groups" on the left panel
2. Select the "FrontendDeployment" group
3. Click on "Add Users to Group" and select the desired users to be incorporated
4. Finally click on "Add Users"
