import SwiftUI

struct CalfRaisesView: View {
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

                    // Image Preview
                    Image("CalfRaises") // Ensure image is in Assets.xcassets
                        .resizable()
                        .scaledToFit()
                        .frame(height: 240)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding(.horizontal)

                    // Title & Info
                    VStack(spacing: 6) {
                        Text("Calf Raises")
                            .font(.title2)
                            .bold()
                            .multilineTextAlignment(.center)

                        Text("Low Intensity | 120 Calories Burn")
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                    }

                    // Description
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Descriptions")
                            .font(.headline)

                        Text("Calf raises strengthen and tone the calves, improve ankle stability, and enhance balance. This low-impact move is simple yet effective for lower-leg endurance.")
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
                            Text("4 Steps")
                                .foregroundColor(.gray)
                        }

                        ForEach(steps.indices, id: \.self) { index in
                            HStack(alignment: .top, spacing: 16) {
                                VStack {
                                    Text(String(format: "%02d", index + 1))
                                        .foregroundColor(.purple)
                                        .fontWeight(.bold)

                                    Circle()
                                        .stroke(Color.purple, lineWidth: 2)
                                        .frame(width: 20, height: 20)

                                    if index < steps.count - 1 {
                                        Rectangle()
                                            .fill(Color.purple.opacity(0.4))
                                            .frame(width: 2, height: 40)
                                    }
                                }

                                VStack(alignment: .leading, spacing: 4) {
                                    Text(steps[index].title)
                                        .font(.subheadline)
                                        .bold()
                                    Text(steps[index].description)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)

                    // Custom Repetitions Picker (1–100)
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Custom Repetitions")
                            .font(.headline)
                            .padding(.horizontal)

                        Picker("Repetitions", selection: $selectedRepetition) {
                            ForEach(1...100, id: \.self) { count in
                                Text("\(count) seconds").tag(count)
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
                            .background(LinearGradient(colors: [Color.blue, Color.purple], startPoint: .leading, endPoint: .trailing))
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
                    Text("Saved: 120 Calories, \(selectedRepetition) Repetitions")
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

    // Calf Raises Steps
    let steps: [(title: String, description: String)] = [
        ("Stand Straight", "Stand tall with your feet hip-width apart, arms relaxed at your sides."),
        ("Raise Heels", "Slowly lift your heels off the ground to stand on your toes."),
        ("Hold the Top", "Pause briefly at the top of the movement for a second."),
        ("Lower Down", "Lower your heels back to the ground with control. Repeat.")
    ]
}

// Preview
#Preview {
    CalfRaisesView()
}
