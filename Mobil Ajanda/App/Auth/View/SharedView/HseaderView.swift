import SwiftUI
//jul 9 15.06
struct HeaderView: View {
    let title : String
    let subTitle : String

    let background: Color
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                .foregroundStyle(background.gradient)
                .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/.opacity(0.3), radius: 20 , x: 0 , y: 10)

            
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
                    
                
                Image("tedas-logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/ , height: 100)
                    .padding()
                    .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/.opacity(0.3), radius: 20 , x: 0 , y: 10)
                    
                    
                    
            }

        }
        
    }
}

#Preview {
    HeaderView(title: "Hoşgeldiniz", subTitle: "Mobil Ajanda", background: .blue.opacity(0.7))
}
