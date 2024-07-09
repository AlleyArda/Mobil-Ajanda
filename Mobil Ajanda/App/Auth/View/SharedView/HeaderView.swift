import SwiftUI
//jul 9 15.06
struct HeaderView: View {
    let title : String
    let subTitle : String

    let background: Color
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 0)
                .foregroundStyle(background.gradient)

            
            VStack {
                Text(title)
                    .font(.system(size: 40))
                    .foregroundStyle(.white)
                    .bold()
                
                Text(subTitle)
                    .font(.system(size: 20))
                    .italic()
                    .bold()
                    .foregroundStyle(.white)
            }

        }
        
    }
}

#Preview {
    HeaderView(title: "Hoşgeldiniz", subTitle: "Mobil Ajanda", background: .blue)
}
