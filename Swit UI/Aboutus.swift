import SwiftUI

struct AboutUsView: View {
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color.purple.opacity(0.2), Color.blue.opacity(0.1)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("About V-FIT")
                        .font(.largeTitle.bold())
                        .foregroundColor(.blue)

                    Text("""
Welcome to V-FIT — your all-in-one fitness companion. Whether you’re tracking your workouts, planning meals, or monitoring your sleep, V-FIT empowers you to live healthier every day.

We care about your journey, and we’re here to support you every step of the way.
""")
                        .font(.body)
                        .foregroundColor(.black)

                    Image(systemName: "heart.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .foregroundColor(.purple.opacity(0.7))
                        .padding(.top)

                    Spacer()
                }
                .padding()
            }
        }
        .navigationTitle("About Us")
    }
}


#Preview {
    AboutUsView()
}
