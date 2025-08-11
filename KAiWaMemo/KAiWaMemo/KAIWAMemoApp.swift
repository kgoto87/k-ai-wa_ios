
import SwiftUI

@main
struct KAIWAMemoApp: App {
    init() {
        FirebaseManager.shared.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
