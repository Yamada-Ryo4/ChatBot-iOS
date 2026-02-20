import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ChatViewModel
    @Environment(\.horizontalSizeClass) var sizeClass

    var body: some View {
        if sizeClass == .compact {
            // iPhone: NavigationStack using navigationPath for programmatic control
            iPhoneLayout
        } else {
            // iPad: NavigationSplitView
            iPadLayout
        }
    }

    // MARK: - iPhone Layout
    var iPhoneLayout: some View {
        SideMenuContainer(isSidebarVisible: $viewModel.isSidebarVisible) {
            NavigationStack {
                ChatView()
            }
        } sidebarContent: {
            SidebarView(viewModel: viewModel)
        }
    }

    // MARK: - iPad Layout
    var iPadLayout: some View {
        NavigationSplitView {
            SessionListView(viewModel: viewModel)
        } detail: {
            if let sessionId = viewModel.currentSessionId,
               viewModel.sessions.contains(where: { $0.id == sessionId }) {
                NavigationStack {
                    ChatView()
                        .id(sessionId)
                }
            } else {
                WelcomePlaceholder()
            }
        }
    }
}

// MARK: - Session List (shared between iPhone & iPad)
struct SessionListView: View {
    @ObservedObject var viewModel: ChatViewModel
    @Environment(\.horizontalSizeClass) var sizeClass

    var body: some View {
        List {
            Section {
                Button(action: { viewModel.createNewSession() }) {
                    Label("新建对话", systemImage: "square.and.pencil")
                        .foregroundColor(.blue)
                }
            }

            Section("历史记录") {
                ForEach(viewModel.sessions) { session in
                    if sizeClass == .compact {
                        // iPhone: Use NavigationLink(value:) for NavigationStack path support
                        // This fixes "double click" issues and allows programmatic navigation
                        NavigationLink(value: session.id) {
                            SessionRow(session: session)
                        }
                    } else {
                        // iPad: Use Button to update selection state for NavigationSplitView
                        Button {
                            viewModel.currentSessionId = session.id
                        } label: {
                            SessionRow(session: session)
                                .contentShape(Rectangle()) // Standardize tap area
                        }
                        .buttonStyle(.plain) // Standard list row appearance
                        .listRowBackground(viewModel.currentSessionId == session.id ? Color.gray.opacity(0.2) : nil)
                    }
                }
                .onDelete { indexSet in
                    viewModel.deleteSession(at: indexSet)
                }
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle("ChatBot")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: SettingsView(viewModel: viewModel)) {
                    Image(systemName: "gear")
                }
            }
            ToolbarItem(placement: .navigationBarLeading) {
                EditButton()
            }
        }
        // No redundant onAppear logic needed here as ViewModel handles initialization
    }
}

// MARK: - Session Row
struct SessionRow: View {
    let session: ChatSession

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(session.title)
                .font(.headline)
                .lineLimit(1)
            HStack {
                Text(session.lastModified, style: .relative)
                    .font(.caption)
                    .foregroundColor(.secondary)
                Spacer()
                Text("\(session.messages.filter { $0.role != .system }.count) 条消息")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 2)
    }
}

// MARK: - Welcome Placeholder (iPad only)
struct WelcomePlaceholder: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "bubble.left.and.text.bubble.right.fill")
                .font(.system(size: 64))
                .foregroundStyle(LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
            Text("选择或新建一个对话")
                .font(.title2)
                .foregroundColor(.secondary)
        }
    }
}
