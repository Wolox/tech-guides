# Adding SSL Certificate to AWS

- Make sure you have the [PEM formatted files](#What-is-included-in-the-PEM-files)

- Go to AWS Dashboard ---> Certificate Manager
   1. Select the correct region on the top right
   2. _Optional:_ If no certificates are showing, click get started
   3. Click **Import a Certificate**
   4. Copy the content of each file into the appropriate text field
   5. On the tags section on the bottom, add a name


- Go to AWS Dashboard ---> Elastic Beanstalk
   1. Select the correct region on the top right
   2. For each environment do the following:
      1. Go to Configuration (on the right, same place that we use for secrets)
      2. Scroll down to Network Tier ---> Load Balancing ---> Configuration Cog Wheel
      3. Select the new certificate on the SSL Certificate ID selector (hit refresh in case it hasn’t updated yet), and click Apply at the bottom


- Go to AWS Dashboard ---> Cloudfront
   - For each Distribution do the following:
     1. On the General tab, click edit (top right, under the tab)
     2. On the SSL Certificate, **Custom SSL Certificate** should be selected
     3. Select the new certificate from the drop down menu (click refresh if it hasn’t updated yet), and click **Yes, Edit** at the bottom


### Additional Reading
[What Is AWS Certificate Manager?](https://docs.aws.amazon.com/acm/latest/userguide/acm-overview.html)

[SSL/TLS Certificates for Classic Load Balancers](http://docs.aws.amazon.com/elasticloadbalancing/latest/classic/ssl-server-cert.html)
________________
### What is included in the PEM files
The PEM (Privacy-enhanced Electronic Mail) formatted files include:

#### Certificate body
  This is the actual certificate, in case you’re renewing an already existing certificate, this is the only one that will be changing, starts with **-----BEGIN CERTIFICATE-----**  and has only one block (of begin and end)
#### The Private Key
 starts with **-----BEGIN PRIVATE KEY-----** and has only one block
#### The Certificate chain
  starts with **-----BEGIN CERTIFICATE-----** this is optional, you might not have them and may have more than one block (copy all of them)
