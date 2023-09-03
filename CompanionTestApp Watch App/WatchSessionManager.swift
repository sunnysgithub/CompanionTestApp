import Foundation
import WatchConnectivity

class WatchSessionManager: NSObject, WCSessionDelegate {
    
    override init() {
        super.init()
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
            // Your activation logic here
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
                print("WCSession activation failed with error: \(error.localizedDescription)")
            }
        }

    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
            if let receivedState = message["buttonState"] as? String {
                // Update your UI or perform other actions
                print("Received button state: \(receivedState)")
            }
        }

}
