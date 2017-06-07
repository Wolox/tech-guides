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

### What you shall test and how do you report it

In the following [Document](https://docs.google.com/document/d/1izTKBOYPYUuc8zmxmvB4EQFbhMDgaDvYjViDL_yDvOg/edit?ts=59382e24#) it's explained how and what things you shall test. Also it tells you how to report your results and gives you the templates where to put them.

### Script Usage

After installing just execute `./path/to/k6 run --vus 5 -d 2s  script.js` if you are working in a Linux environment and you have extracted the tool from the .tar.gz or simply run `k6 run --vus 5 -d 2s  script.js` if you have are using Mac.

The options are:

- --vus: indicates how many virtual users you want to create
- -d: test duration, 0 to run until cancelled (You need to specify the unit: 's', 'm' or 'h')

You have different script examples in

- [GET REQUEST](get.js)
- [POST REQUEST](post.js)
- [PUT REQUEST](put.js)

## Results

[Visit](https://docs.k6.io/docs/results-output) the official results doc for a full explanation of the results output.

You can also export the results to a JSON running the script with the option `--out json=`:

- E.g. `k6 run --out json=json_result.json script.js`

It's a good idea that you documentate the results you get, to know what are the limits of your API.
