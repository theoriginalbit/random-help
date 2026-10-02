import Foundation

struct PlusMinusRange<T>: RangeExpression where T: BinaryInteger {
    typealias Bound = T
    
    let lowerBound: Bound
    let upperBound: Bound
    
    func relative<C>(to collection: C) -> Range<T> where C : Collection, Self.Bound == C.Index {
        fatalError("not implemented")
    }
    
    func contains(_ element: Bound) -> Bool {
        return element == lowerBound || element == upperBound
    }
}

infix operator ±

extension Int {
    static func ±(lhs: Int, rhs: UInt) -> PlusMinusRange<Int> {
        return PlusMinusRange(lowerBound: lhs - Int(rhs), upperBound: lhs + Int(rhs))
    }
}

struct View {
    var tag: Int
    
    func isAdjacent(to other: View) -> Bool {
        let horizontal = tag ± 1
        let vertical = tag ± 6
        return horizontal ~= other.tag || vertical ~= other.tag
    }
}

let a = View(tag: 2)
let b = View(tag: 1)
let c = View(tag: 8)
let d = View(tag: 10)


print(a.isAdjacent(to: b)) // expect true
print(a.isAdjacent(to: c)) // expect true
print(a.isAdjacent(to: d)) // expect false
print(c.isAdjacent(to: a)) // expect true
print(b.isAdjacent(to: d)) // expect false
