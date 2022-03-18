import { When } from "cypress-cucumber-preprocessor/steps";

When('I click on {string}', (elementId) => {
  cy.get(`[id=${elementId}]`).click()
})
