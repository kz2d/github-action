describe("Simple Test Case", () => {
  it("Should return 4", () => {
    if (Math.random() > 1) throw new Error("random");

    expect(2 + 2).toBe(4);
  });
});
