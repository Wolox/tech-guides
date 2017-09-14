import { check } from "k6";
import http from "k6/http";

const baseUrl = "SOME_URL"

export default function() {
  let responses = http.batch([
    baseUrl + "RESULT_ENDPOINT?job_id=" + jobId,
    // CSS
    baseUrl + "my-page.css",
    // JS
    baseUrl + "my-page.js",
    // FONTS
    baseUrl + "my-page.otf",
    // IMAGES
    baseUrl + "logo.svg",
    baseUrl + "cover.png",
  ]);
  check(responses[0], {
    "search page status was 200": res => res.status === 200,
  });
};
