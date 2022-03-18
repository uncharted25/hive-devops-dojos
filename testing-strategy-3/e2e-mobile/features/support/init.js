/* eslint-env detox/detox */
import detox, {device, element} from "detox";
import {Before, BeforeAll, AfterAll, After} from "@cucumber/cucumber";
import config from "../../.detoxrc.json";
import {TIMEZONE} from "../constants/common";
import adapter from "./adapter";
import fs from "fs";
let ok = true;
// let technicalError = false;
const failedTests = [];

const sleep = (ms) => new Promise((resolve) => setTimeout(resolve, ms));

// timeout 15 minutes
BeforeAll({timeout: 15 * 60 * 1000}, async () => {
  console.log("Initializing Detox");
  await detox.init(config);
  console.log("Detox initialized");
  // console.log(device._deviceConfig.type);
  if (device.getPlatform() === "android") {
    const adbName = device.deviceDriver.adbName;
    console.log("Running adb as root");
    await device.deviceDriver.adb.adbCmd(adbName, `root`);
    // await device.deviceDriver.adb.adbCmd(adbName, `wait-for-device`);
    await sleep(3000);
    let adbOk = false;
    while (!adbOk) {
      try {
        console.log("Running adb reverses");
        await device.deviceDriver.adb.adbCmd(adbName, `reverse tcp:443 tcp:40443`);
        await device.deviceDriver.adb.adbCmd(adbName, `reverse tcp:80 tcp:40080`);
        // assuming server timezone is Asia/Bangkok, set the emulator timezone to match
        // todo: get timezone from server instead of fixed
        await device.deviceDriver.adb.adbCmd(adbName, `shell service call alarm 3 s16 ${TIMEZONE.Bangkok}`);
        adbOk = true;
      } catch (e) {
        console.error(e);
        await sleep(3000);
      }
    }
  }
  // try {
  //   // in the CI (maybe on attached mode?), the app need to be uninstalled first
  //   // but it always throw error
  //   await device.uninstallApp();
  // } catch (e) {
  //   // ignore this error
  //   console.log(e);
  // }
  // await device.installApp();

  if (device.getPlatform() === "ios") {
    console.log(fs.readFileSync("./features/support/ios_warning.txt", "utf-8"));
  } else if (device.getPlatform() === "android") {
    console.log(fs.readFileSync("./features/support/android_warning.txt", "utf-8"));
  }
  console.log("Launching app");
  await device.launchApp({
    delete: true,
    newInstance: true,
    disableTouchIndicators: true,
  });
});

Before("@delete-before-test", async () => {
  console.log("clear storage");
  await device.launchApp({delete: true});
});
Before("@un-enroll-biometric", async () => {
  console.log("un-enroll biometrics");
  await device.setBiometricEnrollment(false);
});
After("@un-enroll-biometric", async () => {
  console.log("un-enroll biometrics");
  await device.setBiometricEnrollment(false);
});

Before("@ios", function () {
  // skip iOS test if running on Android
  // this is the "Murphy's Law" path so we shouldn't care much
  if (device.getPlatform() === "android") {
    console.log("Skipping @ios test on Android");
    // this will results in fail test (via SKIPPED status)
    // the cleanup will also fail
    return "skipped";
  }
});
Before("@android", function () {
  // skip iOS test if running on Android
  // this is the "Murphy's Law" path so we shouldn't care much
  if (device.getPlatform() === "ios") {
    console.log("Skipping @android test on iOS");
    // this will results in fail test (via SKIPPED status)
    return "skipped";
  }
});

After("@reset-timezone-bangkok-after", async () => {
  console.log("resetting timezone back to bangkok");
  const adbName = device.deviceDriver.adbName;
  await device.deviceDriver.adb.adbCmd(adbName, `shell service call alarm 3 s16 ${TIMEZONE.Bangkok}`);
});
Before(async (context) => {
  await adapter.beforeEach(context);
  try {
    await device.reloadReactNative();
  } catch (e) {
    // in case of the app crash, we may want to restart it
    // because if not, the retry will not work (app isn't there)
    await device.launchApp({
      // delete: true,
      newInstance: true,
      disableTouchIndicators: true,
    });
  }
});

Before("@disable-sync", async () => {
  await device.disableSynchronization();
});

//this works in iOS only
Before("@th", async () => {
  await device.launchApp({
    newInstance: true,
    languageAndLocale: {
      language: "th",
      locale: "th",
    },
  });
});

After(async (context) => {
  await adapter.afterEach(context);
  const stepTags = context.pickle.tags ? context.pickle.tags.map((tag) => tag.name) : [];
  failedTests.push({
    feature: context.gherkinDocument.uri,
    step: context.pickle.name,
    stepTags: stepTags.join(" "),
  });
  ok = ok && context.result && (context.result.status === "PASSED" || context.result.status === "SKIPPED");
});

// eslint-disable-next-line no-unused-vars
After("@android", async (context) => {
  // await adapter.afterEach(context);

  try {
    // await expect(element(by.text("Cancel"))).toBeVisible();
    // Tap to dismiss any stray dialog (datepicker, is that you?)
    await element(by.text("Cancel")).multiTap(2);
    console.log('Stray dialog closed with "Cancel"');
    // eslint-disable-next-line no-empty
  } catch (e) {
    // technicalError = true;
  }
});

After("@disable-sync", async () => {
  await device.enableSynchronization();
});

// this has to be the last After
// eslint-disable-next-line no-unused-vars
// After(async (context) => {
//   try {
//     await device.reloadReactNative();
//   } catch (e) {
//     // in case of the app crash, we may want to restart it
//     // because if not, the retry will not work (app isn't there)
//     await device.launchApp({
//       // delete: true,
//       newInstance: true,
//       disableTouchIndicators: true,
//     });
//   }
// });

AfterAll(async () => {
  console.log(`Run result: ${ok ? "ok" : "NOT OK"}`);
  // if (device.getPlatform() === "android" && (!ok || technicalError)) {
  //   await device.terminateApp();
  // }
  if (!ok) {
    for (let i = 0; i < failedTests.length; i++) {
      const failedTest = failedTests[i];
      console.log("##### FAILED TESTS #####");
      console.log(failedTest.feature);
      console.log(failedTest.stepTags);
      console.log(failedTest.step);
      console.log("");
      console.log("##### FAILED TESTS #####");
    }
  }
  await detox.cleanup();
});
