//
//  HeaderView.swift
//  Mobil Ajanda
//
//  Created by Fatih Durmaz on 8.07.2024.
//

import SwiftUI

struct HeaderView: View {
    let title : String
    let subTitle : String
    let angle : Double
    let background: Color
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 0)
                .foregroundStyle(background.gradient)
                .rotationEffect(Angle(degrees: angle))
            
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
            .padding(.top, 120)
        }
        .frame(width: UIScreen.main.bounds.width * 2, height: UIScreen.main.bounds.height * 0.5)
        .offset(y:-(UIScreen.main.bounds.height * 0.2))
        
    }
}

#Preview {
    HeaderView(title: "Hoşgeldiniz", subTitle: "Mobil Ajanda", angle: 15, background: .blue)
}
