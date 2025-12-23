import SwiftUI

struct MemoriesView: View {
    @EnvironmentObject private var memoryStore: MemoryStore
    @State private var searchText = ""

    private var filteredEntries: [MemoryEntry] {
        if searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return memoryStore.entries
        }
        return memoryStore.entries.filter { entry in
            entry.title.localizedCaseInsensitiveContains(searchText) ||
            entry.detail.localizedCaseInsensitiveContains(searchText) ||
            entry.tags.contains { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }

    var body: some View {
        NavigationStack {
            List(filteredEntries) { entry in
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(entry.title)
                            .font(.headline)
                        Spacer()
                        Text(dateFormatter.string(from: entry.date))
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    Text(entry.detail)
                        .foregroundStyle(.primary)
                    if !entry.tags.isEmpty {
                        HStack {
                            ForEach(entry.tags, id: \.self) { tag in
                                Text(tag)
                                    .font(.caption)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.teal.opacity(0.15))
                                    .clipShape(Capsule())
                            }
                        }
                    }
                }
                .padding(.vertical, 6)
            }
            .navigationTitle("Memories")
            .searchable(text: $searchText)
        }
    }
}

struct MemoriesView_Previews: PreviewProvider {
    static var previews: some View {
        MemoriesView()
            .environmentObject(MemoryStore())
    }
}
