# K6

K6 is a load testing tool that uses JavaScript and Go to fake multiple simultaneous requests to an API or Web Server.
It gives instant information of the requests results and allows you to easily test the performance limits of your API.

## Installing

### Mac

```
brew tap loadimpact/k6
brew install k6
```

### Docker

```
docker pull loadimpact/k6
```

### Linux

[Download](https://github.com/loadimpact/k6/releases) and extract the latest version.

## Usage

### Script Usage

After installing just execute `./path/to/k6 run --vus 5 -d 2s  script.js` if you are working in a Linux environment and you have extracted the tool from the .tar.gz or simply run `k6 run --vus 5 -d 2s  script.js` if you have are using Mac.

The options are:

- --vus: indicates how many virtual users you want to create
- -d: test duration, 0 to run until cancelled (You need to specify the unit: 's', 'm' or 'h')

You have different script examples in

- [GET REQUEST](get.js)
- [POST REQUEST](post.js)
- [PUT REQUEST](put.js)

### Before Testing

Create a copy of this [document](https://docs.google.com/spreadsheets/d/1EUS4Livu-0rXkJnDx6oZjnl3mDA9PXlCfUSb_dlvPlU/edit?usp=sharing), where you shall put your testing results. This document shall remain with all the other project documentation.

- **Documentate the environment characteristics.** This includes the amount of CPUs of the instance, the amount of RAM and the size of the database.
- **Identify the endpoints to test.** Usually the endpoints that have trouble handling a huge amount of request, are the ones that are involved in one or more of the following cases:
  - They depend on an external service
  - They execute a complex algorithm
  - It has some important or critic business logic
  - It makes complex database queries
  - The database to be queried has a huge size

### Testing

Start using a low amount of virtual users, e.g. 30. This amount of virtual users is the amount of parallel processes that will be executed. Each virtual user will be sending a request to the server repeatedly during the duration of the test, but it does not mean that with 30 virtual users you will get 30 requests per second, because each requests has a different connection time, waiting time, sending time, receiving time, etc., which results in a different duration for each request.

Each test should last for at least 60 seconds and you should increase the amount of virtual users until you find the point where something starts to fail. You should wait some time between each test to allow the instance to cool down.

Some cutoff criteria can be:
- The server responds with 500
- The average time of the request is not acceptable
- The maximum time of the request is not acceptable

### After Testing

You should look in CloudWatch which metrics have been fired or what failed in which point, to know what are the thresholds where you should set an escalating point.

Como CloudWatch metrics to take in count are:
- CPU usage
- Average response time
- Bytes out

Finally you should fill the results document and send it to the Project Architect to be evaluated.

## Results

[Visit](https://docs.k6.io/docs/results-output) the official results doc for a full explanation of the results output.

You can also export the results to a JSON running the script with the option `--out json=`:

- E.g. `k6 run --out json=json_result.json script.js`

It's a good idea that you documentate the results you get, to know what are the limits of your API.

## Advanced

The examples seen so far are well suited for testing API endpoints. If you want to test a monolithic application you have to make the same requests a browser would do, those include requests to assets (js, css, images) and maybe some async requests done by the frontend (JQuery, React, Angular, Vue, etc).

- [BATCH REQUEST](batch.js)

Even more, if you are testing a Rails application which submits a form, you would have to take the CSRF token inserted by Rails in the HTML before you can make the request.

Let's say we have an app that makes a request to an API endpoint, which executes an async job an returns the ID of that job so you can check the status later. Here is a full example of that:

- [RAILS ADVANCED](rails.js)
