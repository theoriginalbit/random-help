import Foundation

// MARK: -  All it takes

infix operator ± : RangeFormationPrecedence

extension Int {
    static func ± (lhs: Int, rhs: UInt) -> ClosedRange<Int> {
        (lhs - Int(rhs)) ... (lhs + Int(rhs))
    }
}

// MARK: - Usage Example

struct GridCell: Equatable {
    var row: Int
    var column: Int

    func isAdjacent(to other: GridCell) -> Bool {
        guard self != other else { return false }
        let horizontal = row ± 1
        let vertical = column ± 1
        return horizontal ~= other.row && vertical ~= other.column
    }
}

// MARK: - Testing

import XCTest

class GridTests: XCTestCase {
    let grid: [[GridCell]] = [
        [ GridCell(row: 0, column: 0), GridCell(row: 0, column: 1), GridCell(row: 0, column: 2), GridCell(row: 0, column: 3), GridCell(row: 0, column: 4) ],
        [ GridCell(row: 1, column: 0), GridCell(row: 1, column: 1), GridCell(row: 1, column: 2), GridCell(row: 1, column: 3), GridCell(row: 1, column: 4) ],
        [ GridCell(row: 2, column: 0), GridCell(row: 2, column: 1), GridCell(row: 2, column: 2), GridCell(row: 2, column: 3), GridCell(row: 2, column: 4) ],
        [ GridCell(row: 3, column: 0), GridCell(row: 3, column: 1), GridCell(row: 3, column: 2), GridCell(row: 3, column: 3), GridCell(row: 3, column: 4) ],
        [ GridCell(row: 4, column: 0), GridCell(row: 4, column: 1), GridCell(row: 4, column: 2), GridCell(row: 4, column: 3), GridCell(row: 4, column: 4) ],
    ]
    
    func testSameElement() {
        XCTAssertFalse(grid[2][2].isAdjacent(to: grid[2][2]))
    }
    
    func testDirectlyAdjacent() {
        XCTAssertTrue(grid[2][2].isAdjacent(to: grid[2][1]))
        XCTAssertTrue(grid[2][2].isAdjacent(to: grid[2][3]))
        XCTAssertTrue(grid[2][2].isAdjacent(to: grid[1][2]))
        XCTAssertTrue(grid[2][2].isAdjacent(to: grid[3][2]))
    }
    
    func testDiagonallyAdjacent() {
        XCTAssertTrue(grid[2][2].isAdjacent(to: grid[1][1]))
        XCTAssertTrue(grid[2][2].isAdjacent(to: grid[3][3]))
        XCTAssertTrue(grid[2][2].isAdjacent(to: grid[1][3]))
        XCTAssertTrue(grid[2][2].isAdjacent(to: grid[3][1]))
    }
    
    func testNonAdjacent() {
        XCTAssertFalse(grid[2][2].isAdjacent(to: grid[0][0]))
        XCTAssertFalse(grid[2][2].isAdjacent(to: grid[0][1]))
        XCTAssertFalse(grid[2][2].isAdjacent(to: grid[0][2]))
        XCTAssertFalse(grid[2][2].isAdjacent(to: grid[0][3]))
        XCTAssertFalse(grid[2][2].isAdjacent(to: grid[0][4]))
        XCTAssertFalse(grid[2][2].isAdjacent(to: grid[1][4]))
        XCTAssertFalse(grid[2][2].isAdjacent(to: grid[2][4]))
        XCTAssertFalse(grid[2][2].isAdjacent(to: grid[3][4]))
        XCTAssertFalse(grid[2][2].isAdjacent(to: grid[4][0]))
        XCTAssertFalse(grid[2][2].isAdjacent(to: grid[4][1]))
        XCTAssertFalse(grid[2][2].isAdjacent(to: grid[4][2]))
        XCTAssertFalse(grid[2][2].isAdjacent(to: grid[4][3]))
        XCTAssertFalse(grid[2][2].isAdjacent(to: grid[4][4]))
        XCTAssertFalse(grid[2][2].isAdjacent(to: grid[1][0]))
        XCTAssertFalse(grid[2][2].isAdjacent(to: grid[2][0]))
        XCTAssertFalse(grid[2][2].isAdjacent(to: grid[3][0]))
    }
}

GridTests.defaultTestSuite.run()
