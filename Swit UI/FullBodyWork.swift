import SwiftUI

struct FullbodyWorkoutView: View {
    @State private var scheduledDate = Date()

    let exercisesSet1: [ExerciseItem] = [
        .init(image: "Ex1", title: "Warm Up", detail: "05:00"),
        .init(image: "Ex2", title: "Jumping Jack", detail: "12x"),
        .init(image: "Ex3", title: "Skipping", detail: "15x"),
        .init(image: "Ex4", title: "Squats", detail: "20x"),
        .init(image: "Ex5", title: "Arm Raises", detail: "00:53"),
        .init(image: "Ex6", title: "Rest and Drink", detail: "02:00")
    ]

    let exercisesSet2: [ExerciseItem] = [
        .init(image: "Ex7", title: "Incline Push-Ups", detail: "12x"),
        .init(image: "Ex8", title: "Push-Ups", detail: "15x"),
        .init(image: "Ex10", title: "Cobra Stretch", detail: "20x")
    ]

    var body: some View {
        VStack(spacing: 0) {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 10) {
                    Image("FullBody")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .clipped()
                        .cornerRadius(16)
                        .padding(.horizontal)
                        .padding(.top, 50)

                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text("Fullbody Workout")
                                .font(.title3.bold())
                            Spacer()
                            Image(systemName: "heart.fill")
                                .foregroundColor(.red)
                        }

                        Text("9 Exercises | 32 mins | 320 Calories Burn")
                            .foregroundColor(.gray)

                        VStack(alignment: .leading, spacing: 8) {
                            Text("Schedule Workout")
                                .font(.subheadline)
                                .bold()
                            DatePicker("Pick a time", selection: $scheduledDate, displayedComponents: [.date, .hourAndMinute])
                                .datePickerStyle(.compact)
                                .labelsHidden()
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(16)

                        HStack {
                            Text("Exercises")
                                .font(.headline)
                            Spacer()
                            Text("2 Sets")
                                .foregroundColor(.gray)
                        }

                        ExerciseSetView(title: "Set 1", items: exercisesSet1)
                        ExerciseSetView(title: "Set 2", items: exercisesSet2)
                    }
                    .padding(.horizontal)
                }
            }

            // Start Workout Button
            Button(action: {
                // Replace with your backend logic or PHP API call trigger
                print("Start workout tapped")
            }) {
                Text("Start Workout")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        LinearGradient(colors: [Color.blue.opacity(0.6), Color.purple.opacity(0.6)],
                                       startPoint: .leading,
                                       endPoint: .trailing)
                    )
                    .cornerRadius(24)
                    .shadow(color: Color.black.opacity(0.1), radius: 10)
            }
            .padding()
        }
    }
}

// MARK: - Model
struct ExerciseItem: Identifiable {
    let id = UUID()
    let image: String
    let title: String
    let detail: String
}

// MARK: - List without Navigation
struct ExerciseSetView: View {
    let title: String
    let items: [ExerciseItem]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .foregroundColor(.gray)
                .font(.subheadline)

            ForEach(items) { item in
                HStack {
                    Image(item.image)
                        .resizable()
                        .frame(width: 48, height: 48)
                        .cornerRadius(12)
                    VStack(alignment: .leading) {
                        Text(item.title).bold()
                        Text(item.detail)
                            .foregroundColor(.gray)
                            .font(.caption)
                    }
                    Spacer()
                }
                .padding(.vertical, 4)
            }
        }
    }
}

// MARK: - Preview
#Preview {
    FullbodyWorkoutView()
}
