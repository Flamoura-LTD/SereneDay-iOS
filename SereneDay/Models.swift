import Foundation

struct Reminder: Identifiable, Hashable {
    let id: UUID
    var title: String
    var isCompleted: Bool
    var dueDate: Date?

    init(id: UUID = UUID(), title: String, isCompleted: Bool = false, dueDate: Date? = nil) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
        self.dueDate = dueDate
    }
}

struct Contact: Identifiable, Hashable {
    let id: UUID
    var name: String
    var phoneNumber: String?
    var email: String?

    init(id: UUID = UUID(), name: String, phoneNumber: String? = nil, email: String? = nil) {
        self.id = id
        self.name = name
        self.phoneNumber = phoneNumber
        self.email = email
    }
}

struct Note: Identifiable, Hashable {
    let id: UUID
    var title: String
    var body: String
    var createdAt: Date

    init(id: UUID = UUID(), title: String, body: String, createdAt: Date = .now) {
        self.id = id
        self.title = title
        self.body = body
        self.createdAt = createdAt
    }
}
