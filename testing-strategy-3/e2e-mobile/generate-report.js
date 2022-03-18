// This is the main script to generate a test report from cucumber json.
// Reference : https://www.npmjs.com/package/multiple-cucumber-html-reporter
const report = require("multiple-cucumber-html-reporter");

// Read argument
const isAndroid = process.argv?.[2] === "android";

console.log("Generating report....");

report.generate({
  jsonDir: "./cucumber-json",
  reportPath: "./reports",
  metadata: {
    // TODO : Read data from emulator
    device: isAndroid ? "Android Emulator" : "iOS Emulator",
    platform: isAndroid
      ? {
          name: "Android",
          version: "23",
        }
      : {
          name: "iOS",
          version: "14.5",
        },
  },
  customData: {
    title: "Run info",
    data: [
      // TODO : Change your it to project name
      { label: "Project", value: "Hive E2E template" },
      // TODO : Read from released tag or sprint tag
      { label: "Release", value: "1.2.3" },
      // TODO : Integrate this with your CI
      { label: "Execution Start Time", value: "Nov 19th 2017, 02:31 PM EST" },
      { label: "Execution End Time", value: "Nov 19th 2017, 02:56 PM EST" },
    ],
  },
});
