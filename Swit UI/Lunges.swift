import SwiftUI

struct LungesView: View {
    @State private var selectedRepetition = 20
    @State private var showToast = false

    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 20) {

                    // Top Bar
                    HStack {
                        Spacer()
                        Text("About")
                            .font(.headline)
                            .foregroundColor(.black)
                        Spacer()
                    }
                    .padding(.horizontal)

                    // Preview Image
                    Image("Lunges") // Make sure this image is in Assets.xcassets
                        .resizable()
                        .scaledToFit()
                        .frame(height: 240)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding(.horizontal)

                    // Title & Info
                    VStack(spacing: 6) {
                        Text("Lunges")
                            .font(.title2)
                            .bold()
                            .multilineTextAlignment(.center)

                        Text("Medium Intensity | 250 Calories Burn")
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                    }

                    // Description
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Descriptions")
                            .font(.headline)

                        Text("Lunges are great for strengthening your legs and glutes while also improving balance and flexibility. They’re perfect for your lower body warm-up routine.")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal)

                    // How To Do It
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text("How To Do It")
                                .font(.headline)
                            Spacer()
                            Text("\(lungesSteps.count) Steps")
                                .foregroundColor(.gray)
                        }

                        ForEach(lungesSteps.indices, id: \.self) { index in
                            HStack(alignment: .top, spacing: 16) {
                                VStack {
                                    Text(String(format: "%02d", index + 1))
                                        .foregroundColor(.purple)
                                        .fontWeight(.bold)

                                    Circle()
                                        .stroke(Color.purple, lineWidth: 2)
                                        .frame(width: 20, height: 20)

                                    if index < lungesSteps.count - 1 {
                                        Rectangle()
                                            .fill(Color.purple.opacity(0.4))
                                            .frame(width: 2, height: 40)
                                    }
                                }

                                VStack(alignment: .leading, spacing: 4) {
                                    Text(lungesSteps[index].title)
                                        .font(.subheadline)
                                        .bold()
                                    Text(lungesSteps[index].description)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)

                    // Custom Repetitions Picker
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Custom Repetitions")
                            .font(.headline)
                            .padding(.horizontal)

                        Picker("Repetitions", selection: $selectedRepetition) {
                            ForEach(1...100, id: \.self) { count in
                                Text("\(count) times").tag(count)
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        .frame(height: 100)
                        .clipped()
                        .padding(.horizontal)
                    }

                    // Save Button
                    Button(action: {
                        showToast = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            showToast = false
                        }
                    }) {
                        Text("Save")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                LinearGradient(colors: [Color.blue, Color.purple], startPoint: .leading, endPoint: .trailing)
                            )
                            .cornerRadius(25)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 30)
                }
            }

            // Toast Notification
            if showToast {
                VStack {
                    Spacer()
                    Text("Workout Saved: 250 Calories, \(selectedRepetition) Repetitions")
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.85))
                        .cornerRadius(12)
                        .padding(.bottom, 40)
                        .transition(.opacity)
                }
                .animation(.easeInOut, value: showToast)
            }
        }
    }

    // Lunges Step List
    let lungesSteps: [(title: String, description: String)] = [
        ("Start Position", "Stand tall with feet hip-width apart, hands on your hips."),
        ("Step Forward", "Take a big step forward with one leg, lowering your hips."),
        ("Lower Your Body", "Bend both knees to 90 degrees while keeping your torso upright."),
        ("Push Back", "Push through your front heel to return to the starting position.")
    ]
}

// Preview
#Preview {
    LungesView()
}
