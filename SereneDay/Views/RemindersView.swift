import SwiftUI

struct RemindersView: View {
    @EnvironmentObject private var reminderStore: ReminderStore
    @State private var newReminderTitle = ""
    @State private var newReminderNotes = ""
    @State private var newReminderCategory: Reminder.Category = .medication
    @State private var newReminderTime = Date()

    private var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                reminderList
                addReminderForm
            }
            .padding()
            .navigationTitle("Reminders")
        }
    }

    private var reminderList: some View {
        List {
            ForEach(reminderStore.reminders) { reminder in
                HStack {
                    Button {
                        reminderStore.toggleCompletion(for: reminder.id)
                    } label: {
                        Image(systemName: reminder.isCompleted ? "checkmark.circle.fill" : "circle")
                            .foregroundStyle(reminder.isCompleted ? .green : .secondary)
                    }
                    .buttonStyle(.plain)

                    VStack(alignment: .leading) {
                        Text(reminder.title)
                            .font(.headline)
                        Text(timeFormatter.string(from: reminder.time))
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        if !reminder.notes.isEmpty {
                            Text(reminder.notes)
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                        }
                    }
                    Spacer()
                    Image(systemName: reminder.category.systemImage)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .listStyle(.insetGrouped)
    }

    private var addReminderForm: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Add reminder")
                .font(.headline)

            TextField("Title", text: $newReminderTitle)
                .textFieldStyle(.roundedBorder)
            TextField("Notes (optional)", text: $newReminderNotes, axis: .vertical)
                .textFieldStyle(.roundedBorder)

            DatePicker("Time", selection: $newReminderTime, displayedComponents: .hourAndMinute)

            Picker("Category", selection: $newReminderCategory) {
                ForEach(Reminder.Category.allCases) { category in
                    Label(category.rawValue, systemImage: category.systemImage)
                        .tag(category)
                }
            }
            .pickerStyle(.segmented)

            Button(action: addReminder) {
                Label("Save reminder", systemImage: "plus.circle.fill")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .disabled(newReminderTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }

    private func addReminder() {
        let trimmed = newReminderTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        let reminder = Reminder(
            title: trimmed,
            time: newReminderTime,
            notes: newReminderNotes,
            category: newReminderCategory,
            isCompleted: false
        )
        reminderStore.add(reminder)
        newReminderTitle = ""
        newReminderNotes = ""
        newReminderTime = Date()
    }
}

struct RemindersView_Previews: PreviewProvider {
    static var previews: some View {
        RemindersView()
            .environmentObject(ReminderStore())
    }
}
