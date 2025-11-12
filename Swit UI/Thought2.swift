import SwiftUI

// MARK: - Onboarding View (Thought2)
struct Thought2: View {
    var body: some View {
       
            GeometryReader { geometry in
                VStack(spacing: 0) {

                    // Top Background with Character Image
                    ZStack(alignment: .bottom) {
                        // Top curved gradient background
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

                        // Character image
                        Image(.thought2) // Replace with actual image name
                            .resizable()
                            .scaledToFill()
                            .frame(height: geometry.size.height * 0.5)
                            .padding(.bottom, 50)
                    }

                    // Title and Description
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Get Burn")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.black)

                        Text("Let’s keep burning, to achieve your goals, it hurts only temporarily. If you give up now you will be in pain forever.")
                            .font(.body)
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal, 30)
                    .padding(.top, 60)

                    Spacer()

                    // Next Button
                    HStack {
                        Spacer()
                        NavigationLink(destination: Thought3()) {
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

// MARK: - Top Curved Background Shape
struct TopCurvedBackground: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: rect.height * 0.3))
        path.addQuadCurve(to: CGPoint(x: rect.width, y: rect.height * 0.3),
                          control: CGPoint(x: rect.width / 2, y: rect.height * 0.0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        path.addLine(to: CGPoint(x: 0, y: 0))
        path.closeSubpath()
        return path
    }
}

// MARK: - Preview
struct Thought2_Previews: PreviewProvider {
    static var previews: some View {
        Thought2()
    }
}
