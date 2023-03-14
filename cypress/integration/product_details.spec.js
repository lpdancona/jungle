describe("Product details", () => {
  it("Visits the home page", () => {
    // visit the app's home page
    cy.visit("/");
  });

  it("There are 2 products on the page", () => {
    // assert that there are 2 products displayed on the home page
    cy.get(".products article").should("have.length", 2);
  });

  it("Can navigate to the product detail page by clicking on a product", () => {
    // click on the first product link
    cy.get(".products article:first-of-type a").click();

    // assert that the URL has changed to the product detail page
    cy.url().should("include", "/products/");

    // assert that the page displays the expected product name and price
    cy.get(":nth-child(2) > h1").should("contain", "Scented Blade");
  });
});
