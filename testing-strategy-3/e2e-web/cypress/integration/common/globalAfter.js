const { After } = require('cypress-cucumber-preprocessor/steps')

After({ tags: '@tol' }, () => {
  cy.reverseTodayCharging('trueonline')
})
