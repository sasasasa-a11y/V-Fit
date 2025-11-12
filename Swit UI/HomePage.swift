import SwiftUI

struct HomePage: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
       
            VStack(spacing: 30) {
                // Back Button
                HStack {
                    Button(action: {
                        dismiss() // Dismiss current view
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.blue)
                            .font(.title2)
                            .padding()
                    }
                    Spacer()
                }

                // Illustration
                Image(.homepage) // Replace with actual image name
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)

                // Welcome Message
                Text("Welcome ")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)

                Text("You are all set now, let’s reach your goals together with us")
                    .font(.body)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                Spacer()

                // Navigation Button
                NavigationLink(destination: Activity1()) {
                    Text("Go To Home")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(
                            LinearGradient(colors: [Color.blue.opacity(0.8), Color.purple.opacity(0.8)],
                                           startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                        .cornerRadius(40)
                        .shadow(radius: 5)
                        .padding(.horizontal)
                }

                Spacer().frame(height: 30)
            }
            .navigationBarHidden(true)
            .background(Color.white.edgesIgnoringSafeArea(.all))
        }
    }


// Dummy Home Screen
struct MainHomeScreen: View {
    var body: some View {
        VStack {
            Text("Main Home Screen")
                .font(.largeTitle)
        }
        .navigationTitle("Home")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// Preview
struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
