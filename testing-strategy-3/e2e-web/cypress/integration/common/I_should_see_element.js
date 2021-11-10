import { Then } from 'cypress-cucumber-preprocessor/steps'

Then('I should see element {string}', (id) => {
  cy.get(id).scrollIntoView().should('not.have.css', 'display', 'none')
  // Remove .should('be.visible')
  // due to not able to consider modal as being visibled when modal container is higher than screen
})

Then('I should see element starts with {string}', (id) => {
  cy.get(`[id^=${id}]`).scrollIntoView().should('not.have.css', 'display', 'none')
  // Remove .should('be.visible')
  // due to not able to consider modal as being visibled when modal container is higher than screen
})

Then('I should see {string} with text {string}', (id, text) => {
  cy.get(id).scrollIntoView().should('be.visible').should('contain', text)
})
