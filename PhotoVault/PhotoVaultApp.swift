import SwiftUI

/// Entry point for the Photo Vault experience.
///
/// The app boots directly into the vault, where sediment layers, trenches,
/// fossils, and weekly landslide reports are coordinated by `VaultViewModel`.
@main
struct PhotoVaultApp: App {
    /// Top-level observable state for the vault.
    ///
    /// This owns the sediment layers, active trench state, recovered fossils,
    /// and navigation between the vault map, trench excavation, fossil detail,
    /// and weekly report screens.
    @StateObject private var vaultViewModel = VaultViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(vaultViewModel)
                .preferredColorScheme(.dark)
                .accentColor(Color(red: 0.55, green: 0.42, blue: 0.30))
        }
    }
}