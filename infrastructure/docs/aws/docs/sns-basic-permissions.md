# SNS Basic Permissions

### Sending Push Notifications

The following permissions gives basic authorization for setting up endpoints and sending Push Notifications using the Simple Notification Service (SNS).
This permissions does not allow to create, modify or destroy platform applications.

The Resource ARN can be obtained following this steps:

- Log in the AWS Console
- Click on Services and select Simple Notification Services in Messaging category
- Select Applications tab in the left panel
- You will have all of yours application and theirs ARN listed in a table

The **SNS-REGION** identifies the region where you created the resource and the **SNS-ARN** identifies the resource you are giving permission to.

`E.g. arn:aws:sns:us-east-1:052023722658:app/APNS/example-ios`

The Amazon Resource Names (ARNs) uniquely identify AWS resources. More [info](http://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html).


```
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "sns:CreatePlatformEndpoint",
        "sns:DeleteEndpoint",
        "sns:GetEndpointAttributes",
        "sns:GetPlatformApplicationAttributes",
        "sns:ListEndpointsByPlatformApplication",
        "sns:Publish",
        "sns:SetEndpointAttributes",
      ],
      "Resource": [
        "arn:aws:sns:SNS-REGION:SNS-ARN
      ]
    }
  ]
}
```
