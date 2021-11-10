import { Then } from 'cypress-cucumber-preprocessor/steps'

Then('I click {string}', (id) => {
  cy.get(id).then(($el) => {
    if (!Cypress.dom.isVisible($el)) {
      cy.get(id).scrollIntoView().click({ force: true })
    } else {
      cy.get(id).scrollIntoView().click()
    }
  })
})
