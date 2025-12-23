import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }

            ReminderListView()
                .tabItem {
                    Label("Reminders", systemImage: "checklist")
                }

            NoteListView()
                .tabItem {
                    Label("Notes", systemImage: "note.text")
                }

            ContactListView()
                .tabItem {
                    Label("Contacts", systemImage: "person.2.fill")
                }
        }
    }
}

private struct ReminderListView: View {
    var body: some View {
        NavigationStack {
            List {
                Text("No reminders yet")
                    .foregroundStyle(.secondary)
            }
            .navigationTitle("Reminders")
        }
    }
}

private struct NoteListView: View {
    var body: some View {
        NavigationStack {
            List {
                Text("No notes yet")
                    .foregroundStyle(.secondary)
            }
            .navigationTitle("Notes")
        }
    }
}

private struct ContactListView: View {
    var body: some View {
        NavigationStack {
            List {
                Text("No contacts yet")
                    .foregroundStyle(.secondary)
            }
            .navigationTitle("Contacts")
        }
    }
}

#Preview {
    ContentView()
}
