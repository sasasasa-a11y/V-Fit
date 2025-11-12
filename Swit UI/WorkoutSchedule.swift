import SwiftUI

// MARK: - Workout Models

struct Workout: Identifiable, Equatable {
    let id: Int
    let user_id: Int
    let title: String
    let time: String
    let date: Date
}

struct ServerWorkout: Codable {
    let id: Int
    let user_id: Int
    let title: String
    let time: String
    let date: String
}

struct ServerWorkoutResponse: Codable {
    let status: Bool
    let data: [ServerWorkout]?
    let message: String?
}

// MARK: - Workout Schedule View

struct WorkoutScheduleView: View {
    @State private var selectedDate = Date()
    @State private var selectedWorkout: Workout? = nil
    @State private var showAddSheet = false
    @State private var workouts: [Workout] = []
    
    @State private var dates: [ServerWorkout] = []
  

    let calendar = Calendar.current
    let hours = Array(6...20)
    let userId = 1

    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                header
                dateScroll
                Divider()
                
                ScrollView {
                    VStack(spacing: 24) {
                        ForEach(dates, id: \.id) { hour in
                            HStack(spacing: 20){
                                Text(hour.time)
                                    .frame(width: 100, alignment: .trailing)
                              //  workoutView(for: hour.time)
                               
                                
                                Text(hour.title)
                                    .frame(width: 100, alignment: .trailing)
                            }
                            .onTapGesture {
                                deleteWorkoutFromBackend(id:hour.id)
                            }
                        }

                    }
                    .padding()
                }
            }

            if let workout = selectedWorkout {
                workoutDetailModal(workout)
                    .transition(.move(edge: .bottom))
                    .zIndex(1)
            }

            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button {
                        showAddSheet = true
                    } label: {
                        ZStack {
                            Circle()
                                .fill(LinearGradient(colors: [.purple, .pink], startPoint: .topLeading, endPoint: .bottomTrailing))
                                .frame(width: 64, height: 64)
                                .shadow(color: Color.purple.opacity(0.4), radius: 10, x: 0, y: 5)

                            Image(systemName: "plus")
                                .foregroundColor(.white)
                                .font(.system(size: 28, weight: .bold))
                        }
                    }
                    .padding()
                    .sheet(isPresented: $showAddSheet) {
                        AddScheduleSheet(selectedDate: selectedDate) { newWorkout in
                            addWorkoutToBackend(newWorkout)
                        }
                    }
                }
            }
        }
        .onAppear(perform: fetchWorkouts)
        .onChange(of: selectedDate) { _ in fetchWorkouts() }
        .animation(.easeInOut, value: selectedWorkout)
    }

    // MARK: - UI Components

    var header: some View {
        HStack {
            Spacer()
            Text("Workout Schedule")
                .font(.title2)
                .bold()
            Spacer()
        }
        .padding()
    }

    var dateScroll: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(0..<7) { offset in
                    let date = calendar.date(byAdding: .day, value: offset, to: Date())!
                    VStack {
                        Text(formattedDay(date))
                        Text(formattedDate(date, format: "dd"))
                    }
                    .padding()
                    .background(calendar.isDate(date, inSameDayAs: selectedDate) ? Color.blue.opacity(0.7) : Color.gray.opacity(0.2))
                    .cornerRadius(12)
                    .onTapGesture {
                        selectedDate = date
                        selectedWorkout = nil
                    }
                }
            }
            .padding(.horizontal)
        }
    }

    func workoutView(for hour: Int) -> some View {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"

        let workout = workouts.first { workout in
            if calendar.isDate(workout.date, inSameDayAs: selectedDate),
               let workoutDate = formatter.date(from: workout.time),
               calendar.component(.hour, from: workoutDate) == hour {
                return true
            }
            return false
        }

        return Group {
            if let workout = workout {
                Text("\(workout.title), \(workout.time)")
                    .padding(10)
                    .background(LinearGradient(colors: [.purple, .pink], startPoint: .leading, endPoint: .trailing))
                    .foregroundColor(.white)
                    .cornerRadius(20)
                    .onTapGesture {
                        selectedWorkout = workout
                    }
                    .contextMenu {
                        Button(role: .destructive) {
                           // deleteWorkoutFromBackend(workout)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
            } else {
                Rectangle().fill(Color.clear).frame(height: 20)
            }
        }
    }

    func workoutDetailModal(_ workout: Workout) -> some View {
        VStack {
            Spacer()
            VStack(spacing: 16) {
                HStack {
                    Text("Workout Schedule").bold()
                    Spacer()
                    Button(action: { selectedWorkout = nil }) {
                        Image(systemName: "xmark")
                    }
                }

                Text(workout.title).font(.title3).bold()
                HStack {
                    Image(systemName: "clock")
                    Text("\(formattedDate(workout.date)) | \(workout.time)")
                }

                Button(action: {
                    selectedWorkout = nil
                }) {
                    Text("Done")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(LinearGradient(colors: [.blue, .purple], startPoint: .leading, endPoint: .trailing))
                        .foregroundColor(.white)
                        .cornerRadius(20)
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(24)
            .shadow(radius: 10)
            .padding()
        }
    }

    // MARK: - Backend Integration

    func fetchWorkouts() {
        guard let url = URL(string: "http://localhost/vfit_app1/workoutschedule get.php") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let dateString = formattedDate(selectedDate)
        let body = "user_id=\(userId)&date=\(dateString)"
        request.httpBody = body.data(using: .utf8)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data else {
                print("No data: \(error?.localizedDescription ?? "")")
                return
            }

            do {
                let decoded = try JSONDecoder().decode(ServerWorkoutResponse.self, from: data)
                DispatchQueue.main.async {
                    print(decoded)
                    self.dates = decoded.data ?? []
//                    self.workouts = decoded.data?.compactMap { item in
//                        let df = DateFormatter()
//                        df.dateFormat = "yyyy-MM-dd"
//                        guard let workoutDate = df.date(from: item.date) else { return nil }
//                        return Workout(id: item.id, user_id: item.user_id, title: item.title, time: item.time, date: workoutDate)
//                    } ?? []
                }
            } catch {
                print("Decoding error: \(error)")
            }
        }.resume()
    }

    func addWorkoutToBackend(_ workout: Workout) {
        guard let url = URL(string: "http://localhost/vfit_app1/workoutschedule_add.php") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let dateStr = formattedDate(workout.date)
        let body = "user_id=\(userId)&title=\(workout.title)&time=\(workout.time)&date=\(dateStr)"
        request.httpBody = body.data(using: .utf8)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { _, _, _ in
            DispatchQueue.main.async {
                self.fetchWorkouts() // ✅ FIX: reload workouts after saving
            }
        }.resume()
    }

    func deleteWorkoutFromBackend(id:Int) {
        guard let url = URL(string: "http://localhost/vfit_app1/workoutschedule delete.php") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let body = "id=\(id)"
        request.httpBody = body.data(using: .utf8)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data else {
                print("Delete request failed: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            do {
                let response = try JSONDecoder().decode(ServerWorkoutResponse.self, from: data)
                if response.status {
                    DispatchQueue.main.async {
                        fetchWorkouts()
                    }
                } else {
                    print("Delete failed: \(response.message ?? "Unknown failure")")
                }
            } catch {
                print("JSON decode error during delete: \(error.localizedDescription)")
            }
        }.resume()
    }

    // MARK: - Helpers

    func formattedHour(_ hour: Int) -> String {
        let date = calendar.date(bySettingHour: hour, minute: 0, second: 0, of: Date())!
        return formattedDate(date, format: "hh:00 a")
    }

    func formattedDay(_ date: Date) -> String {
        return formattedDate(date, format: "EEE")
    }

    func formattedDate(_ date: Date, format: String = "yyyy-MM-dd") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
}

// MARK: - Add Schedule Sheet

struct AddScheduleSheet: View {
    @Environment(\.dismiss) var dismiss
    var selectedDate: Date
    var onSave: (Workout) -> Void

    @State private var selectedHour = 7
    @State private var selectedMinute = 0
    @State private var isPM = false
    @State private var selectedWorkout = "Ab Workout"

    var body: some View {
        VStack(spacing: 20) {
            Text("Add Workout").font(.title2).bold()

            Picker("Workout", selection: $selectedWorkout) {
                ForEach(["Ab Workout", "Upperbody", "Lowerbody"], id: \.self) { Text($0) }
            }

            HStack {
                Picker("Hour", selection: $selectedHour) {
                    ForEach(1...12, id: \.self) { Text("\($0)") }
                }
                Picker("Minute", selection: $selectedMinute) {
                    ForEach(0..<60) { Text(String(format: "%02d", $0)) }
                }
                Picker("AM/PM", selection: $isPM) {
                    Text("AM").tag(false)
                    Text("PM").tag(true)
                }
            }

            Button("Save Workout") {
                let time = String(format: "%02d:%02d %@", selectedHour, selectedMinute, isPM ? "PM" : "AM")
                let newWorkout = Workout(id: Int.random(in: 1000...9999), user_id: 1, title: selectedWorkout, time: time, date: selectedDate)
                onSave(newWorkout)
                dismiss()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(12)
        }
        .padding()
    }
}

// MARK: - Preview

#Preview {
    WorkoutScheduleView()
}
