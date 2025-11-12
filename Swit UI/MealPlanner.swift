import SwiftUI
import Charts

// MARK: - Models
struct MealItem: Identifiable, Equatable {
    var id = UUID()
    var category: String
    var name: String
    var time: String
    var emoji: String
    var image: String
    var reminder: Bool
}

enum TrendDirection { case up, down }

struct WeeklyStat: Identifiable {
    let id = UUID()
    let day: String
    let value: Double
}

// MARK: - Main View
struct MealPlannerView: View {
    @State private var todayMeals: [MealItem] = [
        .init(category: "Breakfast", name: "Oaty Hug", time: "7:00 AM", emoji: "🥣", image: "", reminder: true),
        .init(category: "Breakfast", name: "Eggy Toast", time: "8:00 AM", emoji: "🍳", image: "", reminder: false),
        .init(category: "Lunch", name: "Tofu Toss", time: "1:00 PM", emoji: "🥗", image: "", reminder: true),
        .init(category: "Lunch", name: "Dal Roti Duo", time: "1:30 PM", emoji: "🍛", image: "", reminder: false),
        .init(category: "Snack", name: "Fruit Pop", time: "5:00 PM", emoji: "🍓", image: "", reminder: false),
        .init(category: "Dinner", name: "Egg Wrap Hug", time: "8:30 PM", emoji: "🥚", image: "", reminder: false)
    ]
    
    @State private var selectedCategory = "Breakfast"
    
    let weeklyData: [WeeklyStat] = [
        .init(day: "Sun", value: 60), .init(day: "Mon", value: 50),
        .init(day: "Tue", value: 65), .init(day: "Wed", value: 40),
        .init(day: "Thu", value: 70), .init(day: "Fri", value: 45),
        .init(day: "Sat", value: 60)
    ]
    
    var body: some View {
        
            ScrollView {
                VStack(spacing: 30) {
                    nutritionSection
                    dailyScheduleSection
                    todayMealsSection
                    findSomethingToEatSection
                }
                .padding(.vertical)
            }
            .navigationBarTitle("", displayMode: .inline)
        }
    

    // MARK: - Nutrition Section
    private var nutritionSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Meal Nutritions").font(.title2.bold()).padding(.horizontal)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    nutrientCard(title: "Calories", percent: 82, color: .blue, trend: .up)
                    nutrientCard(title: "Fibre", percent: 88, color: .green, trend: .up)
                    nutrientCard(title: "Fats", percent: 42, color: .red, trend: .down)
                    nutrientCard(title: "Sugar", percent: 39, color: .pink, trend: .down)
                }.padding(.horizontal)
            }
            Chart {
                ForEach(weeklyData) { stat in
                    LineMark(x: .value("Day", stat.day), y: .value("Value", stat.value))
                        .interpolationMethod(.catmullRom)
                        .foregroundStyle(.blue)
                        .symbol(Circle())
                }
            }
            .frame(height: 180)
            .padding(.horizontal)
        }
    }

    private func nutrientCard(title: String, percent: Int, color: Color, trend: TrendDirection) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(title).font(.subheadline.bold())
                Spacer()
                HStack(spacing: 4) {
                    Text("\(percent)%").font(.caption)
                        .foregroundColor(trend == .up ? .green : .red)
                    Image(systemName: trend == .up ? "arrow.up" : "arrow.down")
                        .font(.caption2)
                        .foregroundColor(trend == .up ? .green : .red)
                }
            }
            ProgressView(value: Double(percent), total: 100)
                .accentColor(color)
        }
        .padding()
        .frame(width: 160)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: .gray.opacity(0.1), radius: 2)
    }

    // MARK: - Daily Schedule Section
    private var dailyScheduleSection: some View {
        HStack {
            Text("Daily Meal Schedule")
                .font(.headline)
                .foregroundColor(.black)

            Spacer()

            NavigationLink(destination: FoodCheck()) {
                Text("Check")
                    .font(.subheadline.bold())
                    .foregroundColor(.white)
                    .padding(.horizontal, 18)
                    .padding(.vertical, 8)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.7), Color.purple.opacity(0.6)]),
                                       startPoint: .topLeading,
                                       endPoint: .bottomTrailing)
                    )
                    .clipShape(Capsule())
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white.opacity(0.6))
                .background(.ultraThinMaterial)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.white.opacity(0.3), lineWidth: 1)
        )
        .padding(.horizontal)
    }

    // MARK: - Today Meals Section
    private var todayMealsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Today Meals").font(.title2.bold()).padding(.horizontal)
            HStack {
                ForEach(["Breakfast", "Lunch", "Snack", "Dinner"], id: \.self) { cat in
                    Button(action: { selectedCategory = cat }) {
                        Text(cat)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                            .background(selectedCategory == cat ? Color.blue : Color.gray.opacity(0.2))
                            .foregroundColor(selectedCategory == cat ? .white : .black)
                            .cornerRadius(20)
                    }
                }
            }.padding(.leading)

            ForEach(filteredMealBindings(), id: \.id) { $meal in
                NavigationLink(destination: navigateToDishDetail(meal: meal)) {
                    MealRowView(meal: meal)
                }
            }
        }
    }

    private func filteredMealBindings() -> [Binding<MealItem>] {
        todayMeals.enumerated().compactMap { idx, meal in
            meal.category == selectedCategory ? $todayMeals[idx] : nil
        }
    }

    // MARK: - Find Something to Eat Section
    private var findSomethingToEatSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Find Something to Eat").font(.title2.bold()).padding(.horizontal)
            let columns = [GridItem(.flexible()), GridItem(.flexible())]
            LazyVGrid(columns: columns, spacing: 16) {
                categoryBox(title: "Breakfast", foods: breakfastFoods, color: .blue)
                categoryBox(title: "Lunch", foods: lunchFoods, color: .pink)
                categoryBox(title: "Snack", foods: snackFoods, color: .orange)
                categoryBox(title: "Dinner", foods: dinnerFoods, color: .purple)
            }
            .padding(.horizontal)
        }
    }

    private func categoryBox(title: String, foods: [String], color: Color) -> some View {
        let emoji = categoryEmojiMap[title] ?? "🍽️"
        return NavigationLink(destination: CategoryDetailView(title: title, foods: foods, color: color)) {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text("\(emoji) \(title)").font(.headline)
                    Spacer()
                    Text("Select")
                        .font(.caption.bold())
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(color.opacity(0.2))
                        .clipShape(Capsule())
                }
                Spacer()
                Text("\(foods.count) items").font(.caption).foregroundColor(.gray)
            }
            .padding()
            .frame(minHeight: 150)
            .background(color.opacity(0.05))
            .cornerRadius(16)
        }
    }

    // MARK: - Dish Navigation
    @ViewBuilder
    func navigateToDishDetail(meal: MealItem) -> some View {
        switch meal.name {
        case "Oaty Hug": OatyHugDetailView()
        case "Eggy Toast": EggyToastDetailView()
        case "Morning Poha": MorningPohaDetailView()
        case "Nutty Toast": NuttyToastDetailView()
        case "Berry Bowl": BerryBowlDetailView()
        case "Chia Cup": ChiaCupDetailView()
        case "Grill Bowl": GrillBowlDetailView()
        case "Tofu Toss": TofuTossDetailView()
        case "Dal Roti Duo": DalRotiDuoDetailView()
        case "Chickpea Crunch": ChickpeaCrunchDetailView()
        case "Egg Curry Magic": EggCurryMagicDetailView()
        case "Fish Fix": FishFixDetailView()
        case "Nut Bites": NutsBitesDetailView()
        case "Fruit Pop": FruitPopDetailView()
        case "Boiled Buds": BoiledBudsDetailView()
        case "Paneer Cubes": PaneerCubesDetailView()
        case "Corn Toss": CornTossDetailView()
        case "Soup & Eggs": SoupAndEggsDetailView()
        case "Tikka Toss": TikkaTossDetailView()
        case "Pepper Pop": PepperPopDetailView()
        case "Dal Sip": DalSipDetailView()
        case "Egg Wrap Hug": EggWrapHugDetailView()
        case "Tofu Bowl": TofuBowlDetailView()
        default: DishDetailView(meal: meal)
        }
    }
}

// MARK: - Category Detail View
struct CategoryDetailView: View {
    var title: String
    var foods: [String]
    var color: Color

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(foods, id: \.self) { food in
                    let meal = MealItem(
                        category: title,
                        name: food,
                        time: "Not Scheduled",
                        emoji: emojiMap[food] ?? "🍽️",
                        image: "",
                        reminder: false
                    )
                    NavigationLink(destination: MealPlannerView().navigateToDishDetail(meal: meal)) {
                        HStack {
                            Text(meal.emoji).font(.system(size: 40))
                            Text(meal.name).font(.headline)
                            Spacer()
                            Image(systemName: "chevron.right").foregroundColor(.gray)
                        }
                        .padding()
                        .background(color.opacity(0.1))
                        .cornerRadius(12)
                    }
                }
            }
            .padding()
        }
        .navigationTitle(title)
    }
}

// MARK: - Generic Dish Detail View
struct DishDetailView: View {
    var meal: MealItem
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            Text(meal.emoji).font(.system(size: 80))
            Text(meal.name).font(.largeTitle.bold())
            Text("Scheduled at: \(meal.time)").foregroundColor(.gray)
            Spacer()
        }
        .padding()
        .navigationTitle(meal.name)
    }
}

// MARK: - Placeholder
struct FoodCheckView: View {
    var body: some View {
        Text("Food Check View")
            .font(.largeTitle.bold())
            .padding()
    }
}

// MARK: - Meal Row View
struct MealRowView: View {
    var meal: MealItem
    var body: some View {
        HStack(spacing: 16) {
            Text(meal.emoji).font(.system(size: 40))
            VStack(alignment: .leading) {
                Text(meal.name).font(.headline)
                Text(meal.time).font(.subheadline).foregroundColor(.gray)
            }
            Spacer()
            Image(systemName: "chevron.right").foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: .gray.opacity(0.1), radius: 2)
        .padding(.horizontal)
    }
}

// MARK: - Static Dishes
let breakfastFoods = ["Oaty Hug", "Eggy Toast", "Morning Poha", "Nutty Toast", "Berry Bowl", "Chia Cup"]
let lunchFoods = ["Tofu Toss", "Dal Roti Duo", "Chickpea Crunch", "Egg Curry Magic", "Fish Fix", "Grill Bowl"]
let snackFoods = ["Nut Bites", "Fruit Pop", "Boiled Buds", "Paneer Cubes", "Corn Toss"]
let dinnerFoods = ["Soup & Eggs", "Tikka Toss", "Pepper Pop", "Dal Sip", "Egg Wrap Hug", "Tofu Bowl"]

// MARK: - Emoji Maps
let emojiMap: [String: String] = [
    "Oaty Hug": "🥣", "Eggy Toast": "🍳", "Morning Poha": "🍚", "Nutty Toast": "🍞",
    "Berry Bowl": "🫐", "Chia Cup": "🍶", "Grill Bowl": "🍲", "Tofu Toss": "🥗",
    "Dal Roti Duo": "🍛", "Chickpea Crunch": "🌰", "Egg Curry Magic": "🥘", "Fish Fix": "🐟",
    "Nut Bites": "🥜", "Fruit Pop": "🍓", "Boiled Buds": "🥦", "Paneer Cubes": "🧀",
    "Corn Toss": "🌽", "Soup & Eggs": "🍵", "Tikka Toss": "🍢", "Pepper Pop": "🌶️",
    "Dal Sip": "🥣", "Egg Wrap Hug": "🥚", "Tofu Bowl": "🍱"
]

let categoryEmojiMap: [String: String] = [
    "Breakfast": "🌞", "Lunch": "🍱", "Snack": "🍪", "Dinner": "🌙"
]

// MARK: - Preview
struct MealPlannerView_Previews: PreviewProvider {
    static var previews: some View {
        MealPlannerView()
    }
}
