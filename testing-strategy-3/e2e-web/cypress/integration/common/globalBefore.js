beforeEach(() => {
  cy.log(
    'This will run once before all tests, you can use this to for example start up your server, if that\'s your thing'
  )
  cy.window().then((window) => {
    window.sessionStorage.clear()
    window.localStorage.clear()
  })
  cy.clearCookies()
  cy.clearCookies({ domain: null })
  cy.getCookies().then((cookies) => {
    if (cookies.lenght > 0) {
      expect(cookies[0]).to.not.have.property('token')
      cy.log('[INFO] Cookies [token] is cleared')
    } else {
      cy.log('[INFO] Cookies is cleared')
    }
  })
  cy.task('setToken', null)
  cy.task('setLanguage', null)
  cy.task('setUsername', null)
})

Cypress.on('uncaught:exception', () =>
  /* returning false here prevents Cypress from failing the test */
  false)
