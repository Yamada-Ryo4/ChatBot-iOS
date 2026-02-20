import SwiftUI

@main
struct ChatBotApp: App {
    @StateObject private var viewModel = ChatViewModel()
    @Environment(\.scenePhase) private var scenePhase

    var preferredScheme: ColorScheme? {
        switch viewModel.preferredColorSchemeRaw {
        case "light": return .light
        case "dark":  return .dark
        default:      return nil  // system default
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
                .environmentObject(viewModel)
                .preferredColorScheme(preferredScheme)
                .onChange(of: scenePhase) { _, newPhase in
                    switch newPhase {
                    case .active:
                        print("App is active")
                    case .background:
                        print("App is in background")
                        Task {
                            // await viewModel.saveState()
                        }
                    case .inactive:
                        print("App is inactive")
                    @unknown default:
                        break
                    }
                }
        }
    }
}
