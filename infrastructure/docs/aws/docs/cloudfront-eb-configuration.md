# Configuring CloudFront for Elastic Beanstalk instances

This guide provides a basic configuration for CloudFront when using it along Elastic Beanstalk instances including common mistakes that cause the distribution's malfunction.

## Steps
1. Inside the `CloudFront` service in the AWS console, select `Create Distribution` then choose `Web Distribution`.
2. As `Origin Domain Name` choose the EB instance's load balancer.
3. If using HTTPS choose `Redirect HTTP to HTTPS` as `Viewer Protocol Policy` so as to enforce it's use.
4. In `Allowed HTTP Methods` select `GET, HEAD, OPTIONS, PUT, POST, PATCH, DELETE`. This will help avoiding many problems, among others, with CORS since OPTIONS method will be forwarded to the EB instance.
5. Choose to forward All cookies.
6. The most important step is choosing `Forward All, cache based on all` in the `Query String Forwarding and Caching` option. When using an EB load balancer as origin, leaving this option on its `None` option will cause the distribution to redirect requests instead of caching them.
7. In `Alternate Domain Names (CNAMEs)` add all the domains that will be used to access this distribution by CNAME type DNS separated by commas or in different lines.
8. In case of using HTTPS, select the custom certificate from the list.
9. Except for special cases leave the rest of the options on default.
