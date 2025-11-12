import SwiftUI
import Charts
import UserNotifications

struct SleepData: Identifiable, Decodable {
    let id = UUID()
    let date: Date
    let hours: Double

    var displayLabel: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E dd MMM"
        return formatter.string(from: date)
    }
}

struct BackendSleepData: Decodable {
    let sleep_date: String
    let hours_slept: Double
}

struct GraphResponse: Decodable {
    let status: Bool
    let data: [BackendSleepData]
}

struct SaveResponse: Decodable {
    let status: Bool
    let message: String
}

struct SleepTracker: View {
    @AppStorage("user_id") private var userId: Int = 0

    @State private var sleepStats: [SleepData] = []
    @State private var lastNightSleepHours: Double = 0.0
    @State private var showAlarmBanner = false
    @State private var nextAlarmInfo = ""
    @State private var manualSleepStart = Date()
    @State private var manualSleepEnd = Date()
    @State private var showSleepAlert = false

    var lastNightSleepColor: Color {
        switch lastNightSleepHours {
        case 10...: return .green
        case 8..<10: return .black
        case 5..<8: return .orange
        case 4..<5: return .yellow
        case 3..<4: return .red.opacity(0.6)
        case ..<3: return .red
        default: return .white
        }
    }

    func backgroundGradient(for hours: Double) -> LinearGradient {
        let color: Color
        switch hours {
        case 10...: color = .green
        case 8..<10: color = .pink
        case 5..<8: color = .orange
        case 4..<5: color = .yellow
        case 3..<4: color = .red.opacity(0.6)
        case ..<3: color = .red
        default: color = .blue
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
                if showAlarmBanner {
                    Text(nextAlarmInfo)
                        .padding()
                        .background(Color.purple.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .padding(.horizontal)
                }

                VStack(alignment: .leading) {
                    Text("Sleep Graph")
                        .font(.title3)
                        .bold()
                        .padding(.horizontal)

                    Chart {
                        ForEach(latest7DaysData(), id: \.id) { stat in
                            BarMark(x: .value("Day", stat.displayLabel), y: .value("Hours", stat.hours))
                                .foregroundStyle(sleepColor(for: stat.hours))
                            LineMark(x: .value("Day", stat.displayLabel), y: .value("Hours", stat.hours))
                            PointMark(x: .value("Day", stat.displayLabel), y: .value("Hours", stat.hours))
                        }
                    }
                    .frame(height: 250)
                    .padding(.horizontal)
                }

                // MARK: - Manual Sleep Entry
                VStack(spacing: 10) {
                    Text("Enter Sleep Duration Manually")
                        .font(.headline)

                    DatePicker("Sleep Start", selection: $manualSleepStart, displayedComponents: [.date, .hourAndMinute])
                        .labelsHidden()

                    DatePicker("Wake Up", selection: $manualSleepEnd, displayedComponents: [.date, .hourAndMinute])
                        .labelsHidden()

                    Button("Record Sleep") {
                        let duration = manualSleepEnd.timeIntervalSince(manualSleepStart) / 3600
                        if duration > 0 {
                            let rounded = round(duration * 10) / 10
                            saveSleepToBackend(userId: userId, date: manualSleepStart, hours: rounded)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .padding(.horizontal)
                }

                ZStack(alignment: .topLeading) {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(backgroundGradient(for: lastNightSleepHours))
                        .frame(height: 140)

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Last Night Sleep")
                            .foregroundColor(.white)
                            .font(.subheadline)
                        Text("\(lastNightSleepHours, specifier: "%.1f")h")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(lastNightSleepColor)
                    }
                    .padding()
                }
                .padding(.horizontal)

                HStack {
                    Text("Daily Sleep Schedule")
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                    Spacer()
                    NavigationLink(destination: SleepCheck(scheduleNotification: scheduleNotification)) {
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
            }
            .padding(.vertical)
        }
        .navigationTitle("Sleep Tracker")
        .onAppear {
            fetchSleepGraph(userId: userId)
        }
        .alert("Sleep Recorded", isPresented: $showSleepAlert) {
            Button("OK", role: .cancel) { }
        }
    }

    func latest7DaysData() -> [SleepData] {
        let sorted = sleepStats.sorted { $0.date < $1.date }
        return Array(sorted.suffix(7))
    }

    func sleepColor(for hours: Double) -> Color {
        switch hours {
        case 10...: return .green
        case 8..<10: return .pink
        case 5..<8: return .orange
        case 4..<5: return .yellow
        case 3..<4: return .red.opacity(0.6)
        case ..<3: return .red
        default: return .blue
        }
    }

    func scheduleNotification(_ alarm: AlarmData) {
        let content = UNMutableNotificationContent()
        content.title = "Sleep Reminder"
        content.body = "Bedtime set: \(alarm.bedtime.formatted(date: .omitted, time: .shortened))"
        content.sound = .default

        let triggerDate = Calendar.current.dateComponents([.hour, .minute], from: alarm.bedtime)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: true)

        UNUserNotificationCenter.current().add(UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger))

        let now = Date()
        let interval = alarm.bedtime.timeIntervalSince(now)
        if interval > 0 {
            let hrs = Int(interval / 3600)
            let mins = (Int(interval) % 3600) / 60
            nextAlarmInfo = "Next alarm in \(hrs)h \(mins)m"
            showAlarmBanner = true
        }
    }

    func saveSleepToBackend(userId: Int, date: Date, hours: Double) {
        guard let url = URL(string: "http://localhost/vfit_app1/sleepschedule.php") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: date)

        let body = "user_id=\(userId)&sleep_date=\(dateString)&hours_slept=\(hours)"
        request.httpBody = body.data(using: .utf8)

        URLSession.shared.dataTask(with: request) { data, _, _ in
            guard let data = data else { return }
            if let result = try? JSONDecoder().decode(SaveResponse.self, from: data), result.status {
                DispatchQueue.main.async {
                    lastNightSleepHours = hours
                    showSleepAlert = true
                    fetchSleepGraph(userId: userId)
                }
            }
        }.resume()
    }

    func fetchSleepGraph(userId: Int) {
        guard let url = URL(string: "http://localhost/vfit_app1/get_sleep.php?user_id=\(userId)") else { return }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }

            if let decoded = try? JSONDecoder().decode(GraphResponse.self, from: data), decoded.status {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"

                DispatchQueue.main.async {
                    let stats = decoded.data.compactMap {
                        if let date = formatter.date(from: $0.sleep_date) {
                            return SleepData(date: date, hours: $0.hours_slept)
                        }
                        return nil
                    }

                    sleepStats = stats

                    // ✅ Automatically update last night’s sleep value from DB
                    let calendar = Calendar.current
                    let yesterday = calendar.date(byAdding: .day, value: -1, to: Date())!

                    if let lastNight = stats.last(where: { calendar.isDate($0.date, inSameDayAs: yesterday) }) {
                        lastNightSleepHours = lastNight.hours
                    } else {
                        lastNightSleepHours = 0.0
                    }
                }
            }
        }.resume()
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        SleepTracker()
    }
}
