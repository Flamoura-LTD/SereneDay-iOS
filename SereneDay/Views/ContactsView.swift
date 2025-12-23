import SwiftUI

struct ContactsView: View {
    @EnvironmentObject private var contactStore: ContactStore
    @State private var searchText = ""

    private var filteredContacts: [SupportContact] {
        if searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return contactStore.contacts
        }
        return contactStore.contacts.filter { contact in
            contact.name.localizedCaseInsensitiveContains(searchText) ||
            contact.relationship.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {
        NavigationStack {
            List(filteredContacts) { contact in
                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Text(contact.name)
                            .font(.headline)
                        if contact.isFavorite {
                            Image(systemName: "heart.fill")
                                .foregroundStyle(.red)
                        }
                        Spacer()
                        Text(contact.relationship)
                            .foregroundStyle(.secondary)
                            .font(.subheadline)
                    }
                    HStack(spacing: 12) {
                        Label(contact.phoneNumber, systemImage: "phone.fill")
                            .foregroundStyle(.secondary)
                        Text(contact.notes)
                            .foregroundStyle(.secondary)
                    }
                    HStack(spacing: 12) {
                        Button(action: {}) {
                            Label("Call", systemImage: "phone.arrow.up.right")
                        }
                        .buttonStyle(.bordered)

                        Button(action: {}) {
                            Label("Message", systemImage: "text.bubble.fill")
                        }
                        .buttonStyle(.bordered)
                    }
                }
                .padding(.vertical, 8)
            }
            .navigationTitle("Contacts")
            .searchable(text: $searchText, placement: .automatic)
        }
    }
}

struct ContactsView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsView()
            .environmentObject(ContactStore())
    }
}
