//
//  ContentView.swift
//  ModifierBug
//
//  Created by Josh Asbury on 7/8/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .doSomethingIf(true)
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

/// Removing `where Self == Text` will fix the issue
public extension View where Self == Text {
    @ViewBuilder func doSomethingIf(_ condition: Bool) -> some View {
        if condition {
            self.foregroundColor(.blue)
        }
        self
    }
}
