import SwiftUI

@main
struct SereneDayApp: App {
    @StateObject private var reminderStore = ReminderStore()
    @StateObject private var contactStore = ContactStore()
    @StateObject private var memoryStore = MemoryStore()
    @StateObject private var assistantService = AssistantService()
    private let firebaseManager = FirebaseManager()

    init() {
        firebaseManager.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(reminderStore)
                .environmentObject(contactStore)
                .environmentObject(memoryStore)
                .environmentObject(assistantService)
        }
    }
}
