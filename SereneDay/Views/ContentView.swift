import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    private let orientationService = OrientationService()

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeDashboardView(orientationInfo: orientationService.currentOrientation())
                .tabItem {
                    Label("Home", systemImage: "sun.max.fill")
                }
                .tag(0)

            RemindersView()
                .tabItem {
                    Label("Reminders", systemImage: "bell.badge.fill")
                }
                .tag(1)

            ContactsView()
                .tabItem {
                    Label("Contacts", systemImage: "person.2.fill")
                }
                .tag(2)

            MemoriesView()
                .tabItem {
                    Label("Memories", systemImage: "book.pages.fill")
                }
                .tag(3)

            AssistantView()
                .tabItem {
                    Label("Assistant", systemImage: "sparkles")
                }
                .tag(4)
        }
        .accentColor(Color.teal)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let reminderStore = ReminderStore()
        let contactStore = ContactStore()
        let memoryStore = MemoryStore()
        let assistantService = AssistantService()

        ContentView()
            .environmentObject(reminderStore)
            .environmentObject(contactStore)
            .environmentObject(memoryStore)
            .environmentObject(assistantService)
    }
}
