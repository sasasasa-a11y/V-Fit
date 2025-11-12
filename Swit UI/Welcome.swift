import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    Spacer()
                    
                    // Title
                    Text("V Fitness")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [Color.blue.opacity(0.8), Color.purple.opacity(0.8)],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )

                    // Subtitle
                    Text("Everybody Can Train")
                        .font(.system(size: 18))
                        .foregroundColor(.gray)
                        .padding(.top, 5)

                    Spacer()

                    // Navigation Link as Button
                    NavigationLink(destination: Thought1()) {
                        Text("Get Started")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(width: geometry.size.width * 0.8, height: 55)
                            .background(
                                LinearGradient(
                                    colors: [Color.blue.opacity(0.8), Color.purple.opacity(0.8)],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(40)
                            .shadow(color: .gray.opacity(0.4), radius: 5, x: 0, y: 5)
                    }
                    .padding(.bottom, 40)
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                .background(Color.white)
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}

// Dummy LoginView for navigation
struct LoginView: View {
    var body: some View {
        Text("Login Screen")
            .font(.title)
            .navigationBarTitle("login", displayMode: .inline)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}


