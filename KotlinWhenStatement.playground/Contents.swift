import Foundation

// MARK: - What makes it work

@resultBuilder
enum WhenBuilder {
    static func buildBlock<Input, Output>(_ expressions: WhenExpression<Input, Output>...) -> [WhenExpression<Input, Output>] {
        expressions
    }
}

struct WhenExpression<Input, Output> {
    let input: Input
    let output: () -> Output
}

@inline(__always) func when<Input, Output>(
    _ value: Input,
    @WhenBuilder _ expressionProvider: () -> [WhenExpression<Input, Output>]
) -> Output? where Input: Equatable {
    return expressionProvider().first {
        $0.input ~= value
    }?.output()
}

@inline(__always) func when<Input, Output>(
    _ value: Input,
    @WhenBuilder _ expressionProvider: () -> [WhenExpression<Input, Output>],
    else elseProvider: () -> Output
) -> Output where Input: Equatable {
    return expressionProvider().first {
        $0.input ~= value
    }?.output() ?? elseProvider()
}

@inline(__always) func when<Input, Output>(
    _ value: Input,
    @WhenBuilder _ expressionProvider: () -> [WhenExpression<Input, Output>],
    else elseProvider: @autoclosure () -> Output
) -> Output where Input: Equatable {
    return expressionProvider().first {
        $0.input ~= value
    }?.output() ?? elseProvider()
}

@inline(__always) func when<Output>(
    @WhenBuilder _ expressionProvider: () -> [WhenExpression<Bool, Output>]
) -> Output? {
    return expressionProvider().first {
        $0.input
    }?.output()
}

@inline(__always) func when<Output>(
    @WhenBuilder _ expressionProvider: () -> [WhenExpression<Bool, Output>],
    else elseProvider: () -> Output
) -> Output {
    return expressionProvider().first {
        $0.input
    }?.output() ?? elseProvider()
}

@inline(__always) func when<Output>(
    @WhenBuilder _ expressionProvider: () -> [WhenExpression<Bool, Output>],
    else elseProvider: @autoclosure () -> Output
) -> Output {
    return expressionProvider().first {
        $0.input
    }?.output() ?? elseProvider()
}

// MARK: - Convenience

infix operator => : AssignmentPrecedence

func => <Input, Output>(input: Input, output: @escaping @autoclosure () -> Output) -> WhenExpression<Input, Output> where Input: Equatable {
    WhenExpression(input: input, output: output)
}

// MARK: - Testing

let test1 = when("bye") {
    "hi" => "hello"
    "bye" => "goodbye"
}

debugPrint(test1 ?? "error")

let test2 = when("hey", {
    "hi" => "hello"
    "bye" => "goodbye"
}, else: "what did you say?")

debugPrint(test2)

let test3 = when("hey") {
    "hi" => "hello"
    "bye" => "goodbye"
} `else`: {
    "what did you say?"
}

debugPrint(test3)

let test4 = when {
    false => "hello"
    1 == 1 => "goodbye"
} `else`: {
    "what did you say?"
}

debugPrint(test4)
