import { Before, After, Status } from '@cucumber/cucumber'
import wd from 'wd'
import dotenv from 'dotenv'
import { reverseTodayCharging } from './helpers'
dotenv.config()

Before(function (scenario) {
  console.log('\n', scenario.pickle.name)
})

Before('@skip', function (scenario) {
  console.log('Scenario skkiped due to @skip annotation')
  return 'skipped'
})

Before('not @CustomBrowser and not @mobile', function (scenario) {
  this.buildDriver()
})

After({ tags: '@dcb', timeout: 600000 }, async function(scenario) {
  if (scenario.result.status === Status.SKIPPED) {
    console.log("Do not reverse when the test is fully skipped");
  } else {
    await reverseTodayCharging('dcb')
  }
})

After({ tags: '@tol', timeout: 600000 }, async function(scenario) {
  if (scenario.result.status === Status.SKIPPED) {
    console.log("Do not reverse when the test is fully skipped");
  } else {
    await reverseTodayCharging('trueonline')
  }
})

After('not @mobile', async function (scenario) {
  if (!this.driver) return
  if (scenario.result.status === Status.FAILED) {
    const image = await this.driver.takeScreenshot()
    this.attach(image, 'image/png')
  }
  try {
    await this.driver.quit()
  } catch (error) {
    console.log('[ERROR] After hook failed on driver.quit()', error.message)
  }
  return
})
