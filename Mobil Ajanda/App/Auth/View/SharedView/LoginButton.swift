

import SwiftUI
//jul 9 15.06
struct LoginButton: View {
    let title : String
    let background : Color
    let action : () -> Void

    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(background)
                Text(title)
                    .foregroundStyle(.white)
                    .bold()
                    .padding(10)
            }
        }
    }
}

#Preview {
    LoginButton(title: "Giriş Yap", background: .blue){
        
    }
}
