import Foundation

struct OrientationInfo {
    var date: Date
    var locationDescription: String
    var weatherDescription: String
    var temperature: String
}

struct Reminder: Identifiable, Hashable {
    let id = UUID()
    var title: String
    var time: Date
    var notes: String
    var category: Category
    var isCompleted: Bool

    enum Category: String, CaseIterable, Identifiable {
        case medication = "Medication"
        case activity = "Activity"
        case appointment = "Appointment"
        case hydration = "Hydration"

        var id: String { rawValue }

        var systemImage: String {
            switch self {
            case .medication: return "pills.fill"
            case .activity: return "figure.walk"
            case .appointment: return "calendar"
            case .hydration: return "drop.fill"
            }
        }
    }
}

struct SupportContact: Identifiable, Hashable {
    let id = UUID()
    var name: String
    var relationship: String
    var phoneNumber: String
    var notes: String
    var isFavorite: Bool
}

struct MemoryEntry: Identifiable, Hashable {
    let id = UUID()
    var title: String
    var detail: String
    var date: Date
    var tags: [String]
}

struct AssistantMessage: Identifiable, Hashable {
    let id = UUID()
    var isUser: Bool
    var content: String
    var timestamp: Date
}
