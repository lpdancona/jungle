describe("Add to cart", () => {
  it("Visits the home page", () => {
    // visit the app's home page
    cy.visit("/");
  });

  it("There is 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });

  it("containd a cart", () => {
    cy.get(".nav-item.end-0").should("contain", "My Cart (0)");
  });
  it("Adds a product to the cart and increases the cart size by 1", () => {
    // click the "Add to Cart" button for the first product
    cy.get(":nth-child(1) > div > .button_to > .btn").click({ force: true });
    // assert that the cart size has increased by 1
    cy.get(".nav-item.end-0").should("contain", "My Cart (1)");
  });
});
