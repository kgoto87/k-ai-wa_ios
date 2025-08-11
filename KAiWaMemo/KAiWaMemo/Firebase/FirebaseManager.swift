
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class FirebaseManager {
    static let shared = FirebaseManager()

    private init() {}

    func configure() {
        FirebaseApp.configure()

        #if DEBUG
        print("Running in DEBUG mode. Using Firebase Emulator.")
        let settings = Firestore.firestore().settings
        settings.host = "localhost:8080"
        settings.isSSLEnabled = false
        Firestore.firestore().settings = settings

        Auth.auth().useEmulator(withHost: "localhost", port: 9099)
        #else
        print("Running in RELEASE mode. Using production Firebase.")
        #endif
    }
}
