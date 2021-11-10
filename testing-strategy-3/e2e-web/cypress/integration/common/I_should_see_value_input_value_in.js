import { Then } from 'cypress-cucumber-preprocessor/steps'

// unclear implementation

Then('I should see the value {string} in {string} field', (text, id) => {
  cy.get(id)
    .should('be.visible')
    .should('contain.value', text)
})
