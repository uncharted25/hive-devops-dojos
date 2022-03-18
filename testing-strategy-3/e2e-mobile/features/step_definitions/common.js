/* eslint-env detox/detox */
import {Given, Then, When} from "@cucumber/cucumber";
import {device, element, expect} from "detox";
import {DateTime as LxDateTime} from "luxon";
import {DEFAULT_TIMEOUT, TIMEZONE} from "../constants/common";
import {
  allowPermission,
  deepLinkNavigate,
  denyPermission,
  mapPermissionServices,
  replaceText,
  scrollToEdge,
  scrollToElement,
  scrollToElementText,
  scrollToPixel,
  setDeviceTimezone,
  shouldNotSee,
  shouldNotSeeText,
  shouldNotSeeWithChild,
  shouldSee,
  shouldSeeAtLeastOneByText,
  shouldSeeByText,
  shouldSeeWithChild,
  shouldSeeWithDate,
  shouldSeeWithDateAndPrefix,
  shouldSeeWithDateFromNowWithFormatAndPrefix,
  shouldSeeWithLabel,
  shouldSeeWithText,
  shouldSeeWithValue,
  swipeDown,
  tapById,
  tapByLabel,
  tapByText,
  tapByTextOnIosAlertMessage,
  typeText,
  wait,
  waitElement,
  waitElementByText,
  waitForScreen,
} from "./action";

const OVERSCROLL_PIXEL_MARGIN = 50;
const OVERSCROLL_PIXEL_MARGIN_HALF = OVERSCROLL_PIXEL_MARGIN / 2;
const DEFAULT_DATE_FORMAT = "dd/MM/yyyy";
const CURRENT_DATE = LxDateTime.now();
let datePickerMinimumDate = null; // LxDateTime
let datePickerMaximumDate = null; // LxDateTime

// ------ screen stuffs ------
Given("I visit {string} screen", deepLinkNavigate);

Given("I am on {string} screen", waitForScreen);

// ------ permission ------
/**
 * calendar=YES|NO
 * camera=YES|NO
 * contacts=YES|NO
 * health=YES|NO
 * homekit=YES|NO
 * location=always|inuse|never --> might need to create a different action for this
 * medialibrary=YES|NO
 * microphone=YES|NO
 * motion=YES|NO
 * notifications=YES|NO
 * photos=YES|NO
 * reminders=YES|NO
 * siri=YES|NO
 *
 * ** Reference: https://github.com/wix/AppleSimulatorUtils
 * ** Note: separate services using comma
 *      example: Given I allow permission to "calendar, camera, photos"
 */
Given("I allow permission to {string}", allowPermission);
Given("I deny permission to {string}", denyPermission);

/**
 * Wait for specific seconds until the component shows
 * NOT WORKING AS INTENDED
 */
When("I wait {int} seconds until I see {string}", async (seconds, componentId) => {
  await waitFor(element(by.id(componentId)))
    .toBeVisible()
    .withTimeout(seconds * 1000 + DEFAULT_TIMEOUT);
});

// ------ scroll to edge ------
/**
 * edge—the edge to scroll to (valid input: "left"/"right"/"top"/"bottom")
 */
When("I scroll {string} to {string}", scrollToEdge);
When("I scroll {string} to the top", async (scrollViewId) => {
  await scrollToEdge(scrollViewId, "top");
});
When("I scroll {string} to the bottom", async (scrollViewId) => {
  await scrollToEdge(scrollViewId, "bottom");
});
When("I scroll {string} to the rightmost", async (scrollViewId) => {
  await scrollToEdge(scrollViewId, "right");
});
When("I scroll {string} to the leftmost", async (scrollViewId) => {
  await scrollToEdge(scrollViewId, "left");
});

// ------ scroll to element ------
/**
 * Scroll down until element come into view
 */
When("I scroll {string} down until I see {string}", async (scrollViewId, componentId) => {
  await scrollToElement(scrollViewId, componentId, "down");
});
When("I scroll {string} down until I see {string} with some margin", async (scrollViewId, componentId) => {
  await scrollToElement(scrollViewId, componentId, "down");
  await scrollToPixel(scrollViewId, OVERSCROLL_PIXEL_MARGIN, "down");
});
When("I swipe {string} down for pull refresh", async (scrollViewId) => {
  await swipeDown(scrollViewId, 1000000, "up");
});
When("I scroll {string} up until I see {string} with some margin", async (scrollViewId, componentId) => {
  await scrollToElement(scrollViewId, componentId, "up");
  await scrollToPixel(scrollViewId, OVERSCROLL_PIXEL_MARGIN, "up");
});
/**
 * Scroll down with start normalized Y until element come into view
 * This will prevent to hit the bottom button of screen
 */
When(
  "I scroll {string} down with start normalized position y is {float} until I see {string}",
  async (scrollViewId, startNormalizedPositionY, componentId) => {
    await scrollToElement(scrollViewId, componentId, "down", NaN, startNormalizedPositionY);
  },
);
/**
 * Scroll up with start normalized Y until element come into view
 * This will prevent to hit the top  screen
 */
When(
  "I scroll {string} up with start normalized position y is {float} until I see {string}",
  async (scrollViewId, startNormalizedPositionY, componentId) => {
    await scrollToElement(scrollViewId, componentId, "up", NaN, startNormalizedPositionY);
  },
);
/**
 * Scroll right (horizontal) until element come into view
 */
When("I scroll {string} right until I see {string}", async (scrollViewId, componentId) => {
  await scrollToElement(scrollViewId, componentId, "right");
});
When("I scroll {string} right until I see {string} with some margin", async (scrollViewId, componentId) => {
  await scrollToElement(scrollViewId, componentId, "right");
  await scrollToPixel(scrollViewId, OVERSCROLL_PIXEL_MARGIN_HALF, "right");
});
When(
  "I scroll {string} right until I see {string} with {int} pixels",
  async (scrollViewId, componentId, scrollPixel) => {
    await scrollToElement(scrollViewId, componentId, "right", NaN, NaN, scrollPixel);
  },
);
/**
 * Scroll left (horizontal) until element come into view
 */
When("I scroll {string} left until I see {string}", async (scrollViewId, componentId) => {
  await scrollToElement(scrollViewId, componentId, "left");
});
When("I scroll {string} left until I see {string} with some margin", async (scrollViewId, componentId) => {
  await scrollToElement(scrollViewId, componentId, "left");
  await scrollToPixel(scrollViewId, OVERSCROLL_PIXEL_MARGIN_HALF, "left");
});

/**
 * Scroll up until element come into view
 */
When("I scroll {string} up until I see {string}", async (scrollViewId, componentId) => {
  await scrollToElement(scrollViewId, componentId, "up");
});
/**
 * Scroll down until text come into view
 */
When("I scroll {string} down until I see {string} text", async (scrollViewId, text) => {
  await scrollToElementText(scrollViewId, text, "down");
});
When("I scroll {string} down until I see {string} text with some margin", async (scrollViewId, text) => {
  await scrollToElementText(scrollViewId, text, "down");
  await scrollToPixel(scrollViewId, OVERSCROLL_PIXEL_MARGIN, "down");
});
/**
 * Scroll right (horizontal) until text come into view
 */
When("I scroll {string} right until I see {string} text", async (scrollViewId, text) => {
  await scrollToElementText(scrollViewId, text, "right");
});
/**
 * Scroll left (horizontal) until text come into view
 */
When("I scroll {string} left until I see {string} text", async (scrollViewId, text) => {
  await scrollToElementText(scrollViewId, text, "left");
});
/**
 * Scroll up until text come into view
 */
When("I scroll {string} up until I see {string} text", async (scrollViewId, text) => {
  await scrollToElementText(scrollViewId, text, "up");
});
/**
 * Scroll down until checkbox come into view
 */
When("I scroll {string} down until I see {string} unchecked checkbox", async (screenId, componentId) => {
  await scrollToElement(screenId, `unchecked-${componentId}`, "down");
});

// ------ Scroll with Pixel ------
When("I scroll {string} down {int} pixels", async (scrollViewId, scrollPixel) => {
  await scrollToPixel(scrollViewId, scrollPixel, "down");
});

When("I scroll {string} up {int} pixels", async (scrollViewId, scrollPixel) => {
  await scrollToPixel(scrollViewId, scrollPixel, "down");
});

// ------ tapping / typing ------
/**
 * component can be button or touchable
 */
When("I tap {string}", tapById);

When("I tap text {string}", tapByText);

When("I tap label {string}", tapByLabel);

When("I tap text {string} on ios alert message", tapByTextOnIosAlertMessage);

When("I tap the item number {int} of {string}", async (number, componentId) => {
  await waitFor(element(by.id(componentId)).atIndex(number - 1))
    .toBeVisible()
    .withTimeout(DEFAULT_TIMEOUT);

  await element(by.id(componentId))
    .atIndex(number - 1)
    .tap();
});

When("I type {string} into {string}", typeText);

When("I put {string} into {string}", replaceText);

When("I tap return on {string}", async (componentId) => {
  await waitElement(componentId);
  await element(by.id(componentId)).tapReturnKey();
});

// ------ visibility ------

Then("I should see text {string}", shouldSeeByText);

Then("I should see text {string} at least once", shouldSeeAtLeastOneByText);

Then("I see {string}", shouldSee);

Then("I should see {string}", shouldSee);

Then("I should not see {string}", shouldNotSee);

Then("I should not see text {string}", shouldNotSeeText);

Then("I should see {string} with text {string}", shouldSeeWithText);

Then("I should see {string} with value {string}", shouldSeeWithValue);

Then("I should see {string} with label {string}", shouldSeeWithLabel);

Then("I should see {string} with date {string} days from now", shouldSeeWithDate);
Then("I should see {string} with date {string} days from now and prefix of {string}", shouldSeeWithDateAndPrefix);
Then(
  "I should see {string} with date {int} days from now with format {string} and prefix of {string}",
  shouldSeeWithDateFromNowWithFormatAndPrefix,
);

Then("I should see {string} with child {string}", shouldSeeWithChild);
Then("I should not see {string} with child {string}", shouldNotSeeWithChild);

Then("I should see {string} at index {int} with text {string}", async (componentId, index, text) => {
  await waitFor(element(by.id(componentId)).atIndex(index))
    .toHaveText(text)
    .withTimeout(DEFAULT_TIMEOUT);
});
Then("I should see {string} at index {int} with label {string}", async (componentId, index, label) => {
  await waitFor(element(by.id(componentId)).atIndex(index))
    .toHaveLabel(label)
    .withTimeout(DEFAULT_TIMEOUT);
});

Then("I should see at least one {string}", async (componentId) => {
  await waitFor(element(by.id(componentId)).atIndex(0))
    .toBeVisible()
    .withTimeout(DEFAULT_TIMEOUT);
});

Then("I should see at least one {string} with text {string}", async (componentId, text) => {
  await waitFor(element(by.id(componentId)).atIndex(0))
    .toHaveText(text)
    .withTimeout(DEFAULT_TIMEOUT);
});

Then("I should see the item number {int} of {string}", async (number, componentId) => {
  await waitFor(element(by.id(componentId)).atIndex(number - 1))
    .toBeVisible()
    .withTimeout(DEFAULT_TIMEOUT);
});

// ------ system stuffs ------
When("I wait {int} seconds", async (seconds) => {
  await wait(seconds * 1000);
});

When("disable synchronization", async () => {
  await device.disableSynchronization();
});

When("enable synchronization", async () => {
  await device.enableSynchronization();
});

// ------ special interaction with AppCheckbox ------
// we add "unchecked-" or "checked-" prefix to the testID
When("I check {string} checkbox", async (componentId) => {
  const id = `unchecked-${componentId}`;
  await tapById(id);
});
When("I uncheck {string} checkbox", async (componentId) => {
  const id = `checked-${componentId}`;
  await tapById(id);
});
Then("I should see {string} unchecked", async (componentId) => {
  const id = `unchecked-${componentId}`;
  await shouldSee(id);
});
Then("I should see {string} checked", async (componentId) => {
  const id = `checked-${componentId}`;
  await shouldSee(id);
});

// ------ Date Picker ------
/**
 * Note for the new implementation of date-picker:
 * - the date value could either be 'today', 'yesterday', 'tomorrow' or a date phrase
 * - (date phrase 1st part) count -- any positive number
 * - (date phrase 2nd part) unit -- 'year', 'month' or 'day'
 * - (date phrase 3rd part) tense -- 'before' or 'after'
 */

/**
 * Set the minimum and maximum date of date-picker
 * - "minOrMax" -- only accepts 'minimum' or 'maximum'
 */
When("I set the datepicker {string} date to {string}", async (minOrMax, value) => {
  switch (minOrMax) {
    case "minimum":
      datePickerMinimumDate = !value ? null : parseDate(value);
      break;
    case "maximum":
      datePickerMaximumDate = !value ? null : parseDate(value);
      break;
    default:
      console.error("Invalid min-max string - only accepts 'minimum', 'maximum' or empty string '' to remove");
      break;
  }
});

/**
 * Changing date-picker with reference to the current date
 * - should only be used once per scenario
 */
When("I open the {string} datepicker and pick the date {string}", async (componentId, value) => {
  // ex: I open the "test-id" datepicker and pick the date "today"
  // ex: I open the "test-id" datepicker and pick the date "5 days before"

  /** Prepare components */
  const button = `${componentId}-button`;
  const datePicker = `${componentId}-date-picker`;
  const closeIcon = `${componentId}-date-picker-modal-close-icon`;

  /** Prepare common variables */
  const fromDate = CURRENT_DATE;
  const toDate = parseDate(value);
  if (!toDate) return; // Invalid date

  /** Open the date-picker */
  await element(by.id(button)).tap();

  /** Apply changes for either 'android' or 'iOS' */
  device.getPlatform() === "android"
    ? await changeAndroidDatePicker(fromDate, toDate)
    : await changeIosDatePicker(datePicker, closeIcon, toDate);
});

/**
 * Changing date-picker with 'fromDate' and 'toDate'
 * - ideally used after initializing a value on a date-picker
 * - can be used multiple times
 */
When(
  "I open the {string} datepicker and pick the date from {string} to {string}",
  async (componentId, fromDateValue, toDateValue) => {
    // ex: I open the "test-id" datepicker and pick the date from "today" to "5 days before"
    // ex: I open the "test-id" datepicker and pick the date from "5 days before" to "tomorrow"

    /** Prepare components */
    const button = `${componentId}-button`;
    const datePicker = `${componentId}-date-picker`;
    const closeIcon = `${componentId}-date-picker-modal-close-icon`;

    /** Prepare common variables */
    const fromDate = parseDate(fromDateValue);
    const toDate = parseDate(toDateValue);
    if (!fromDate || !toDate) return; // Invalid date

    /** Open the date picker */
    await element(by.id(button)).tap();

    /** Apply changes for either 'android' or 'iOS' */
    device.getPlatform() === "android"
      ? await changeAndroidDatePicker(fromDate, toDate)
      : await changeIosDatePicker(datePicker, closeIcon, toDate);
  },
);

/** The value that we expect here should be the same with how we change the date-picker */
Then("I should see {string} datepicker with date of {string}", async (componentId, value) => {
  // ex: I should see test-id" datepicker with date of "today"
  // ex: I should see test-id" datepicker with date of "5 days before"
  await waitElement(componentId);
  const expectedValue = parseDate(value).toFormat(DEFAULT_DATE_FORMAT); // native datepicker always displays 'dd/MM/yyyy' format
  console.log(`Checking if date picker to have: ${expectedValue}`); // TODO: remove log when fixed
  await expect(element(by.id(componentId))).toHaveText(expectedValue);
});

Then("I should see {string} with current date in format {string}", async (componentId, format) => {
  await waitElement(componentId);
  await expect(element(by.id(componentId))).toHaveText(CURRENT_DATE.toFormat(format));
});

Then("I should see {string} with date {int} months ago", async (componentId, value) => {
  await waitElement(componentId);
  // UTC is required on both E2E and frontend or else it will has a bounce back case
  const pastDate = CURRENT_DATE.minus({months: value}).toFormat(DEFAULT_DATE_FORMAT);
  await expect(element(by.id(componentId))).toHaveText(pastDate);
});

Then("I tap and close the date picker in date answer question and see current date in format", async () => {
  if (device.getPlatform() === "ios") {
    await tapById("question-input-datepicker-button");
    await shouldSee("question-input-datepicker-date-picker-modal");
    await shouldSee("question-input-datepicker-date-picker");
    await tapById("question-input-datepicker-date-picker-modal-close-icon");

    await waitElement("question-input-datepicker-textinput");
    await expect(element(by.id("question-input-datepicker-textinput"))).toHaveText(
      CURRENT_DATE.toFormat(DEFAULT_DATE_FORMAT),
    );
  }

  if (device.getPlatform() === "android") {
    await tapById("question-input-datepicker-button");
    const currentDate = CURRENT_DATE;
    const monthText = currentDate.monthShort;
    const dayText = currentDate.day.toString().padStart(2, "0");
    const yearText = currentDate.year.toString();
    await waitElementByText(monthText);
    await element(by.text(monthText)).tap();
    await waitElementByText(dayText);
    await element(by.text(dayText)).tap();
    await waitElementByText(yearText);
    await element(by.text(yearText)).tap();
    await element(by.text(yearText)).tapReturnKey();
    await wait(3000);
    await waitElementByText("CANCEL"); //CANCEL
    await element(by.text("CANCEL")).multiTap(2); //CANCEL
    await wait(3000);
    await waitElement("question-input-datepicker-textinput");
    await expect(element(by.id("question-input-datepicker-textinput"))).toHaveText(
      CURRENT_DATE.toFormat(DEFAULT_DATE_FORMAT),
    );
  }
});

// ------ Date Picker IOS ------

// When("I pick date today from {string} on ios", async (componentId) => {
//   await waitElement(componentId);
//   await element(by.id(componentId)).setDatePickerDate(
//     CURRENT_DATE.toFormat(DEFAULT_DATE_FORMAT),
//     DEFAULT_DATE_FORMAT,
//   );
// });

When("I pick date tomorrow from {string} on ios", async (componentId) => {
  await waitElement(componentId);
  await element(by.id(componentId)).setDatePickerDate(
    CURRENT_DATE.plus({days: 1}).toFormat(DEFAULT_DATE_FORMAT),
    DEFAULT_DATE_FORMAT,
  );
});

When("I pick date {string} from {string} on ios", async (value, componentId) => {
  await waitElement(componentId);
  await element(by.id(componentId)).setDatePickerDate(value, DEFAULT_DATE_FORMAT);
});

When("I pick date {int} months ago from {string} on ios", async (value, componentId) => {
  await waitElement(componentId);
  // UTC is required on both E2E and frontend or else it will has a bounce back case
  const pastDate = CURRENT_DATE.minus({months: value}).toFormat(DEFAULT_DATE_FORMAT);
  await element(by.id(componentId)).setDatePickerDate(pastDate, DEFAULT_DATE_FORMAT);
});

// ------ Date Picker Android ------
// TODO: should see the text inside specific component id but detox can not see the date picker
Then("I should see text of current month,date,year on android", async () => {
  // UTC is required on both E2E and frontend or else it will has a bounce back case
  // TODO: time zone should be automatically set and match the app
  const currentDate = CURRENT_DATE;
  const monthText = currentDate.monthShort;
  const dayText = currentDate.day.toString().padStart(2, "0");
  const yearText = currentDate.year.toString();

  await waitFor(element(by.text(monthText)))
    .toBeVisible()
    .withTimeout(DEFAULT_TIMEOUT);
  //   //TODO not needed
  // await waitElementByText(monthText);
  // await element(by.text(monthText)).tap();

  await waitFor(element(by.text(dayText)))
    .toBeVisible()
    .withTimeout(DEFAULT_TIMEOUT);
  //   //TODO not needed
  // await waitElementByText(dayText);
  // await element(by.text(dayText)).tap();

  await waitFor(element(by.text(yearText)))
    .toBeVisible()
    .withTimeout(DEFAULT_TIMEOUT);
  //   //TODO not needed
  // await waitElementByText(yearText);
  // await element(by.text(yearText)).tap();
  // await element(by.text(yearText)).tapReturnKey();
});

When("I replace current month,date,year with date from {int} months ago on android", async (value) => {
  const pastDate = CURRENT_DATE.minus({months: value});

  const pastDateMonthText = pastDate.monthShort;
  const pastDateDayText = pastDate.day.toString().padStart(2, "0");
  const pastDateYearText = pastDate.year.toString();

  const currentDate = CURRENT_DATE;
  let currentDateMonthText = currentDate.monthShort; // using "let" in case of year change
  const currentDateDayText = currentDate.day.toString().padStart(2, "0");
  const currentDateYearText = currentDate.year.toString();

  await waitElementByText(currentDateYearText);
  await element(by.text(currentDateYearText)).longPress();
  await element(by.text(currentDateYearText)).replaceText(pastDateYearText);

  await waitElementByText(currentDateMonthText);
  await element(by.text(currentDateMonthText)).longPress();

  // if year change, the "current month" text will be six month ago
  if (pastDate.year < currentDate.year) {
    const sixMonthsAgoDate = CURRENT_DATE.minus({months: 6});
    currentDateMonthText = sixMonthsAgoDate.monthShort;
  }
  await element(by.text(currentDateMonthText)).replaceText(pastDateMonthText);

  await waitElementByText(currentDateDayText);
  await element(by.text(currentDateDayText)).longPress();
  await element(by.text(currentDateDayText)).replaceText(pastDateDayText);

  await element(by.text(pastDateDayText)).tapReturnKey();
});

When(
  "I replace month,date,year from {int} months ago with date from {int} months ago on android",
  async (fromMonth, toMonth) => {
    const fromDate = CURRENT_DATE.minus({months: fromMonth});
    const fromDateMonthText = fromDate.monthShort;
    const fromDateDayText = fromDate.day.toString().padStart(2, "0");
    const fromDateYearText = fromDate.year.toString();

    const toDate = CURRENT_DATE.minus({months: toMonth});
    const toDateMonthText = toDate.monthShort;
    const toDateDayText = toDate.day.toString().padStart(2, "0");
    const toDateYearText = toDate.year.toString();

    await waitElementByText(fromDateMonthText);
    await element(by.text(fromDateMonthText)).longPress();
    await element(by.text(fromDateMonthText)).replaceText(toDateMonthText);

    await waitElementByText(fromDateDayText);
    await element(by.text(fromDateDayText)).longPress();
    await element(by.text(fromDateDayText)).replaceText(toDateDayText);

    await waitElementByText(fromDateYearText);
    await element(by.text(fromDateYearText)).longPress();
    await element(by.text(fromDateYearText)).replaceText(toDateYearText);
    await element(by.text(fromDateYearText)).tapReturnKey();
  },
);
When("I replace month,date,year from {int} months ago with date tomorrow on android", async (fromMonth) => {
  const fromDate = CURRENT_DATE.minus({months: fromMonth});
  const fromDateMonthText = fromDate.monthShort;
  const fromDateDayText = fromDate.day.toString().padStart(2, "0");
  const fromDateYearText = fromDate.year.toString();

  const toDate = CURRENT_DATE.plus({days: 1});
  const toDateMonthText = toDate.monthShort;
  const toDateDayText = toDate.day.toString().padStart(2, "0");
  const toDateYearText = toDate.year.toString();

  await waitElementByText(fromDateMonthText);
  await element(by.text(fromDateMonthText)).longPress();
  await element(by.text(fromDateMonthText)).replaceText(toDateMonthText);

  await waitElementByText(fromDateDayText);
  await element(by.text(fromDateDayText)).longPress();
  await element(by.text(fromDateDayText)).replaceText(toDateDayText);

  await waitElementByText(fromDateYearText);
  await element(by.text(fromDateYearText)).longPress();
  await element(by.text(fromDateYearText)).replaceText(toDateYearText);
  await element(by.text(fromDateYearText)).tapReturnKey();
});

When("I tap OK on android datepicker", async () => {
  await wait(3000);
  await waitElementByText("OK");
  await element(by.text("OK")).multiTap(2);
  await wait(3000);
});

When("I tap CANCEL on android datepicker", async () => {
  await wait(3000);
  await waitElementByText("CANCEL");
  await element(by.text("CANCEL")).multiTap(2);
  await wait(3000);
});

When("I reload the app", async () => {
  await device.reloadReactNative();
});
When("I delete and reinstall the app", async () => {
  await device.launchApp({delete: true});
});
When("I delete and reinstall the app with {string} permission", async (services) => {
  const serviceMap = mapPermissionServices(services, true);
  await device.launchApp({delete: true, permissions: serviceMap});
});
When("I enroll biometrics", async () => {
  // turn off and on again
  await device.setBiometricEnrollment(false);
  await device.setBiometricEnrollment(true);
});
When("I un-enroll biometrics", async () => {
  await device.setBiometricEnrollment(false);
});
When("I scan my face", () => {
  device.matchFace();
});
// When("I scan someone else face", async () => {
//   await device.unmatchFace();
// });
When("I scan someone else face", () => {
  device.unmatchFace();
});
// ------ obsolete ------
Then("I hide soft keyboard", async () => {
  // if (device.getPlatform() === "ios") {
  //   // not working
  //   // await element(by.label("return")).tap();
  //   // await element(by.label("return")).tapReturnKey();
  // } else {
  //   await device.pressBack();
  // }
});

When("[LOG] {string}", async (text) => {
  console.log("[LOG] ", text);
});

/******************************
 * Date Picker Helper Functions
 ******************************/

/** Android specific -- compare 2 LxDateTime dates and apply to the date-picker */
const changeAndroidDatePicker = async (fromDate, toDate) => {
  console.log("------------ changeAndroidDatePicker ------------"); // TODO: remove log when fixed
  /** Check if dates are different */
  if (fromDate !== toDate) {
    /** Prepare date variables */
    let fromDateYear = fromDate.year;
    let fromDateMonth = fromDate.month;
    let fromDateDay = fromDate.day;
    let fromDateLuxon = LxDateTime.fromObject({year: fromDateYear, month: fromDateMonth, day: fromDateDay});
    console.log(`FROM: ${fromDateYear} - ${fromDateMonth} - ${fromDateDay}`); // TODO: remove log when fixed

    let toDateYear = toDate.year;
    let toDateMonth = toDate.month;
    let toDateDay = toDate.day;
    let toDateLuxon = LxDateTime.fromObject({year: toDateYear, month: toDateMonth, day: toDateDay});
    console.log(`TO: ${toDateYear} - ${toDateMonth} - ${toDateDay}`); // TODO: remove log when fixed

    let minYear = null;
    let minMonth = null;
    let minDay = null;

    let maxYear = null;
    let maxMonth = null;
    let maxDay = null;

    let hasExceededMinimumDate = false;
    let hasExceededMaximumDate = false;

    /**
     * Adjust the date when it exceeds min or max
     * - when we change the Year, sometimes the Month and Day automatically changes
     * - so we need to re-align if that happens
     */
    if (datePickerMinimumDate) {
      minYear = datePickerMinimumDate.year;
      minMonth = datePickerMinimumDate.month;
      minDay = datePickerMinimumDate.day;
      let minLuxon = LxDateTime.fromObject({year: minYear, month: minMonth, day: minDay});
      console.log(`* MIN: ${minYear} - ${minMonth} - ${minDay}`); // TODO: remove log when fixed

      if (toDateLuxon < minLuxon) {
        console.log("--> minimum exceeded - will use MIN to replace TO date"); // TODO: remove log when fixed
        toDateYear = minYear;
        toDateMonth = minMonth;
        toDateDay = minDay;
        hasExceededMinimumDate = true;
      }
    }
    if (datePickerMaximumDate) {
      maxYear = datePickerMaximumDate.year;
      maxMonth = datePickerMaximumDate.month;
      maxDay = datePickerMaximumDate.day;
      let maxLuxon = LxDateTime.fromObject({year: maxYear, month: maxMonth, day: maxDay});
      console.log(`* MAX: ${maxYear} - ${maxMonth} - ${maxDay}`); // TODO: remove log when fixed

      if (toDateLuxon > maxLuxon) {
        console.log("--> maximum exceeded - will use MAX to replace TO date"); // TODO: remove log when fixed
        toDateYear = maxYear;
        toDateMonth = maxMonth;
        toDateDay = maxDay;
        hasExceededMaximumDate = true;
      }
    }

    console.log("------ final values to compare ------"); // TODO: remove log when fixed
    console.log(`++ FROM: ${fromDateYear} - ${fromDateMonth} - ${fromDateDay}`); // TODO: remove log when fixed
    console.log(`++ TO: ${toDateYear} - ${toDateMonth} - ${toDateDay}`); // TODO: remove log when fixed

    /** Check each date category if there are differences */
    /********
     * YEAR *
     ********/
    if (fromDateYear !== toDateYear) {
      console.log(`-+-+-+ changing YEAR -+-+-+`);
      const fromDateYearText = fromDateYear.toString();
      const toDateYearText = toDateYear.toString();
      await androidDatePickerTapAndReplace(fromDateYearText, toDateYearText);

      /**
       * Note:
       * - When the Minimum date has exceeded, changing the YEAR will automatically change the MONTH and DAY
       * - When the Maximum date has exceeded, no automatic change (I think - but I might be wrong)
       */
      if (hasExceededMinimumDate) {
        /** No need to change Month and Day - click OK then exit */
        await androidDateTapOK();
        return;
      }
    }

    /*********
     * MONTH *
     *********/
    if (fromDateMonth !== toDateMonth) {
      console.log(`-+-+-+ changing MONTH -+-+-+`); // TODO: remove log when fixed
      const fromDateMonthText = LxDateTime.fromObject({month: fromDateMonth}).toFormat("MMM");
      const toDateMonthText = LxDateTime.fromObject({month: toDateMonth}).toFormat("MMM");
      await androidDatePickerTapAndReplace(fromDateMonthText, toDateMonthText);

      /**
       * Note:
       * - When the Minimum date has exceeded, changing the MONTH will automatically change the DAY
       * - When the Maximum date has exceeded, no automatic change (I think - but I might be wrong)
       */
      if (hasExceededMinimumDate) {
        /** No need to change Day - click OK then exit */
        await androidDateTapOK();
        return;
      }

      /**
       * Note:
       * - If maximumDate was set, even if we don't reach the maximum date, there are weird things going on with Jan and Dec
       */
      if (fromDateYear === toDateYear) {
        console.log("*** needs to create special condition here ***"); // TODO: remove log when fixed

        if (fromDateMonth === 12 && toDateMonth === 1) {
          console.error("This is a bug from Android date-picker -- needs a work-around"); // TODO: remove log when fixed
        }
      }
    }

    /*******
     * DAY *
     *******/
    if (fromDateDay !== toDateDay) {
      console.log(`-+-+-+ changing DAY -+-+-+`); // TODO: remove log when fixed
      const fromDateDayText = fromDateDay.toString().padStart(2, "0");
      const toDateDayText = toDateDay.toString().padStart(2, "0");
      await androidDatePickerTapAndReplace(fromDateDayText, toDateDayText);
    }
  }

  /** Confirm by clicking 'OK' */
  await androidDateTapOK();
};

/** Android specific -- changing the date based on text */
const androidDatePickerTapAndReplace = async (fromDateText, toDateText) => {
  console.log(`-+-+-+ androidDatePickerTapAndReplace -+-+-+`); // TODO: remove log when fixed
  console.log(`fromDateText: `, fromDateText); // TODO: remove log when fixed
  console.log(`toDateText: `, toDateText); // TODO: remove log when fixed
  await waitElementByText(fromDateText);
  await element(by.text(fromDateText)).tap();
  await wait(1000); // wait a little before replacing
  await element(by.text(fromDateText)).replaceText(toDateText);
  await wait(1000); // wait a little before tapping again
  await element(by.text(toDateText)).tap();
};

/** Android specific -- click OK button to confirm the selected date */
const androidDateTapOK = async () => {
  /** Confirm by clicking 'OK' */
  await wait(1000); // wait a little before clicking OK
  await waitElementByText("OK");
  await element(by.text("OK")).multiTap(2);
};

/** iOS specific -- straight apply the date to the date picker */
const changeIosDatePicker = async (datePicker, closeIcon, toDate) => {
  const toDateString = toDate.toFormat(DEFAULT_DATE_FORMAT);
  await waitElement(datePicker);
  await element(by.id(datePicker)).setDatePickerDate(toDateString, DEFAULT_DATE_FORMAT);
  /** Confirm by clicking the close icon */
  await element(by.id(closeIcon)).tap();
};

/**
 * Modifies the 'value' with regards to the current date
 * - value could either be "today", "yesterday", "tomorrow" or a date phrase
 */
const parseDate = (value) => {
  const mainDate = value.trim().toLowerCase();
  const currentDate = CURRENT_DATE; // always reference from current date

  /** Check for the date phrase */
  switch (mainDate) {
    case "today":
      return currentDate;
    case "yesterday":
      return currentDate.minus({day: 1});
    case "tomorrow":
      return currentDate.plus({day: 1});
  }

  /** Process date phrase - ex: "5 days before" */
  const valueArr = mainDate.split(" ");
  let [count, unit, tense] = valueArr; // ex: count=5 unit='months' tense='before'

  /** Check validity of 'count' - should only accept positive integer */
  if (!+count.match(/^\d+$/)) {
    console.error("Invalid date count - only accepts positive integer");
    return; // invalid
  }

  /**
   * Check validity of 'unit'
   * - should only accept 'year', 'month' or 'day'
   * - remove 's' for plural date -- Luxon uses singular noun only
   */
  if (unit.match(/[s]+$/)) {
    unit = unit.replace("s", ""); // ex: 'months' --> 'month'
  }
  /** Check acceptable units */
  const acceptedUnits = ["year", "month", "day"];
  if (acceptedUnits.indexOf(unit) === -1) {
    console.error("Invalid date unit - only accepts 'year', 'month' or 'day'");
    return; // invalid
  }

  /** Check validity of 'tense' - should only accept 'before' or 'after */
  let toDate = null;
  switch (tense) {
    case "before":
      toDate = currentDate.minus({[unit]: +count});
      break;
    case "after":
      toDate = currentDate.plus({[unit]: +count});
      break;
    default:
      console.error("Invalid date tense - only accepts 'before' or 'after'");
      return; // invalid
  }
  return toDate;
};

Given("I am on Hong Kong timezone", () => setDeviceTimezone(TIMEZONE.HongKong));

// ------------------- These are for debuging datepicker on android ------------------- //
When("I replace current year with date from {int} months ago on android", async (value) => {
  const pastDate = CURRENT_DATE.minus({months: value});

  const pastDateYearText = pastDate.year.toString();

  const currentDate = CURRENT_DATE;
  const currentDateYearText = currentDate.year.toString();

  console.log(`Before change year from: ${currentDateYearText}, to: ${pastDateYearText}`);

  await waitElementByText(currentDateYearText);
  await element(by.text(currentDateYearText)).longPress();

  console.log("Tap the year");

  await element(by.text(currentDateYearText)).replaceText(pastDateYearText);
});

When("I replace current month with date from {int} months ago on android", async (value) => {
  const pastDate = CURRENT_DATE.minus({months: value});

  const pastDateMonthText = pastDate.monthShort;

  const currentDate = CURRENT_DATE;
  let currentDateMonthText = currentDate.monthShort; // using "let" in case of year change

  console.log(`Before change month from: ${currentDateMonthText}, to: ${pastDateMonthText}`);

  await waitElementByText(currentDateMonthText);
  await element(by.text(currentDateMonthText)).longPress();

  console.log("Tap the month");

  // if year change, the "current month" text will be six month ago
  if (pastDate.year < currentDate.year) {
    const sixMonthsAgoDate = CURRENT_DATE.minus({months: 6});
    currentDateMonthText = sixMonthsAgoDate.monthShort;
  }

  console.log(`Before change month from: ${currentDateMonthText}, to: ${pastDateMonthText}`);

  await element(by.text(currentDateMonthText)).replaceText(pastDateMonthText);
});

When("I replace current date with date from {int} months ago on android", async (value) => {
  const pastDate = CURRENT_DATE.minus({months: value});

  const pastDateDayText = pastDate.day.toString().padStart(2, "0");

  const currentDate = CURRENT_DATE;
  const currentDateDayText = currentDate.day.toString().padStart(2, "0");

  console.log(`Before change day from: ${currentDateDayText}, to: ${pastDateDayText}`);

  await waitElementByText(currentDateDayText);
  await element(by.text(currentDateDayText)).longPress();

  console.log("Tap the date");

  await element(by.text(currentDateDayText)).replaceText(pastDateDayText);

  await element(by.text(pastDateDayText)).tapReturnKey();
});
