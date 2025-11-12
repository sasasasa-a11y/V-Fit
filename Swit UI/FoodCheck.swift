import SwiftUI

// MARK: - Meal Model
struct Meal: Identifiable, Equatable {
    let id = UUID()
    let category: String
    let name: String
    let time: String
    let emoji: String
    let calories: Int
    let protein: Int
    let fat: Int
    let carbs: Int
}

// MARK: - Main View
struct FoodCheck: View {
    @State private var selectedDay: Int = 14
    @State private var deletedMealInfo: (day: Int, category: String, meal: Meal)? = nil
    @State private var showUndo: Bool = false

    @State private var mealsData: [Int: [String: [Meal]]] = [
        11: ["Breakfast": [Meal(category: "Breakfast", name: "Avocado Toast", time: "8:00am", emoji: "🥑", calories: 200, protein: 6, fat: 12, carbs: 18)],
             "Lunch": [Meal(category: "Lunch", name: "Grilled Salmon", time: "12:30pm", emoji: "🐟", calories: 400, protein: 30, fat: 20, carbs: 5)],
             "Snacks": [Meal(category: "Snacks", name: "Yogurt", time: "3:00pm", emoji: "🍦", calories: 150, protein: 5, fat: 2, carbs: 20)],
             "Dinner": [Meal(category: "Dinner", name: "Veggie Stir Fry", time: "7:00pm", emoji: "🥦", calories: 250, protein: 10, fat: 8, carbs: 30)]],
        12: ["Breakfast": [Meal(category: "Breakfast", name: "Smoothie", time: "7:30am", emoji: "🥤", calories: 180, protein: 4, fat: 2, carbs: 35)],
             "Lunch": [Meal(category: "Lunch", name: "Turkey Sandwich", time: "12:00pm", emoji: "🥪", calories: 350, protein: 20, fat: 10, carbs: 30)],
             "Snacks": [Meal(category: "Snacks", name: "Apple", time: "4:00pm", emoji: "🍎", calories: 95, protein: 0, fat: 0, carbs: 25)],
             "Dinner": [Meal(category: "Dinner", name: "Spaghetti", time: "8:00pm", emoji: "🍝", calories: 500, protein: 15, fat: 10, carbs: 60)]],
        13: ["Breakfast": [Meal(category: "Breakfast", name: "Cereal & Milk", time: "8:00am", emoji: "🥣", calories: 220, protein: 6, fat: 4, carbs: 30)],
             "Lunch": [Meal(category: "Lunch", name: "Sushi", time: "1:00pm", emoji: "🍣", calories: 280, protein: 18, fat: 5, carbs: 35)],
             "Snacks": [Meal(category: "Snacks", name: "Granola Bar", time: "3:30pm", emoji: "🍫", calories: 180, protein: 4, fat: 6, carbs: 22)],
             "Dinner": [Meal(category: "Dinner", name: "Grilled Chicken Salad", time: "7:30pm", emoji: "🥗", calories: 350, protein: 25, fat: 10, carbs: 15)]],
        14: ["Breakfast": [Meal(category: "Breakfast", name: "Pancake", time: "7:00am", emoji: "🥞", calories: 120, protein: 3, fat: 4, carbs: 20),
                            Meal(category: "Breakfast", name: "Coffee", time: "7:30am", emoji: "☕️", calories: 60, protein: 2, fat: 1, carbs: 5)],
             "Lunch": [Meal(category: "Lunch", name: "Chicken", time: "1:00pm", emoji: "🍗", calories: 300, protein: 25, fat: 15, carbs: 0)],
             "Snacks": [Meal(category: "Snacks", name: "Nuts", time: "4:00pm", emoji: "🥜", calories: 100, protein: 4, fat: 8, carbs: 6)],
             "Dinner": [Meal(category: "Dinner", name: "Oats", time: "8:00pm", emoji: "🥣", calories: 180, protein: 5, fat: 4, carbs: 28)]],
        15: ["Breakfast": [Meal(category: "Breakfast", name: "Scrambled Eggs", time: "7:30am", emoji: "🍳", calories: 140, protein: 12, fat: 10, carbs: 1)],
             "Lunch": [Meal(category: "Lunch", name: "Pasta", time: "12:45pm", emoji: "🍝", calories: 450, protein: 15, fat: 12, carbs: 50)],
             "Snacks": [Meal(category: "Snacks", name: "Banana", time: "4:15pm", emoji: "🍌", calories: 100, protein: 1, fat: 0, carbs: 27)],
             "Dinner": [Meal(category: "Dinner", name: "Beef Stew", time: "7:00pm", emoji: "🥘", calories: 420, protein: 30, fat: 20, carbs: 18)]],
        16: ["Breakfast": [Meal(category: "Breakfast", name: "Bagel & Cream Cheese", time: "8:15am", emoji: "🥯", calories: 300, protein: 9, fat: 12, carbs: 35)],
             "Lunch": [Meal(category: "Lunch", name: "Falafel Wrap", time: "12:00pm", emoji: "🌯", calories: 380, protein: 12, fat: 18, carbs: 40)],
             "Snacks": [Meal(category: "Snacks", name: "Chips", time: "3:00pm", emoji: "🍟", calories: 200, protein: 3, fat: 10, carbs: 25)],
             "Dinner": [Meal(category: "Dinner", name: "Tofu Curry", time: "7:30pm", emoji: "🍛", calories: 320, protein: 14, fat: 12, carbs: 30)]],
        17: ["Breakfast": [Meal(category: "Breakfast", name: "Muffin", time: "7:45am", emoji: "🧁", calories: 270, protein: 4, fat: 12, carbs: 35)],
             "Lunch": [Meal(category: "Lunch", name: "Burger", time: "1:00pm", emoji: "🍔", calories: 600, protein: 25, fat: 30, carbs: 45)],
             "Snacks": [Meal(category: "Snacks", name: "Orange", time: "4:30pm", emoji: "🍊", calories: 80, protein: 1, fat: 0, carbs: 20)],
             "Dinner": [Meal(category: "Dinner", name: "Pizza", time: "8:00pm", emoji: "🍕", calories: 550, protein: 20, fat: 25, carbs: 55)]]
    ]

    let weekdays = ["Tue", "Wed", "Thu", "Fri", "Sat", "Sun", "Mon"]
    let availableDays = Array(11...17)

    var body: some View {
        VStack(spacing: 16) {
            Text("Meal Planner")
                .font(.title2.bold())
                .padding(.top)

            // Calendar
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(availableDays, id: \.self) { day in
                        let index = day - 11
                        VStack {
                            Text(weekdays[index % 7]).font(.caption)
                            Text("\(day)").fontWeight(.bold)
                        }
                        .frame(width: 50, height: 64)
                        .background(day == selectedDay ? Color.blue : Color.gray.opacity(0.1))
                        .foregroundColor(day == selectedDay ? .white : .black)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .onTapGesture {
                            selectedDay = day
                        }
                    }
                }
                .padding(.horizontal)
            }

            // Meal List + Nutrition Summary
            if let meals = mealsData[selectedDay] {
                List {
                    ForEach(["Breakfast", "Lunch", "Snacks", "Dinner"], id: \.self) { category in
                        if let categoryMeals = meals[category] {
                            Section(header:
                                HStack {
                                    Text(category).font(.headline)
                                    Spacer()
                                    Text("\(categoryMeals.count) meals • \(categoryMeals.map { $0.calories }.reduce(0, +)) cal")
                                        .font(.caption).foregroundColor(.gray)
                                }
                            ) {
                                ForEach(categoryMeals) { meal in
                                    MealRow(meal: meal)
                                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                            Button(role: .destructive) {
                                                if let index = mealsData[selectedDay]?[category]?.firstIndex(of: meal) {
                                                    let removed = mealsData[selectedDay]?[category]?.remove(at: index)
                                                    deletedMealInfo = (selectedDay, category, removed!)
                                                    showUndo = true
                                                }
                                            } label: {
                                                Label("Delete", systemImage: "trash")
                                            }
                                        }
                                }
                            }
                        }
                    }

                    // Nutrition Summary Section
                    let allMeals = meals.values.flatMap { $0 }
                    let totalCalories = allMeals.map { $0.calories }.reduce(0, +)
                    let totalProtein = allMeals.map { $0.protein }.reduce(0, +)
                    let totalFat = allMeals.map { $0.fat }.reduce(0, +)
                    let totalCarbs = allMeals.map { $0.carbs }.reduce(0, +)

                    Section(header: Text("Nutrition Summary").font(.title3.bold())) {
                        nutritionRow(title: "Calories", value: Double(totalCalories), unit: "kCal", emoji: "🔥", max: 2500)
                        nutritionRow(title: "Protein", value: Double(totalProtein), unit: "g", emoji: "🍖", max: 150)
                        nutritionRow(title: "Fats", value: Double(totalFat), unit: "g", emoji: "🥜", max: 80)
                        nutritionRow(title: "Carbs", value: Double(totalCarbs), unit: "g", emoji: "🌾", max: 300)
                    }
                }
                .listStyle(InsetGroupedListStyle())
            }

            // Undo Button
            if showUndo, let info = deletedMealInfo {
                Button("Undo Delete") {
                    mealsData[info.day]?[info.category, default: []].append(info.meal)
                    deletedMealInfo = nil
                    showUndo = false
                }
                .padding()
                .background(Color.orange)
                .foregroundColor(.white)
                .clipShape(Capsule())
                .padding(.horizontal)
            }

            Spacer()
        }
    }

    func nutritionRow(title: String, value: Double, unit: String, emoji: String, max: Double) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text("\(title) \(emoji)").font(.subheadline)
                Spacer()
                Text("\(Int(value)) \(unit)").font(.caption)
            }
            ProgressView(value: value, total: max).accentColor(.purple)
        }
    }
}

// MARK: - Meal Row
struct MealRow: View {
    var meal: Meal
    var body: some View {
        HStack {
            Text(meal.emoji)
                .font(.system(size: 36))
                .frame(width: 50, height: 50)
                .background(Color.purple.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 12))
            VStack(alignment: .leading) {
                Text(meal.name).fontWeight(.semibold)
                Text(meal.time).font(.caption).foregroundColor(.gray)
            }
            Spacer()
        }
    }
}

// MARK: - Preview
struct FoodCheck_Previews: PreviewProvider {
    static var previews: some View {
        FoodCheck()
    }
}
