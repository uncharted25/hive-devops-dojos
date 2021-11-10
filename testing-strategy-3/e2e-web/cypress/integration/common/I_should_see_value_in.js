import { Then } from 'cypress-cucumber-preprocessor/steps'

Then('I should see the value {string} in {string}', (text, id) => {
  cy.get(id).should('be.visible').should('contain', text)
})
