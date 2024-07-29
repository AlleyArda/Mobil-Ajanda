import SwiftUI

struct HeaderView: View {
    let title: String
    let subTitle: String
    @State private var titleOpacity: Double = 0.0
    @State private var subTitleOpacity: Double = 0.0
    @State private var logoAnimation = false
    let background: Color

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .foregroundStyle(background.gradient)
                .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 10)

            VStack {
                Text(title)
                    .font(.system(size: 40))
                    .foregroundStyle(.white)
                    .bold()
                    .opacity(titleOpacity)
                    .onAppear {
                        withAnimation(Animation.easeOut(duration: 2.0)) {
                            self.titleOpacity = 1.0
                        }
                    }

                Text(subTitle)
                    .font(.system(size: 20))
                    .italic()
                    .bold()
                    .foregroundStyle(.white)
                    .opacity(subTitleOpacity)
                    .onAppear {
                        withAnimation(Animation.easeOut(duration: 2.0).delay(1.0)) {
                            self.subTitleOpacity = 1.0
                        }
                    }

                Image("tedas-logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .padding()
                    .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 10)
                    .scaleEffect(logoAnimation ? 1.0 : 1.2)
                    .opacity(logoAnimation ? 0.7 : 1.0)
                    .onAppear {
                        withAnimation(Animation.easeInOut(duration: 2.0).repeatForever(autoreverses: true).delay(2.0)) {
                            self.logoAnimation = true
                        }
                    }
            }
        }
    }
}

#Preview {
    HeaderView(title: "Hoşgeldiniz", subTitle: "Mobil Ajanda", background: .blue.opacity(0.7))
}
