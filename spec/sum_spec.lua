local sum = require("sum")

describe("Sum test suite", function()

    it("should add correctly", function()
        assert.are.equal(5, sum.add(3,2))
        assert.are.equal(-5, sum.add(0,-5))
    end)

    it("should default to 0 for second parameter", function ()
        assert.are.equal(5, sum.add(5))
    end)

end)