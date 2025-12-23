import SwiftUI

struct AssistantView: View {
    @EnvironmentObject private var assistantService: AssistantService
    @State private var messageText = ""

    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                ScrollViewReader { proxy in
                    ScrollView {
                        LazyVStack(alignment: .leading, spacing: 12) {
                            ForEach(assistantService.messages) { message in
                                messageBubble(for: message)
                                    .id(message.id)
                            }
                        }
                        .padding(.vertical)
                    }
                    .onChange(of: assistantService.messages.count) { _ in
                        if let lastID = assistantService.messages.last?.id {
                            withAnimation {
                                proxy.scrollTo(lastID, anchor: .bottom)
                            }
                        }
                    }
                }

                HStack(spacing: 10) {
                    TextField("Ask for help or jot a note", text: $messageText, axis: .vertical)
                        .textFieldStyle(.roundedBorder)
                    Button(action: send) {
                        Image(systemName: "arrow.up.circle.fill")
                            .font(.title2)
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(messageText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
            .padding()
            .navigationTitle("Assistant")
        }
    }

    private func messageBubble(for message: AssistantMessage) -> some View {
        HStack {
            if message.isUser { Spacer() }
            VStack(alignment: .leading, spacing: 4) {
                Text(message.content)
                    .padding(12)
                    .background(message.isUser ? Color.teal.opacity(0.9) : Color(.secondarySystemBackground))
                    .foregroundStyle(message.isUser ? Color.white : Color.primary)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                Text(message.timestamp, style: .time)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
            if !message.isUser { Spacer() }
        }
    }

    private func send() {
        assistantService.send(userText: messageText)
        messageText = ""
    }
}

struct AssistantView_Previews: PreviewProvider {
    static var previews: some View {
        AssistantView()
            .environmentObject(AssistantService())
    }
}
