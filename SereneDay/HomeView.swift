import SwiftUI

struct HomeView: View {
    @State private var currentDate: Date = .now
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                VStack(spacing: 8) {
                    Text("SereneDay")
                        .font(.largeTitle.weight(.bold))
                        .foregroundStyle(.primary)

                    Text(formattedDate)
                        .font(.title3)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                Button(action: startDay) {
                    Text("Start My Day")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Home")
            .onReceive(timer) { newDate in
                currentDate = newDate
            }
        }
    }

    private var formattedDate: String {
        currentDate.formatted(date: .complete, time: .standard)
    }

    private func startDay() {
        // Placeholder for start day action
    }
}

#Preview {
    HomeView()
}
