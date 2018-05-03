## Elastic Beanstalk Policies

### Deploy Only

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "elasticloadbalancing:RegisterInstancesWithLoadBalancer"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Action": [
                "elasticbeanstalk:CreateApplicationVersion",
                "elasticbeanstalk:DescribeEnvironments",
                "elasticbeanstalk:DeleteApplicationVersion",
                "elasticbeanstalk:UpdateEnvironment",
                "elasticbeanstalk:CreateStorageLocation",
                "elasticbeanstalk:DescribeEvents"
            ],
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Action": [
                "sns:CreateTopic",
                "sns:GetTopicAttributes",
                "sns:ListSubscriptionsByTopic",
                "sns:Subscribe"
            ],
            "Effect": "Allow",
            "Resource": "arn:aws:sns:*:your-account-id:*"
        },
        {
            "Action": [
                "autoscaling:SuspendProcesses",
                "autoscaling:DescribeScalingActivities",
                "autoscaling:ResumeProcesses",
                "autoscaling:DescribeAutoScalingGroups",
                "autoscaling:DescribeLaunchConfigurations",
                "autoscaling:PutNotificationConfiguration"
            ],
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Action": [
                "cloudformation:GetTemplate",
                "cloudformation:DescribeStackResources",
                "cloudformation:DescribeStackResource",
                "cloudformation:DescribeStackEvents",
                "cloudformation:DescribeStacks",
                "cloudformation:UpdateStack",
                "cloudformation:CancelUpdateStack"
            ],
            "Effect": "Allow",
            "Resource": "arn:aws:cloudformation:*:YOUR-ACCOUNT-ID:*"
        },
        {
            "Action": [
                "ec2:DescribeImages",
                "ec2:DescribeKeyPairs",
                "ec2:DescribeSecurityGroups",
                "ec2:DescribeVpcs",
                "ec2:DescribeAddresses",
                "ec2:DescribeInstances",
                "ec2:RevokeSecurityGroupIngress",
                "ec2:AuthorizeSecurityGroupIngress"
            ],
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Action": [
                "s3:PutObject",
                "s3:PutObjectAcl",
                "s3:GetObject",
                "s3:GetObjectAcl",
                "s3:ListBucket",
                "s3:DeleteObject",
                "s3:GetBucketPolicy",
                "s3:CreateBucket"
            ],
            "Effect": "Allow",
            "Resource": [
                "arn:aws:s3:::elasticbeanstalk*",
                "arn:aws:s3:::elasticbeanstalk-*-YOUR-ACCOUNT-ID",
                "arn:aws:s3:::elasticbeanstalk-*-YOUR-ACCOUNT-ID/*"
            ]
        }
    ]
}
```
