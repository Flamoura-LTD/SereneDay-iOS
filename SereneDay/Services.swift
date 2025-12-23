import Foundation
import Combine

final class OrientationService {
    func currentOrientation() -> OrientationInfo {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .short

        return OrientationInfo(
            date: Date(),
            locationDescription: "Living room · Home",
            weatherDescription: "Calm skies with soft sunlight",
            temperature: "22°C comfortable"
        )
    }
}

final class ReminderStore: ObservableObject {
    @Published private(set) var reminders: [Reminder]
    private var cancellables = Set<AnyCancellable>()

    init(reminders: [Reminder] = ReminderStore.sampleData()) {
        self.reminders = reminders
    }

    func add(_ reminder: Reminder) {
        reminders.append(reminder)
    }

    func toggleCompletion(for reminderID: Reminder.ID) {
        reminders = reminders.map { item in
            guard item.id == reminderID else { return item }
            var updated = item
            updated.isCompleted.toggle()
            return updated
        }
    }

    func upcomingReminders(limit: Int) -> [Reminder] {
        reminders
            .filter { !$0.isCompleted }
            .sorted { $0.time < $1.time }
            .prefix(limit)
            .map { $0 }
    }

    private static func sampleData() -> [Reminder] {
        [
            Reminder(title: "Morning medication", time: Calendar.current.date(bySettingHour: 8, minute: 30, second: 0, of: Date()) ?? Date(), notes: "Take with water", category: .medication, isCompleted: false),
            Reminder(title: "Call Dr. Lee", time: Calendar.current.date(bySettingHour: 11, minute: 0, second: 0, of: Date()) ?? Date(), notes: "Ask about new prescription", category: .appointment, isCompleted: false),
            Reminder(title: "Stretch and hydrate", time: Calendar.current.date(bySettingHour: 15, minute: 0, second: 0, of: Date()) ?? Date(), notes: "Gentle chair stretches", category: .activity, isCompleted: true)
        ]
    }
}

final class ContactStore: ObservableObject {
    @Published private(set) var contacts: [SupportContact]

    init(contacts: [SupportContact] = ContactStore.sampleData()) {
        self.contacts = contacts
    }

    func favoriteContacts() -> [SupportContact] {
        contacts.filter { $0.isFavorite }
    }

    private static func sampleData() -> [SupportContact] {
        [
            SupportContact(name: "Avery Jones", relationship: "Daughter", phoneNumber: "(555) 123-0987", notes: "Usually available after 5pm", isFavorite: true),
            SupportContact(name: "Marcus Lee", relationship: "Care coordinator", phoneNumber: "(555) 555-3321", notes: "Check-in on Tuesdays", isFavorite: true),
            SupportContact(name: "Nina Patel", relationship: "Friend", phoneNumber: "(555) 889-2211", notes: "Loves reminiscing about music", isFavorite: false)
        ]
    }
}

final class MemoryStore: ObservableObject {
    @Published private(set) var entries: [MemoryEntry]

    init(entries: [MemoryEntry] = MemoryStore.sampleData()) {
        self.entries = entries
    }

    func add(_ entry: MemoryEntry) {
        entries.append(entry)
    }

    private static func sampleData() -> [MemoryEntry] {
        [
            MemoryEntry(title: "Wedding day", detail: "A sunny afternoon with soft music and family smiles.", date: Date().addingTimeInterval(-86_400 * 2_000), tags: ["Family", "Joy"]),
            MemoryEntry(title: "Seaside walk", detail: "Collecting shells and listening to the waves.", date: Date().addingTimeInterval(-86_400 * 400), tags: ["Calm", "Outdoors"]),
            MemoryEntry(title: "Grandchild's recital", detail: "Piano performance of Moonlight Sonata.", date: Date().addingTimeInterval(-86_400 * 60), tags: ["Music", "Family"])
        ]
    }
}

final class AssistantService: ObservableObject {
    @Published var messages: [AssistantMessage] = [
        AssistantMessage(isUser: false, content: "Hello! I am here to help with reminders, memories, and gentle guidance.", timestamp: Date())
    ]

    func send(userText: String) {
        let trimmed = userText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        let userMessage = AssistantMessage(isUser: true, content: trimmed, timestamp: Date())
        messages.append(userMessage)

        // Scaffold: integrate OpenAI chat completion here.
        let response = AssistantMessage(
            isUser: false,
            content: "I have noted that. Would you like me to set a reminder or message a contact?",
            timestamp: Date()
        )

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            self.messages.append(response)
        }
    }
}

final class FirebaseManager {
    func configure() {
        // Scaffold: initialize FirebaseApp.configure() when SDK is linked.
        print("Firebase configured (stub)")
    }
}
