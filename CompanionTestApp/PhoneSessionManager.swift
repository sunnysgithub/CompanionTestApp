import SwiftUI
import WatchConnectivity

class PhoneSessionManager: NSObject, ObservableObject, WCSessionDelegate {
    @Published var buttonState: String = "Not Pressed"
        
    override init() {
        super.init()
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
    }
    
    // Diese Methode ist erforderlich, um das WCSessionDelegate-Protokoll zu erfüllen
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        switch activationState {
        case .activated:
            print("WCSession is activated.")
        case .inactive:
            print("WCSession is inactive.")
        case .notActivated:
            print("WCSession could not be activated.")
        @unknown default:
            print("Unknown WCSession activation state.")
        }
        
        if let error = error {
            print("WCSession activation completed with an error: \(error.localizedDescription)")
        }
    }
    
    // Diese Methoden sind auch erforderlich für iOS
    func sessionDidBecomeInactive(_ session: WCSession) {
        // Code für die Behandlung der Inaktivität der Session
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        // Code für die Behandlung der Deaktivierung der Session
        WCSession.default.activate()  // Aktiviert die Session erneut
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        DispatchQueue.main.async {
            if let state = message["buttonState"] as? String {
                self.buttonState = state
            }
        }
    }
}
