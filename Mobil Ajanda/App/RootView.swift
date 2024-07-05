//
//  RootView.swift
//  Mobil Ajanda
//
//  Created by Arda Kulaksız on 5.07.2024.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView{
                    ForEach(0..<40) { item in
                        VStack {
                            Text("Hello, World!")
                                .bold()
                                .background(.red)
                            
                            Text("Merhaba Arda!")
                                .bold()
                                .background(.red)
                        }
                        .frame(maxWidth: .infinity)

                        
                    }
                }
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.yellow)
            .navigationTitle("Başlık")

        }
        
    }
}


#Preview {
    RootView()
}
