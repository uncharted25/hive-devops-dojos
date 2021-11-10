/* eslint-disable no-return-assign */
/* eslint-disable no-useless-escape */
/* eslint-disable import/no-extraneous-dependencies */
const path = require('path')
const dayjs = require('dayjs')
const timezone = require('dayjs/plugin/timezone')
const utc = require('dayjs/plugin/utc')
const fs = require('fs-extra')
const report = require('multiple-cucumber-html-reporter')

dayjs.extend(utc)
dayjs.extend(timezone)

const cucumberJsonDir = path.resolve(process.cwd(), 'cypress/cucumber-json')
const cucumberReportFileMap = {}
const cucumberReportMap = {}
const jsonIndentLevel = 2
const htmlReportDir = path.resolve(process.cwd(), 'cypress/cucumber-json')
const screenshotsDir = path.resolve(process.cwd(), 'cypress/screenshots')

const version = process.env.VERSION || 'latest'

function getCucumberReportMaps() {
  // const filenames = fs.readdirSync(cucumberJsonDir)
  const files = fs.readdirSync(cucumberJsonDir).filter((file) => file.indexOf('.json') > -1)
  files.forEach((file) => {
    const json = JSON.parse(fs.readFileSync(path.join(cucumberJsonDir, file)))
    if (!json[0]) {
      return
    }
    const [feature] = json[0].uri.split('/').reverse()
    cucumberReportFileMap[feature] = file
    cucumberReportMap[feature] = json

    let accumulatedDuration = 0
    const startTime = dayjs(cucumberReportMap[feature][0].start)
    cucumberReportMap[feature][0].elements.forEach((scenario) => {
      const testedSteps = scenario.steps.filter(({ result }) => result.duration !== undefined)
      if (testedSteps.length > 0) {
        const scenarioStart = startTime.add(accumulatedDuration, 'ms')
        // eslint-disable-next-line no-param-reassign
        accumulatedDuration = testedSteps.map(((step) => step.result.duration)).reduce((accumulator, current) => accumulator += current, 0) / 1000000
        // add in tags
        scenario.tags.push({ name: `@startTime: ${scenarioStart.utcOffset(7).format('HH:mm:ss')}` })
      }
    })
    // Write JSON with time back to report file.
    fs.writeFileSync(
      path.join(cucumberJsonDir, cucumberReportFileMap[feature]),
      JSON.stringify(cucumberReportMap[feature], null, jsonIndentLevel)
    )
  })
}

function addScreenshots() {
  if (fs.existsSync(screenshotsDir)) {
    // only if screenshots exists
    const prependPathSegment = (pathSegment) => (location) =>
      path.join(pathSegment, location)

    const readdirPreserveRelativePath = (location) =>
      fs.readdirSync(location).map(prependPathSegment(location))

    const readdirRecursive = (location) =>
      readdirPreserveRelativePath(location).reduce(
        (result, currentValue) =>
          (fs.statSync(currentValue).isDirectory()
            ? result.concat(readdirRecursive(currentValue))
            : result.concat(currentValue)),
        []
      )

    const screenshots = readdirRecursive(path.resolve(screenshotsDir)).filter(
      (file) => file.indexOf('.png') > -1
    )

    const featuresList = Array.from(
      new Set(screenshots.map((x) => x.match(/[\w-_.]+.feature/g)[0]))
    )

    featuresList.forEach((feature) => {
      screenshots.forEach((screenshot) => {
        // const regex = /(?<=--\ ).+?((?=\ (example\ #\d+))|(?=\ (failed))|(?=.\w{3}))/g
        // const [scenarioName] = screenshot.match(regex)

        const filename = screenshot.replace(/^.*[\\\/]/, '')

        const featureSelected = cucumberReportMap[feature][0]

        const myScenarios = []

        cucumberReportMap[feature][0].elements.forEach((item) => {
          const fullFileName = featureSelected.name + ' -- ' + item.name
          if (filename.includes(fullFileName)) {
            myScenarios.push(item)
          }
        })

        if (!myScenarios) {
          return
        }
        let foundFailedStep = false
        myScenarios.forEach((myScenario) => {
          if (foundFailedStep) {
            return
          }
          let myStep
          if (screenshot.includes('(failed)')) {
            myStep = myScenario.steps.find(
              (step) => step.result.status === 'failed'
            )
          } else {
            myStep = myScenario.steps.find(
              (step) => step.result.status === 'passed'
            )
          }
          if (!myStep) {
            return
          }
          const data = fs.readFileSync(path.resolve(screenshot))
          if (data) {
            const base64Image = Buffer.from(data, 'binary').toString('base64')
            if (!myStep.embeddings) {
              myStep.embeddings = []
              myStep.embeddings.push({
                data: base64Image,
                mime_type: 'image/png',
                name: myStep.name,
              })
              foundFailedStep = true
            }
          }
        })
        // Write JSON with screenshot back to report file.
        fs.writeFileSync(
          path.join(cucumberJsonDir, cucumberReportFileMap[feature]),
          JSON.stringify(cucumberReportMap[feature], null, jsonIndentLevel)
        )
      })
    })
  }
}

function generateReport() {
  if (!fs.existsSync(cucumberJsonDir)) {
    // eslint-disable-next-line no-console
    console.warn('REPORT CANNOT BE CREATED!')
  } else {
    report.generate({
      jsonDir: cucumberJsonDir,
      reportPath: htmlReportDir,
      displayDuration: true,
      useCDN: true,
      pageTitle: 'MyAccount',
      reportName: `MyAccount - ${new Date().toLocaleString({ timeZone: 'Asia/Bangkok' })}`,
      metadata: {
        app: {
          name: 'MyAccount Webview',
          version,
        },
        browser: {
          name: 'chrome',
          version: '91',
        },
        device: 'Local test machine',
        platform: { name: 'linux' },
      },
      customData: {
        title: 'Run info',
        data: [
          { label: 'Project', value: 'MyAccount Webview' },
          { label: 'Environment', value: 'Alpha' },
          { label: 'Release', value: version },
          {
            label: 'Execution Start Time',
            value: `${new Date().toLocaleString({ timeZone: 'Asia/Bangkok' })}`,
          },
          {
            label: 'Execution End Time',
            value: `${new Date().toLocaleString({ timeZone: 'Asia/Bangkok' })}`,
          },
        ],
      },
    })
  }
}

getCucumberReportMaps()
addScreenshots()
generateReport()
