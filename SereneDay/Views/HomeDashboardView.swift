import SwiftUI

struct HomeDashboardView: View {
    @EnvironmentObject private var reminderStore: ReminderStore
    @EnvironmentObject private var contactStore: ContactStore
    let orientationInfo: OrientationInfo

    private var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter
    }

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d"
        return formatter
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    orientationCard
                    reminderHighlights
                    favoriteContacts
                }
                .padding()
            }
            .navigationTitle("SereneDay")
            .navigationBarTitleDisplayMode(.large)
        }
    }

    private var orientationCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(dateFormatter.string(from: orientationInfo.date))
                .font(.title.bold())
            Text("It's " + timeFormatter.string(from: orientationInfo.date))
                .font(.title3)
                .foregroundStyle(.secondary)

            Divider().padding(.vertical, 4)

            Label(orientationInfo.locationDescription, systemImage: "house.fill")
                .foregroundStyle(.primary)
            Label("Weather: " + orientationInfo.weatherDescription, systemImage: "cloud.sun.fill")
                .foregroundStyle(.primary)
            Label("Temperature: " + orientationInfo.temperature, systemImage: "thermometer")
                .foregroundStyle(.primary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.ultraThickMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 4)
    }

    private var reminderHighlights: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Label("Today's focus", systemImage: "sparkles")
                    .font(.headline)
                Spacer()
            }

            ForEach(reminderStore.upcomingReminders(limit: 3)) { reminder in
                ReminderRow(reminder: reminder) {
                    reminderStore.toggleCompletion(for: reminder.id)
                }
            }
            if reminderStore.upcomingReminders(limit: 3).isEmpty {
                Text("You're all set for now. I'll remind you when it's time.")
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.teal.opacity(0.12))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    private var favoriteContacts: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Label("Quick contacts", systemImage: "person.fill.checkmark")
                    .font(.headline)
                Spacer()
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(contactStore.favoriteContacts()) { contact in
                        ContactChip(contact: contact)
                    }
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.indigo.opacity(0.12))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

private struct ReminderRow: View {
    let reminder: Reminder
    let onToggle: () -> Void

    private var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }

    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            Button(action: onToggle) {
                Image(systemName: reminder.isCompleted ? "checkmark.circle.fill" : "circle")
                    .font(.title3)
                    .foregroundStyle(reminder.isCompleted ? Color.green : Color.gray)
            }
            .buttonStyle(.plain)

            VStack(alignment: .leading, spacing: 4) {
                Text(reminder.title)
                    .font(.headline)
                Text(timeFormatter.string(from: reminder.time))
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Text(reminder.notes)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Image(systemName: reminder.category.systemImage)
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 6)
    }
}

private struct ContactChip: View {
    let contact: SupportContact

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Image(systemName: contact.isFavorite ? "heart.fill" : "person.fill")
                    .foregroundStyle(contact.isFavorite ? .red : .secondary)
                Text(contact.name)
                    .font(.headline)
            }
            Text(contact.relationship)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            Text(contact.phoneNumber)
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
        .padding()
        .background(.ultraThickMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 3)
    }
}

struct HomeDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        HomeDashboardView(orientationInfo: OrientationService().currentOrientation())
            .environmentObject(ReminderStore())
            .environmentObject(ContactStore())
            .previewDisplayName("Home Dashboard")
    }
}
