import { When } from 'cypress-cucumber-preprocessor/steps'

When('I put the value {string} in the field {string}', (value, elementId) => {
  // cy.get(field).clear().focus().type(value)
  cy.get(`[id=${elementId}]`).type(value)
})
