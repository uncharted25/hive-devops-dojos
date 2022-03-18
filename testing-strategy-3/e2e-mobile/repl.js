import detox from "detox";
import {forEach, keys} from "lodash";
import * as actions from "./features/step_definitions/action.js";
const config = require("./.detoxrc.json");
const readline = require("readline");
const yargs = require("yargs/yargs");
const {hideBin} = require("yargs/helpers");

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
  prompt: "action> ",
  completer: (line) => {
    const completions = keys(actions);
    const hits = completions.filter((c) => c.startsWith(line));
    // Show all completions if none found
    return [hits.length ? hits : completions, line];
  },
});

const sleep = (ms) => new Promise((resolve) => setTimeout(resolve, ms));

const cleanup = async () => {
  console.log("\nCleaning up");
  await detox.cleanup();
  console.log("Detox cleaned up");
};

const printHelp = () => {
  console.log("\nAvailable actions are:");
  forEach(actions, (v, k) => {
    console.log(k);
  });
  console.log();
};

const main = async (selectedConfiguration) => {
  // config.configurations[selectedConfiguration].behavior.cleanup.shutdownDevice = false;
  console.log("Initializing Detox");
  await detox.init({
    ...config,
    selectedConfiguration,
  });
  console.log("Detox initialized");
  const device = detox.device;

  if (device.getPlatform() === "android") {
    const adbName = device.deviceDriver.adbName;
    console.log("Running adb as root");
    await device.deviceDriver.adb.adbCmd(adbName, `root`);
    await sleep(3000);
    let adbOk = false;
    while (!adbOk) {
      try {
        console.log("Running adb reverses");
        await device.deviceDriver.adb.adbCmd(adbName, `reverse tcp:443 tcp:40443`);
        await device.deviceDriver.adb.adbCmd(adbName, `reverse tcp:80 tcp:40080`);
        adbOk = true;
      } catch (e) {
        console.error(e);
        await sleep(3000);
      }
    }
  }
  console.log("Detox ready");

  console.log("Launching app");
  await device.launchApp({
    delete: true,
    newInstance: true,
    disableTouchIndicators: true,
  });
  await device.disableSynchronization();

  console.log("action ...args");
  printHelp();

  rl.prompt();

  rl.on("line", async (line) => {
    line = line.trim();
    if (line.toLowerCase() === "exit") {
      await cleanup();
    } else {
      const parsed = yargs(line).positional("params", {}).parse();
      const name = parsed._[0];
      const args = parsed._.splice(1);
      console.log(...args);
      const action = actions[name];
      if (action) {
        try {
          await action(...args);
          console.log("Success");
        } catch (e) {
          console.error(e);
          console.error("FAIL");
        }
      } else {
        console.log(`Invalid action ${name}`);
        printHelp();
      }
    }
    rl.prompt();
  }).on("close", async () => {
    await cleanup();
  });
};
const argv = yargs(hideBin(process.argv)).argv;
main(argv["configuration"]);
