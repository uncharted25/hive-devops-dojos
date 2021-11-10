import { Then } from 'cypress-cucumber-preprocessor/steps'

Then('I should not see element {string}', (id) => {
  cy.get(id).should('not.exist')
})
