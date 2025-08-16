import SwiftUI

@main
struct KAIWAMemoApp: App {
    @StateObject private var authViewModel = AuthenticationViewModel()

    init() {
        FirebaseManager.shared.configure()
    }

    var body: some Scene {
        WindowGroup {
            if authViewModel.isAuthenticated {
                ContentView()
                    .environmentObject(authViewModel)
            } else {
                LoginView()
                    .environmentObject(authViewModel)
            }
        }
    }
}
