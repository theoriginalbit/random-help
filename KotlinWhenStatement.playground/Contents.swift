import Foundation

@resultBuilder
enum WhenBuilder {
    static func buildBlock<Input, Output>(
        _ expressions: WhenExpression<Input, Output>...
    ) -> [WhenExpression<Input, Output>] {
        expressions
    }
}

struct WhenExpression<Input, Output> {
    let input: Input
    let output: Output
}

func when<Input, Output>(_ value: Input, @WhenBuilder _ expressionProvider: () -> [WhenExpression<Input, Output>]) -> Output? where Input: Equatable {
    expressionProvider().first { expression in
        expression.input ~= value
    }?.output
}

infix operator =>

func => <Input, Output>(input: Input, output: Output) -> WhenExpression<Input, Output> where Input: Equatable {
    WhenExpression(input: input, output: output)
}

let text1 = when("hi") {
    WhenExpression(input: "hi", output: "hello")
    WhenExpression(input: "bye", output: "goodbye")
}

debugPrint(text1 ?? "error")

let text2 = when("bye") {
    WhenExpression(input: "hi", output: "hello")
    WhenExpression(input: "bye", output: "goodbye")
}

debugPrint(text2 ?? "error")

let text3 = when("bye") {
    "hi" => "hello"
    "bye" => "goodbye"
}

debugPrint(text3 ?? "error")
