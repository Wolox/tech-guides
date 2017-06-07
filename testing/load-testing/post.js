import { check } from "k6";
import http from "k6/http";

// This headers and body will be used for the request you want to test
let headers;

let body = {
  // E.g.
  account: {
    some: "data",
  }
};

// This headers and body will be used only for logging in the first time
let logInHeaders = {
  // E.g.
  "Content-Type": "application/json",
  "Accept": "application/json",
  "Other": "header"
}

let loginBody = {
  // E.g.
  sessions: {
    username: "user",
    password: "verySecretPassword"
  }
};

export default function() {

  // This will be run only the first time, when the headers are not initialized
  if(headers === undefined) {
    headers = {
      // E.g.
      "Content-Type": "application/json",
      "Accept": "application/json",
      // It creates the sessions and gets the access token
      "Authorization": JSON.parse(http.post("LOGIN_URL", JSON.stringify(loginBody), { headers: logInHeaders }).body)['token_name']
    }
  }

  check(http.post("URL", JSON.stringify(body), { headers: headers }),
        // Structure => "output title": (res) => res.data == condition
        // http response doc => https://docs.k6.io/docs/response-k6http
        // different checks you can try https://k6.readme.io/docs/check-val-sets-tags
        { "status is 200": (res) => res.status == 200,
          "status is 400": (res) => res.status == 400,
          "status is 401": (res) => res.status == 401,
          "status is 503": (res) => res.status == 503,
        });
}
