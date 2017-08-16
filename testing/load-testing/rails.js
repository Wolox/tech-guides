import { check } from "k6";
import http from "k6/http";

const headers = { "Content-Type": "application/json", "Accept": "application/json" };

const searchParams = {
  // Some params
};

const baseUrl = "SOME_URL"

export default function() {
  const home = http.get(baseUrl)
  check(home, {
    "home status was 200": res => res.status === 200,
  });

  // Get the CSRF token
  headers["X-CSRF-Token"] = home.body.split("name=\"csrf-token\" content=\"")[1].split("\" />")[0];

  let res = http.post(baseUrl + "SOME_API_JOB_ENDPOINT", JSON.stringify(searchParams), { headers: headers });
  check(res, {
    "api search status was 200": res => res.status === 200,
  });

  // User checks the background job status in another page
  const jobId = JSON.parse(res.body).job_id;
  let responses = http.batch([
    baseUrl + "RESULT_ENDPOINT?job_id=" + jobId,
    // CSS
    baseUrl + "my-page.css",
    // JS
    baseUrl + "my-page.js",
    // FONTS
    baseUrl + "my-page.otf"
  ]);
  check(responses[0], {
    "search page status was 200": res => res.status === 200,
  });
};
