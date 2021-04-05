//
//  ContentView.swift
//  InfoPlistTranslations
//
//  Created by Joshua Asbury on 5/4/21.
//

import AVFoundation
import SwiftUI

struct ContentView: View {
    var body: some View {
        Button("Request camera permission") {
            AVCaptureDevice.requestAccess(for: .video) { _ in }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
