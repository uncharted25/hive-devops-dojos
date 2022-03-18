import { Then } from 'cypress-cucumber-preprocessor/steps'

Then('I should see text {string}', (text) => {
  cy.contains(text)
})
