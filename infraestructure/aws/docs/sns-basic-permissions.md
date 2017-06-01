# SNS Basic Permissions

The following permissions gives basic authorization for using SNS Push Notifications.
This permissions does not allow to create, modify or destroy platform applications.

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
