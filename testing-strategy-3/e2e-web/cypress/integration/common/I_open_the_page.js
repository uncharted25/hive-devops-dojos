import { When } from 'cypress-cucumber-preprocessor/steps'

/** ****************************************
** Use this method for TDG website only
** Do not send the token to external website
****************************************** */

When('I open the {string} page', (pageName) => {
  cy.visit(pageName)
})
