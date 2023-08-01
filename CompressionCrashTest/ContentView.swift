//
//  ContentView.swift
//  CompressionCrashTest
//
//  Created by Morten Just on 8/1/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var tester = TestClass()
    
    var body: some View {
        VStack {
            if tester.done {
                Text("If you see this it did not crash")
            } else {
                Text("Trying...")
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

import AVFoundation

class TestClass: ObservableObject {
    @Published var done = false
    init() {
        Task.detached {
            
            let videoWriter = AVAssetWriterInput(
                mediaType: .video,
                outputSettings:
                    [
                        AVVideoWidthKey: 1000,
//                        AVVideoHeightKey: 1000,
                        AVVideoCodecKey: AVVideoCodecType.h264,
                        AVVideoCompressionPropertiesKey: [
                            AVVideoQualityKey: 0.4
                        ]
                    ]
            )
            
            

            print(videoWriter)
            
            let abba = AVOutputSettingsAssistant(preset: .preset1920x1080)
            print(abba?.videoSettings)
            
            
            await MainActor.run {
                self.done = true
            }
        }
       
        
        
    }
}
