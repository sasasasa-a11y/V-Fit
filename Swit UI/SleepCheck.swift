import SwiftUI

struct AlarmData: Identifiable, Equatable {
    let id: UUID
    var bedtime: Date
    var repeatDays: [String]
    var isOn: Bool

    init(id: UUID = .init(), bedtime: Date, repeatDays: [String], isOn: Bool = true) {
        self.id = id
        self.bedtime = bedtime
        self.repeatDays = repeatDays
        self.isOn = isOn
    }
}

struct SleepCheck: View {
    @Environment(\.dismiss) var dismiss
    @AppStorage("user_id") private var userId: Int = 0
    @State private var addedAlarms: [AlarmData] = []
    @State private var showSheet = false
    @State private var editing: AlarmData? = nil
    @State private var selectedDay: String = "Mon"

    let allDays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]

    var scheduleNotification: (AlarmData) -> Void

    var body: some View {
        VStack {
            Text("Alarms for \(selectedDay)").font(.headline).padding()

            daySelector

            ScrollView {
                VStack(alignment: .leading) {
                    ForEach($addedAlarms) { $alarm in
                        if alarm.repeatDays.contains(selectedDay) {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("🛏 \(alarm.bedtime.formatted(date: .omitted, time: .shortened))")
                                    Spacer()
                                    Toggle("", isOn: $alarm.isOn)
                                        .toggleStyle(SwitchToggleStyle(tint: .purple))
                                }
                                Text("Repeats: \(alarm.repeatDays.joined(separator: ", "))")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(16)
                            .onTapGesture {
                                editing = alarm
                                showSheet = true
                            }
                        }
                    }
                }
                .padding()
            }

            Spacer()
            addButton
        }
        .onAppear(perform: fetchAlarms)
        .sheet(isPresented: $showSheet) {
            AddAlarmSheet(existingAlarm: editing) { alarm in
                if let ed = editing, let idx = addedAlarms.firstIndex(where: { $0.id == ed.id }) {
                    addedAlarms[idx] = alarm
                } else {
                    addedAlarms.append(alarm)
                }
                scheduleNotification(alarm)
                saveAlarmToBackend(alarm)
                showSheet = false
            }
        }
    }

    var daySelector: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(allDays, id: \.self) { day in
                    Text(day)
                        .padding()
                        .background(day == selectedDay ? Color.blue : Color.gray.opacity(0.2))
                        .foregroundColor(day == selectedDay ? .white : .black)
                        .clipShape(Capsule())
                        .onTapGesture {
                            selectedDay = day
                        }
                }
            }.padding(.horizontal)
        }
    }

    var addButton: some View {
        HStack {
            Spacer()
            Button {
                editing = nil
                showSheet = true
            } label: {
                Image(systemName: "plus")
                    .font(.title)
                    .padding()
                    .background(LinearGradient(colors: [.purple, .pink], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .clipShape(Circle())
                    .foregroundColor(.white)
                    .shadow(radius: 5)
            }
        }.padding()
    }

    func fetchAlarms() {
        guard let url = URL(string: "http://localhost/vfit/get_alarm.php?user_id=\(userId)") else { return }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            if let result = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
               let status = result["status"] as? Bool, status,
               let alarmArray = result["alarms"] as? [[String: Any]] {
                DispatchQueue.main.async {
                    self.addedAlarms = alarmArray.compactMap { dict in
                        guard let timeStr = dict["alarm_time"] as? String,
                              let repeatStr = dict["repeat_days"] as? String,
                              let isOn = dict["is_on"] as? Int else { return nil }

                        let formatter = DateFormatter()
                        formatter.dateFormat = "HH:mm:ss"
                        if let date = formatter.date(from: timeStr) {
                            let days = repeatStr.components(separatedBy: ",")
                            return AlarmData(bedtime: date, repeatDays: days, isOn: isOn == 1)
                        }
                        return nil
                    }
                }
            }
        }.resume()
    }

    func saveAlarmToBackend(_ alarm: AlarmData) {
        guard let url = URL(string: "http://localhost/vfit/save_alarm.php") else { return }

        let boundary = "Boundary-\(UUID().uuidString)"
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        let timeStr = formatter.string(from: alarm.bedtime)
        let daysStr = alarm.repeatDays.joined(separator: ",")

        var body = Data()
        let fields = [
            "user_id": "\(userId)",
            "alarm_time": timeStr,
            "repeat_days": daysStr,
            "is_on": alarm.isOn ? "1" : "0"
        ]

        for (key, value) in fields {
            body.append("--\(boundary)\r\n")
            body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.append("\(value)\r\n")
        }
        body.append("--\(boundary)--\r\n")
        request.httpBody = body

        URLSession.shared.dataTask(with: request).resume()
    }
}

struct AddAlarmSheet: View {
    @Environment(\.dismiss) var dismiss
    var existingAlarm: AlarmData?
    @State private var bedtime = Date()
    @State private var selectedDays: [String] = []
    @State private var isOn = true
    var onSave: (AlarmData) -> Void

    let allDays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]

    var body: some View {
        NavigationView {
            Form {
                Section {
                    DatePicker("Bedtime", selection: $bedtime, displayedComponents: .hourAndMinute)
                }

                Section(header: Text("Repeat Days")) {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4)) {
                        ForEach(allDays, id: \.self) { day in
                            Text(day)
                                .padding(10)
                                .background(selectedDays.contains(day) ? Color.blue : Color.gray.opacity(0.2))
                                .foregroundColor(selectedDays.contains(day) ? .white : .black)
                                .clipShape(Circle())
                                .onTapGesture {
                                    if selectedDays.contains(day) {
                                        selectedDays.removeAll { $0 == day }
                                    } else {
                                        selectedDays.append(day)
                                    }
                                }
                        }
                    }
                }

                Section {
                    Toggle("Active", isOn: $isOn)
                }

                Section {
                    Button(existingAlarm == nil ? "Add Alarm" : "Save Changes") {
                        let alarm = AlarmData(id: existingAlarm?.id ?? .init(),
                                              bedtime: bedtime,
                                              repeatDays: selectedDays,
                                              isOn: isOn)
                        onSave(alarm)
                        dismiss()
                    }
                }
            }
            .navigationTitle(existingAlarm == nil ? "Add Alarm" : "Edit Alarm")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
            .onAppear {
                if let e = existingAlarm {
                    bedtime = e.bedtime
                    selectedDays = e.repeatDays
                    isOn = e.isOn
                }
            }
        }
    }
}

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}

#Preview {
    SleepCheck(scheduleNotification: { _ in })
}
