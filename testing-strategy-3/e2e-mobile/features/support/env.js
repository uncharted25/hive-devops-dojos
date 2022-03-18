import {setDefaultTimeout} from "@cucumber/cucumber";
const timeout = 60 * 1000 * 5;
// console.log(`Cucumber's setDefaultTimeout to ${timeout}`);
setDefaultTimeout(timeout);
