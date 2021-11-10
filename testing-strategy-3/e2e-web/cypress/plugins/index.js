/* eslint-disable no-undef */
/* eslint-disable no-return-assign */
/* eslint-disable import/no-extraneous-dependencies */
const path = require('path')
const cucumber = require('cypress-cucumber-preprocessor').default
const fs = require('fs-extra')

const cucumberJsonDir = path.resolve(process.cwd(), 'cypress/cucumber-json')

module.exports = (on) => {
  on('file:preprocessor', cucumber())
  on('task', {
    setToken: (val) => (token = val),
    getToken: () => token,
    setLanguage: (val) => language = val,
    getLanguage: () => language,
    setUsername: (val) => (username = val),
    getUsername: () => username,
  })
  on('after:spec', (spec, results) => {
    const file = fs.readdirSync(cucumberJsonDir).find((f) => f.indexOf(path.parse(spec.name).name) > -1)
    const feature = JSON.parse(fs.readFileSync(path.join(cucumberJsonDir, file)))
    feature[0].start = results.stats.wallClockStartedAt
    feature[0].end = results.stats.wallClockEndedAt
    fs.writeFileSync(path.join(cucumberJsonDir, file), JSON.stringify(feature, null, 2))
  })
}
