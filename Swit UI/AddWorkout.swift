import SwiftUI

struct AddScheduleView: View {
    @State private var selectedDate = Date()
    @State private var selectedHour = 6
    @State private var selectedMinute = 0
    @State private var isPM = true

    @State private var selectedWorkout = "Fullbody Workout"
    @State private var selectedDifficulty = "Beginner"

    @State private var customWeight = 10
    @State private var customReps = 10

    @State private var showWorkoutOptions = false
    @State private var showDifficultyOptions = false
    @State private var showWeightPicker = false
    @State private var showRepetitionPicker = false
    @State private var navigateToSummary = false
    @State private var showToast = false

    let workouts = ["Fullbody Workout", "Ab Workout", "Lowerbody Workout"]
    let difficulties = ["Difficult", "Easy", "Beginner"]

    var body: some View {
       
            ScrollView {
                VStack(spacing: 20) {

                    // MARK: - Date Picker
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Select Date")
                            .font(.headline)
                            .padding(.horizontal)

                        HStack {
                            Image(systemName: "calendar")
                                .foregroundColor(.purple)
                            DatePicker(
                                "",
                                selection: $selectedDate,
                                displayedComponents: .date
                            )
                            .datePickerStyle(.compact)
                            .labelsHidden()

                            Spacer()
                        }
                        .padding(.horizontal)
                    }

                    // MARK: - Time Picker
                    VStack(alignment: .leading) {
                        Text("Select Time")
                            .font(.headline)
                            .padding(.horizontal)

                        HStack {
                            Picker("Hour", selection: $selectedHour) {
                                ForEach(1..<13) { hour in
                                    Text("\(hour)").tag(hour)
                                }
                            }
                            .frame(width: 60)
                            .clipped()

                            Picker("Minute", selection: $selectedMinute) {
                                ForEach(0..<60) { minute in
                                    Text(String(format: "%02d", minute)).tag(minute)
                                }
                            }
                            .frame(width: 60)
                            .clipped()

                            Picker("AM/PM", selection: $isPM) {
                                Text("AM").tag(false)
                                Text("PM").tag(true)
                            }
                            .pickerStyle(.wheel)
                            .frame(width: 80)
                            .clipped()
                        }
                        .frame(height: 120)
                        .padding(.horizontal)
                    }

                    // MARK: - Workout Options
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Workout Details")
                            .font(.headline)
                            .padding(.horizontal)

                        OptionRow(icon: "dumbbell.fill", title: "Choose Workout", value: selectedWorkout) {
                            showWorkoutOptions = true
                        }

                        OptionRow(icon: "arrow.up.arrow.down", title: "Difficulty", value: selectedDifficulty) {
                            showDifficultyOptions = true
                        }

                        OptionRow(icon: "repeat.circle", title: "Custom Repetitions", value: "\(customReps)") {
                            showRepetitionPicker = true
                        }

                        OptionRow(icon: "scalemass", title: "Custom Weights", value: "\(customWeight) kg") {
                            showWeightPicker = true
                        }
                    }
                    .padding()

                    Spacer()

                    // MARK: - Save Button
                    Button(action: {
                        showToast = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            showToast = false
                            navigateToSummary = true
                        }
                    }) {
                        Text("Save")
                            .bold()
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                LinearGradient(colors: [.blue.opacity(0.8), .purple.opacity(0.8)], startPoint: .leading, endPoint: .trailing)
                            )
                            .cornerRadius(40)
                            .padding(.horizontal)
                    }
                    .navigationDestination(isPresented: $navigateToSummary) {
                        WorkoutScheduleView()
                    }
                }
            }
            .navigationTitle("Add Schedule")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showWorkoutOptions) {
                SelectionSheet(title: "Choose Workout", options: workouts, selected: $selectedWorkout)
            }
            .sheet(isPresented: $showDifficultyOptions) {
                SelectionSheet(title: "Select Difficulty", options: difficulties, selected: $selectedDifficulty)
            }
            .sheet(isPresented: $showWeightPicker) {
                numberPickerSheet(title: "Select Weight (kg)", range: 1...100, selection: $customWeight)
            }
            .sheet(isPresented: $showRepetitionPicker) {
                numberPickerSheet(title: "Select Repetitions", range: 1...100, selection: $customReps)
            }
            .overlay(
                Group {
                    if showToast {
                        Text("Workout saved!")
                            .padding()
                            .background(Color.black.opacity(0.85))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .transition(.move(edge: .bottom).combined(with: .opacity))
                            .padding(.bottom, 40)
                    }
                },
                alignment: .bottom
            )
        }
    }

    func numberPickerSheet(title: String, range: ClosedRange<Int>, selection: Binding<Int>) -> some View {
        @Environment(\.dismiss) var dismiss
        return VStack {
            Text(title)
                .font(.headline)
                .padding()

            Picker("", selection: selection) {
                ForEach(range, id: \.self) { number in
                    Text("\(number)").tag(number)
                }
            }
            .pickerStyle(.wheel)
            .frame(height: 150)

            Button("Done") {
                dismiss()
            }
            .padding()
        }
    }


// MARK: - Option Row View
struct OptionRow: View {
    let icon: String
    let title: String
    let value: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Label(title, systemImage: icon)
                    .foregroundColor(.black)
                Spacer()
                Text(value)
                    .foregroundColor(.gray)
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(16)
        }
    }
}

// MARK: - Selection Sheet View
struct SelectionSheet: View {
    let title: String
    let options: [String]
    @Binding var selected: String
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
                .padding()

            List {
                ForEach(options, id: \.self) { option in
                    Button(action: {
                        selected = option
                        dismiss()
                    }) {
                        HStack {
                            Text(option)
                            if selected == option {
                                Spacer()
                                Image(systemName: "checkmark")
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                }
            }

            Button("Cancel") {
                dismiss()
            }
            .padding()
        }
    }
}

// MARK: - Dummy Summary View
struct WworkoutScheduleView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Workout Scheduled!")
                .font(.title2)
                .bold()
            Text("Your workout has been successfully saved.")
                .foregroundColor(.gray)
        }
        .padding()
    }
}

// MARK: - Preview
#Preview {
    AddScheduleView()
}
