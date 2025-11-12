import SwiftUI

struct DrinkandRestVie: View {
    @State private var selectedDuration = 2
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
                    Image("DrinkandRest")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 240)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding(.horizontal)

                    // Title & Info
                    VStack(spacing: 6) {
                        Text("Drink and Rest")
                            .font(.title2)
                            .bold()
                            .multilineTextAlignment(.center)

                        Text("Recovery | 0 Calories Burn")
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                    }

                    // Description
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Descriptions")
                            .font(.headline)

                        Text("Rest and hydration are crucial between and after workouts. They help your body recover and maintain performance levels.")
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
                            Text("\(Drinksteps.count) Steps")
                                .foregroundColor(.gray)
                        }

                        ForEach(Drinksteps.indices, id: \.self) { index in
                            HStack(alignment: .top, spacing: 16) {
                                VStack {
                                    Text(String(format: "%02d", index + 1))
                                        .foregroundColor(.purple)
                                        .fontWeight(.bold)

                                    Circle()
                                        .stroke(Color.purple, lineWidth: 2)
                                        .frame(width: 20, height: 20)

                                    if index < Drinksteps.count - 1 {
                                        Rectangle()
                                            .fill(Color.purple.opacity(0.4))
                                            .frame(width: 2, height: 40)
                                    }
                                }

                                VStack(alignment: .leading, spacing: 4) {
                                    Text(Drinksteps[index].title)
                                        .font(.subheadline)
                                        .bold()
                                    Text(Drinksteps[index].description)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)

                    // Custom Rest Duration Picker (1–100 mins)
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Custom Rest Duration")
                            .font(.headline)
                            .padding(.horizontal)

                        Picker("Duration", selection: $selectedDuration) {
                            ForEach(1...100, id: \.self) { minutes in
                                Text("\(minutes) Minutes").tag(minutes)
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

            // Toast View
            if showToast {
                VStack {
                    Spacer()
                    Text("Saved: 0 Calories, \(selectedDuration) Minutes Rest")
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

    // Rest Steps
    let Drinksteps: [(title: String, description: String)] = [
        ("Sit Down Comfortably", "Find a quiet space to rest and allow your heart rate to come down."),
        ("Drink Water", "Rehydrate yourself with a glass of water or electrolyte drink."),
        ("Breathe Deeply", "Take slow, deep breaths to help your muscles relax and recover.")
    ]
}

#Preview {
    DrinkandRestVie()
}
