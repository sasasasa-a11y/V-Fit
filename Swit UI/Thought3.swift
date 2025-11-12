import SwiftUI

// MARK: - Onboarding View (Thought3)
struct Thought3: View {
    var body: some View {
        
            GeometryReader { geometry in
                VStack(spacing: 0) {

                    // Top Background with Character Image
                    ZStack(alignment: .bottom) {
                        // Top background shape
                        TopCurvedBackground()
                            .fill(
                                LinearGradient(
                                    colors: [Color(red: 0.67, green: 0.83, blue: 1.0), Color(red: 0.6, green: 0.6, blue: 1.0)],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(height: geometry.size.height * 0.6)
                            .edgesIgnoringSafeArea(.top)
                        
                        Image(.thought3) // Replace with your image name
                            .resizable()
                            .scaledToFill()
                            .frame(height: geometry.size.height * 0.6)
                            .padding(.bottom, 30)
                    }

                    // Title and Subtitle
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Eat Well")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        
                        Text("Let's start a healthy lifestyle with us, we can determine your diet every day. healthy eating is fun")
                            .font(.body)
                            .foregroundColor(.gray)
                            .frame(height: 100)
                        
                    }
                    .padding(.horizontal, 30)
                    .padding(.top, 40)

                    Spacer()

                    // Next Button
                    HStack {
                        Spacer()
                        NavigationLink(destination: Thought4()) {
                            ZStack {
                                Circle()
                                    .fill(
                                        LinearGradient(
                                            colors: [Color.blue, Color.purple],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .frame(width: 60, height: 60)
                                    .shadow(radius: 5)

                                Image(systemName: "chevron.right")
                                    .foregroundColor(.white)
                                    .font(.system(size: 24, weight: .medium))
                            }
                        }
                        .padding(.trailing, 30)
                        .padding(.bottom, 30)
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                .background(Color.white)
                .edgesIgnoringSafeArea(.all)
            }
        }
    
}

// MARK: - Preview
struct Thought3_Previews: PreviewProvider {
    static var previews: some View {
        Thought3()
    }
}
