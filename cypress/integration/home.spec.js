describe("Jungle App", () => {
  it("Visits the home page", () => {
    // visit the app's home page
    cy.visit("/");
  });

  it("There is 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });
});
