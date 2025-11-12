import SwiftUI
import Charts

// MARK: - Workout Data Models
struct WorkoutData: Identifiable, Decodable {
    let id = UUID()
    let date: Date
    let completion: Double

    var displayLabel: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E dd MMM"
        return formatter.string(from: date)
    }
}

struct WorkoutResponse: Decodable {
    let status: Bool
    let data: [BackendWorkout]
}

struct BackendWorkout: Decodable {
    let workout_date: String
    let completion: Double
}

struct WorkTracker: View {
    @AppStorage("user_id") private var userId: Int = 0
    @State private var isFullbodyOn = true
    @State private var isUpperbodyOn = false
    @State private var weeklyProgress: [WorkoutData] = []
    @State private var lastWorkoutCompletion: Double = 0.0

    var lastWorkoutColor: Color {
        switch lastWorkoutCompletion {
        case 1.0: return .green
        case 0.8..<1.0: return .blue
        case 0.5..<0.8: return .orange
        case 0.3..<0.5: return .yellow
        case ..<0.3: return .red
        default: return .gray
        }
    }

    func backgroundGradient(for value: Double) -> LinearGradient {
        let color: Color
        switch value {
        case 1.0: color = .green
        case 0.8..<1.0: color = .blue
        case 0.5..<0.8: color = .orange
        case 0.3..<0.5: color = .yellow
        case ..<0.3: color = .red
        default: color = .gray
        }
        return LinearGradient(
            gradient: Gradient(colors: [color.opacity(0.8), color.opacity(0.5)]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 25) {
                // MARK: - Graph Section
                VStack(alignment: .leading) {
                    Text("Workout Graph")
                        .font(.title3)
                        .bold()
                        .padding(.horizontal)

                    Chart {
                        ForEach(weeklyProgress, id: \.id) { stat in
                            LineMark(x: .value("Day", stat.displayLabel), y: .value("Completion", stat.completion))
                            PointMark(x: .value("Day", stat.displayLabel), y: .value("Completion", stat.completion))
                        }
                    }
                    .chartYScale(domain: 0...1)
                    .frame(height: 250)
                    .padding(.horizontal)
                }

                // MARK: - Last Workout Completion Card
                ZStack(alignment: .topLeading) {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(backgroundGradient(for: lastWorkoutCompletion))
                        .frame(height: 140)

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Yesterday’s Completion")
                            .foregroundColor(.white)
                            .font(.subheadline)
                        Text("\(lastWorkoutCompletion * 100, specifier: "%.0f")%")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(lastWorkoutColor)
                    }
                    .padding()
                }
                .padding(.horizontal)

                // MARK: - Schedule Link
                HStack {
                    Text("Daily Workout Schedule")
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                    Spacer()
                    NavigationLink(destination: WorkoutScheduleView()) {
                        Text("Check")
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                            .background(Color.white.opacity(0.2))
                            .cornerRadius(12)
                    }
                }
                .padding()
                .background(LinearGradient(colors: [.blue.opacity(0.8), .purple.opacity(0.8)], startPoint: .leading, endPoint: .trailing))
                .cornerRadius(20)
                .padding(.horizontal)

                
                // MARK: - Workout Selection
                VStack(alignment: .leading, spacing: 16) {
                    Text("What Do You Want to Train")
                        .font(.headline)

                    WorkoutCard(
                        title: "Fullbody Workout",
                        exercises: 9,
                        duration: "32 mins",
                        imageName: "work3",
                        destination: FullbodyWorkoutView()
                    )

                    WorkoutCard(
                        title: "Lowerbody Workout",
                        exercises: 9,
                        duration: "40 mins",
                        imageName: "work4",
                        destination: LowerbodyWorkoutView()
                    )

                    WorkoutCard(
                        title: "AB Workout",
                        exercises: 9,
                        duration: "30 mins",
                        imageName: "work5",
                        destination: AbWorkoutView()
                    )
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .navigationTitle("Workout Tracker")
        .onAppear {
            fetchWorkoutData(userId: userId)
        }
    }

    // MARK: - Fetch Workout Graph Data
    func fetchWorkoutData(userId: Int) {
        guard let url = URL(string: "http://localhost/vfit_app1/get_workout.php?user_id=\(userId)") else { return }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }

            if let decoded = try? JSONDecoder().decode(WorkoutResponse.self, from: data), decoded.status {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"

                let stats = decoded.data.compactMap {
                    if let date = formatter.date(from: $0.workout_date) {
                        return WorkoutData(date: date, completion: $0.completion)
                    }
                    return nil
                }

                DispatchQueue.main.async {
                    let sortedStats = stats.sorted(by: { $0.date < $1.date })
                    weeklyProgress = Array(sortedStats.suffix(7))

                    // Extract yesterday's completion
                    let calendar = Calendar.current
                    let yesterday = calendar.date(byAdding: .day, value: -1, to: Date())!
                    if let yest = sortedStats.last(where: { calendar.isDate($0.date, inSameDayAs: yesterday) }) {
                        lastWorkoutCompletion = yest.completion
                    } else {
                        lastWorkoutCompletion = 0.0
                    }
                }
            }
        }.resume()
    }
}

// MARK: - Reusable Toggle Card
struct WorkoutToggleCard: View {
    var imageName: String
    var title: String
    var time: String
    @Binding var isOn: Bool

    var body: some View {
        HStack(spacing: 16) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .cornerRadius(8)

            VStack(alignment: .leading) {
                Text(title).fontWeight(.semibold)
                Text(time)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }

            Spacer()

            Toggle("", isOn: $isOn)
                .labelsHidden()
                .toggleStyle(SwitchToggleStyle(tint: .purple))
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: .gray.opacity(0.1), radius: 5, x: 0, y: 3)
    }
}

// MARK: - Reusable Workout Card
struct WorkoutCard<Destination: View>: View {
    var title: String
    var exercises: Int
    var duration: String
    var imageName: String
    var destination: Destination

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text(title).fontWeight(.semibold)
                Text("\(exercises) Exercises | \(duration)")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                NavigationLink(destination: destination) {
                    Text("View more")
                        .font(.footnote)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.blue.opacity(0.3), lineWidth: 1)
                        )
                }
            }

            Spacer()

            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 64, height: 64)
                .cornerRadius(12)
        }
        .padding()
        .background(Color.purple.opacity(0.05))
        .cornerRadius(20)
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        WorkTracker()
    }
}
