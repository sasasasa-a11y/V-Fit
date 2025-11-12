import SwiftUI

struct ChickpeaCrunchDetailView: View {
    @State private var showToast = false

    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 24) {

                    // Header Image
                    ZStack(alignment: .top) {
                        VStack(spacing: 12) {
                            HStack { Spacer() }
                                .padding(.horizontal)

                            Image("chickpea")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 380, height: 300)
                                .clipShape(RoundedRectangle(cornerRadius: 32))
                                .padding(.top, 1)
                        }
                    }

                    // Title
                    VStack(spacing: 6) {
                        Text("Chickpea Crunch")
                            .font(.title2.bold())
                        Text("by Healthy Meals")
                            .foregroundColor(.blue)
                            .font(.subheadline)
                    }

                    // Nutrition
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Nutrition")
                            .font(.headline)
                            .padding(.horizontal)

                        HStack(spacing: 16) {
                            nutritionBox(title: "Calories", value: "240", unit: "kCal", emoji: "🔥")
                            nutritionBox(title: "Fats", value: "8", unit: "g", emoji: "🥑")
                            nutritionBox(title: "Proteins", value: "13", unit: "g", emoji: "🥗")
                            nutritionBox(title: "Carbs", value: "30", unit: "g", emoji: "🌰")
                        }
                        .padding(.horizontal)
                    }

                    // Description
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Descriptions")
                            .font(.headline)
                        Text("Chickpea Crunch is a fiber- and protein-rich breakfast made with crispy roasted chickpeas, fresh veggies, and a zesty dressing — perfect for a power-packed morning.")
                            .font(.callout)
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal)

                    // Ingredients
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Ingredients That You Will Need")
                            .font(.headline)
                            .padding(.horizontal)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ingredientCard(name: "Boiled Chickpeas", qty: "1 cup", image: "🌰")
                                ingredientCard(name: "Cucumber", qty: "1/4 cup", image: "🥒")
                                ingredientCard(name: "Tomato", qty: "1/4 cup", image: "🍅")
                                ingredientCard(name: "Onion", qty: "2 tbsp", image: "🧅")
                                ingredientCard(name: "Lemon Juice", qty: "1 tbsp", image: "🍋")
                                ingredientCard(name: "Chaat Masala", qty: "1/2 tsp", image: "🧂")
                            }
                            .padding(.horizontal)
                        }
                    }

                    // Steps
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Step by Step")
                            .font(.headline)
                            .padding(.horizontal)

                        ForEach(1..<6) { step in
                            HStack(alignment: .top) {
                                Circle()
                                    .strokeBorder(.blue, lineWidth: 2)
                                    .frame(width: 24, height: 24)
                                    .overlay(Text("0\(step)").font(.caption2))

                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Step \(step)")
                                        .fontWeight(.semibold)
                                    Text(stepDescription(step))
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }

                    // Add Button
                    Button(action: {
                        withAnimation { showToast = true }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation { showToast = false }
                        }
                    }) {
                        Text("Add to Lunch Meal")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                            .shadow(radius: 5)
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom, 30)
            }

            // Toast View
            if showToast {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Text("✅ Added to Lunch")
                            .font(.caption)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 10)
                            .background(Color.black.opacity(0.8))
                            .foregroundColor(.white)
                            .cornerRadius(20)
                        Spacer()
                    }
                    .padding(.bottom, 40)
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
    }

    // MARK: - Nutrition Box View
    func nutritionBox(title: String, value: String, unit: String, emoji: String) -> some View {
        VStack(spacing: 6) {
            Text(emoji).font(.largeTitle)
            VStack(spacing: 2) {
                Text("\(value)\(unit)")
                    .font(.subheadline)
                    .fontWeight(.bold)
                Text(title)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .frame(width: 80, height: 80)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(16)
    }

    // MARK: - Ingredient Card View
    func ingredientCard(name: String, qty: String, image: String) -> some View {
        VStack(spacing: 6) {
            Text(image)
                .font(.system(size: 36))
            Text(name)
                .font(.caption)
            Text(qty)
                .font(.caption2)
                .foregroundColor(.gray)
        }
        .frame(width: 80)
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(16)
    }

    // MARK: - Step Descriptions
    func stepDescription(_ step: Int) -> String {
        switch step {
        case 1: return "Boil chickpeas until soft and drain them well."
        case 2: return "Chop cucumber, tomato, and onion finely."
        case 3: return "Toss chickpeas with chopped veggies in a bowl."
        case 4: return "Add lemon juice, chaat masala, and salt. Mix well."
        case 5: return "Serve fresh as a crunchy, protein-rich breakfast!"
        default: return ""
        }
    }
}

// MARK: - Preview
struct ChickpeaCrunchDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ChickpeaCrunchDetailView()
            .previewDevice("iPhone 16 Pro")
    }
}
