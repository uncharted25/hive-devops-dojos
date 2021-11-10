import { Then } from 'cypress-cucumber-preprocessor/steps'

Then('I put the value {string} in the field {string}', (value, field) => {
  cy.get(field).clear().focus().type(value)
})
