import SwiftUI

struct InclinePushUpsView: View {
    @State private var selectedRepetition = 10
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

                    // Image Preview
                    Image("InclinePushUps") // Add this image to Assets
                        .resizable()
                        .scaledToFit()
                        .frame(height: 240)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding(.horizontal)

                    // Title & Info
                    VStack(spacing: 6) {
                        Text("Incline Push-Ups")
                            .font(.title2)
                            .bold()
                            .multilineTextAlignment(.center)

                        Text("Moderate | 150 Calories Burn")
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                    }

                    // Description
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Descriptions")
                            .font(.headline)

                        Text("Incline push-ups target your chest, shoulders, and triceps while being easier on the wrists. They're a great variation for beginners or warm-up routines.")
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
                            Text("\(Inclinesteps.count) Steps")
                                .foregroundColor(.gray)
                        }

                        ForEach(Inclinesteps.indices, id: \.self) { index in
                            HStack(alignment: .top, spacing: 16) {
                                VStack {
                                    Text(String(format: "%02d", index + 1))
                                        .foregroundColor(.purple)
                                        .fontWeight(.bold)

                                    Circle()
                                        .stroke(Color.purple, lineWidth: 2)
                                        .frame(width: 20, height: 20)

                                    if index < Inclinesteps.count - 1 {
                                        Rectangle()
                                            .fill(Color.purple.opacity(0.4))
                                            .frame(width: 2, height: 40)
                                    }
                                }

                                VStack(alignment: .leading, spacing: 4) {
                                    Text(Inclinesteps[index].title)
                                        .font(.subheadline)
                                        .bold()
                                    Text(Inclinesteps[index].description)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)

                    // Custom Repetitions Picker (1 to 100)
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Custom Repetitions")
                            .font(.headline)
                            .padding(.horizontal)

                        Picker("Repetitions", selection: $selectedRepetition) {
                            ForEach(1...100, id: \.self) { count in
                                Text("\(count) Reps").tag(count)
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
                                LinearGradient(colors: [Color.blue, Color.purple],
                                               startPoint: .leading,
                                               endPoint: .trailing)
                            )
                            .cornerRadius(25)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 30)
                }
            }

            // Toast Message
            if showToast {
                VStack {
                    Spacer()
                    Text("Saved: 150 Calories, \(selectedRepetition) Repetitions")
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

    // Incline Push-Up Steps
    let Inclinesteps: [(title: String, description: String)] = [
        ("Position Yourself", "Stand facing a sturdy elevated surface like a bench or step."),
        ("Place Hands & Lower", "Put your hands shoulder-width apart and lower your body towards the surface."),
        ("Push Back Up", "Push through your palms to return to the starting position. Keep your body straight.")
    ]
}

#Preview {
    InclinePushUpsView()
}
