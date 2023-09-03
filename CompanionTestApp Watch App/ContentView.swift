import SwiftUI
import WatchConnectivity

struct ContentView: View {
    
    let watchSessionManager = WatchSessionManager()
    
    var body: some View {
        Button("Press Me") {}
            .padding(.all, 0.0)
            .onAppear {
                if WCSession.isSupported() {
                    WCSession.default.delegate = watchSessionManager
                    WCSession.default.activate()
                }
            }
            .onLongPressGesture(minimumDuration: 0.0, pressing: { isPressing in
                if WCSession.default.isReachable {
                    if isPressing {
                        WCSession.default.sendMessage(["buttonState": "Pressed"], replyHandler: nil, errorHandler: nil)
                        // sende Nachricht an die Uhr, dass der Button gedrückt wurde
                    } else {
                        WCSession.default.sendMessage(["buttonState": "Not Pressed"], replyHandler: nil, errorHandler: nil)
                        // sende Nachricht an die Uhr, dass der Button losgelassen wurde
                    }
                    
                }
                
            }) {}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
