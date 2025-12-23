import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationStack {
                HomeView()
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }

            NavigationStack {
                RemindersView()
            }
            .tabItem {
                Label("Reminders", systemImage: "bell")
            }

            NavigationStack {
                ContactsView()
            }
            .tabItem {
                Label("Contacts", systemImage: "person.2.fill")
            }

            NavigationStack {
                MemoriesView()
            }
            .tabItem {
                Label("Memories", systemImage: "photo.on.rectangle")
            }
        }
    }
}

struct RemindersView: View {
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "bell.fill")
                .font(.system(size: 48))
                .foregroundStyle(.teal)
            Text("Reminders")
                .font(.title)
                .fontWeight(.semibold)
            Text("Keep track of important tasks and appointments.")
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
                .padding(.horizontal)
        }
        .padding()
    }
}

struct ContactsView: View {
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "person.2.crop.square.stack.fill")
                .font(.system(size: 48))
                .foregroundStyle(.indigo)
            Text("Contacts")
                .font(.title)
                .fontWeight(.semibold)
            Text("Quickly reach the people who matter most.")
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
                .padding(.horizontal)
        }
        .padding()
    }
}

struct MemoriesView: View {
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "sparkles.rectangle.stack.fill")
                .font(.system(size: 48))
                .foregroundStyle(.pink)
            Text("Memories")
                .font(.title)
                .fontWeight(.semibold)
            Text("Save and revisit cherished moments.")
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
                .padding(.horizontal)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
