import SwiftUI

struct HomeView: View {
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .none
        return formatter.string(from: Date())
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            VStack(alignment: .leading, spacing: 6) {
                Text("SereneDay")
                    .font(.largeTitle.bold())
                Text(formattedDate)
                    .font(.title3)
                    .foregroundStyle(.secondary)
            }

            VStack(alignment: .leading, spacing: 12) {
                Text("Welcome back")
                    .font(.title2)
                    .fontWeight(.semibold)
                Text("Your day is organized and ready. Tap below to begin with confidence.")
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Button(action: {}) {
                HStack {
                    Image(systemName: "sun.max.fill")
                        .imageScale(.large)
                    Text("Start My Day")
                        .fontWeight(.semibold)
                }
                .frame(maxWidth: .infinity)
                .padding()
            }
            .buttonStyle(.borderedProminent)
            .tint(.teal)

            Spacer()
        }
        .padding()
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
