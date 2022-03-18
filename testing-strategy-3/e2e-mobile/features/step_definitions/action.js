/* eslint-env detox/detox */
import {device, element} from "detox";
import {DateTime as LxDateTime} from "luxon";
import {DEEP_LINK_APP_NAME, DEFAULT_TIMEOUT} from "../constants/common";

const DEFAULT_SCREEN = "Discover";
const CURRENT_DATE = LxDateTime.now();
const DATE_MONTH_FORMAT = "dd MMM";

export const wait = (milliseconds) => {
  return new Promise((resolve) => setTimeout(resolve, milliseconds));
};

export const waitElement = async (componentId) => {
  await waitFor(element(by.id(componentId)))
    .toBeVisible()
    .withTimeout(DEFAULT_TIMEOUT);
};

export const waitElementByText = async (text) => {
  await waitFor(element(by.text(text)))
    .toBeVisible()
    .withTimeout(DEFAULT_TIMEOUT);
};

export const waitForScreen = async (routeName) => {
  await waitFor(element(by.id(`${routeName.toLowerCase()}-screen`)))
    .toBeVisible()
    .withTimeout(DEFAULT_TIMEOUT);
};

export const deepLinkNavigate = async (routeName) => {
  if (routeName === DEFAULT_SCREEN) {
    // console.debug("waiting 3 seconds");
    // await wait(3000);
    // look for the screen instead for waiting for a fixed period
    await waitForScreen("Discover");
  } else {
    // on slow machine (*cough* CI *cough*) if we navigate too fast, it will fail
    // console.debug("waiting 10 seconds");
    // await wait(10000);
    // look for the screen instead for waiting for a fixed period
    await wait(3000);
    await waitForScreen("Discover");
  }
  await device.openURL({url: `${DEEP_LINK_APP_NAME}://${routeName}`});
  await waitForScreen(routeName);
};

export const shouldSee = async (componentId) => {
  await waitFor(element(by.id(componentId)))
    .toBeVisible()
    .withTimeout(DEFAULT_TIMEOUT);
};
export const shouldNotSee = async (componentId) => {
  await waitFor(element(by.id(componentId)))
    .not.toBeVisible()
    .withTimeout(DEFAULT_TIMEOUT);
};
export const shouldNotSeeText = async (text) => {
  await waitFor(element(by.text(text)))
    .not.toBeVisible()
    .withTimeout(DEFAULT_TIMEOUT);
};
export const shouldSeeWithText = async (componentId, value) => {
  await waitFor(element(by.id(componentId)))
    .toHaveText(value)
    .withTimeout(DEFAULT_TIMEOUT);
};
export const shouldSeeWithLabel = async (componentId, value) => {
  await waitFor(element(by.id(componentId)))
    .toHaveLabel(value)
    .withTimeout(DEFAULT_TIMEOUT);
};
export const shouldSeeWithDate = async (componentId, days) => {
  /** Check if 'days' is a number */
  if (!days || !TextValidator.isNumber(days)) return;

  /** Create new date based from current date + given days */
  const toDate = CURRENT_DATE.plus({days});
  const isWithinTheWeek = DateTime.isWithinTheWeek(new Date(toDate));
  const value = isWithinTheWeek ? toDate.toFormat("EEEE") : toDate.toFormat(`${DATE_MONTH_FORMAT}, yyyy`);

  await waitFor(element(by.id(componentId)))
    .toHaveText(value)
    .withTimeout(DEFAULT_TIMEOUT);
};
export const shouldSeeWithDateAndPrefix = async (componentId, days, prefix) => {
  /** Check if 'days' is a number */
  if (!days || !TextValidator.isNumber(days)) return;

  /** Create new date based from current date + given days with its prefix */
  const toDate = CURRENT_DATE.plus({days});
  const isWithinTheWeek = DateTime.isWithinTheWeek(new Date(toDate));
  const value = isWithinTheWeek ? toDate.toFormat("EEEE") : toDate.toFormat(`${DATE_MONTH_FORMAT}, yyyy`);

  await waitFor(element(by.id(componentId)))
    .toHaveText(`${prefix} ${value}`)
    .withTimeout(DEFAULT_TIMEOUT);
};

export const shouldSeeWithDateFromNowWithFormatAndPrefix = async (componentId, days, format, prefix) => {
  const toDate = CURRENT_DATE.plus({days});
  const value = toDate.toFormat(format);
  await waitFor(element(by.id(componentId)))
    .toHaveText(`${prefix} ${value}`)
    .withTimeout(DEFAULT_TIMEOUT);
};

export const shouldSeeWithValue = async (componentId, value) => {
  await waitFor(element(by.id(componentId)))
    .toHaveValue(value)
    .withTimeout(DEFAULT_TIMEOUT);
};
export const shouldSeeByText = async (value) => {
  await waitFor(element(by.text(value)))
    .toBeVisible()
    .withTimeout(DEFAULT_TIMEOUT);
};

export const shouldSeeAtLeastOneByText = async (value) => {
  await waitFor(element(by.text(value)).atIndex(0))
    .toBeVisible()
    .withTimeout(DEFAULT_TIMEOUT);
};

export const shouldSeeWithChild = async (parent, child) => {
  await waitFor(element(by.id(parent).withDescendant(by.id(child))))
    .toBeVisible()
    .withTimeout(DEFAULT_TIMEOUT);
};
export const shouldNotSeeWithChild = async (parent, child) => {
  await waitFor(element(by.id(parent).withDescendant(by.id(child))))
    .not.toBeVisible()
    .withTimeout(DEFAULT_TIMEOUT);
};

export const scrollToElement = async (
  screenId,
  componentId,
  direction,
  startNormalizedPositionX = NaN,
  startNormalizedPositionY = NaN,
  scrollPixel = 120,
) => {
  await waitFor(element(by.id(componentId)))
    .toBeVisible()
    .whileElement(by.id(screenId))
    .scroll(scrollPixel, direction, startNormalizedPositionX, startNormalizedPositionY);
};

export const scrollToElementText = async (screenId, text, direction, scrollPixel = 120) => {
  await waitFor(element(by.text(text)))
    .toBeVisible()
    .whileElement(by.id(screenId))
    .scroll(scrollPixel, direction);
};

export const swipeDown = async (scrollViewId) => {
  await waitElement(scrollViewId);
  try {
    await element(by.id(scrollViewId)).swipe("down", "slow");
  } catch (e) {
    console.warn("Cannot swipe down more.");
  }
};

export const scrollToPixel = async (scrollViewId, scrollPixel, edge) => {
  await waitElement(scrollViewId);
  try {
    await element(by.id(scrollViewId)).scroll(scrollPixel, edge);
  } catch (e) {
    console.warn("Cannot scroll down more. It might be the bottom of the screen.");
  }
};

export const scrollToEdge = async (scrollViewId, edge) => {
  await waitElement(scrollViewId);
  await element(by.id(scrollViewId)).scrollTo(edge);
};

export const typeText = async (value, componentId) => {
  await waitElement(componentId);
  await element(by.id(componentId)).typeText(value);
  await element(by.id(componentId)).tapReturnKey();
};

export const replaceText = async (value, componentId) => {
  await waitElement(componentId);
  await element(by.id(componentId)).replaceText(value);
};

export const tapById = async (componentId) => {
  await waitElement(componentId);
  await element(by.id(componentId)).tap();
};

export const tapByText = async (text) => {
  await waitElementByText(text);
  await element(by.text(text)).tap();
};

export const tapByLabel = async (label) => {
  // await waitElementByText(text);
  await element(by.label(label)).tap();
};

export const tapByTextOnIosAlertMessage = async (text) => {
  await waitElementByText(text);
  await element(by.label(text).and(by.type("_UIAlertControllerActionView"))).tap();
};

export const allowPermission = async (services) => {
  const serviceMap = mapPermissionServices(services, true);
  await device.launchApp({permissions: serviceMap});
};

export const denyPermission = async (services) => {
  const serviceMap = mapPermissionServices(services, false);
  await device.launchApp({permissions: serviceMap});
};

export const mapPermissionServices = (services, isAllow) => {
  const list = services.replace(/\s/g, "").toLowerCase().split(",");
  let serviceMap = {};
  for (const item of list) {
    serviceMap[item] = isAllow ? "YES" : "NO";
  }
  /**
   * Return sample:
   * {
   *    camera: "YES",
   *    notifications: "YES",
   *    photos: "YES",
   * }
   */
  return serviceMap;
};

export const setDeviceTimezone = async (timezone) => {
  if (device.getPlatform() === "android") {
    const adbName = device.deviceDriver.adbName;
    await device.deviceDriver.adb.adbCmd(adbName, `shell service call alarm 3 s16 ${timezone}`);
  } else {
    // todo: for iOS
  }
};

/**
 * Helper Functions
 */
const TextValidator = {
  isNumber: (text) => {
    return /^\d+$/.test(text);
  },
};
const DateTime = {
  isWithinTheWeek: (date) => {
    const oneWeek = 6048e5;
    const oneWeekFromNow = new Date(Date.now() + oneWeek);
    const dueDate = new Date(date);
    return dueDate < oneWeekFromNow;
  },
};
