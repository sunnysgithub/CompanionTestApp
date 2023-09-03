import SwiftUI
import WatchConnectivity
import AVFoundation

struct ContentView: View {
    @ObservedObject var phoneSessionManager = PhoneSessionManager()
    
    var body: some View {
        Text("Button is \(phoneSessionManager.buttonState)")
            .onAppear {
                if phoneSessionManager.buttonState == "Pressed" {
                    toggleFlashlight(on: true)
                } else {
                    toggleFlashlight(on: false)
                }
            }
            .onChange(of: phoneSessionManager.buttonState) { newValue in
                if newValue == "Pressed" {
                    toggleFlashlight(on: true)
                } else {
                    toggleFlashlight(on: false)
                }
            }
        
    }
    
    func toggleFlashlight(on: Bool) {
        guard let device = AVCaptureDevice.default(for: .video) else { return }
        if device.hasTorch {
            do {
                try device.lockForConfiguration()
                device.torchMode = on ? .on : .off
                device.unlockForConfiguration()
            } catch {
                print("Torch could not be used")
            }
        } else {
            print("Torch is not available")
        }
    }
}


