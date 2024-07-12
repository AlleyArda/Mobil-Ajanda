import SwiftUI

struct TopView: View {
    @State var viewmodel = AuthViewModel()
    var title: String = ""
    var subtitle: String = ""
    var background: Color
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .foregroundStyle(background.gradient)
                .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 10)
            
            HStack {
                VStack {
                    Image("tedas-logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 10)
                    
                    ZStack {
                        Image(systemName: "calendar")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 30)
                            .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 10)
                        
                        Text(currentDay())
                            .font(.headline)
                            .foregroundColor(.white)
                            .bold()
                    }
                    .padding(.top)
                    .padding(.bottom)
                }//V
                
                Spacer()
                
                VStack {
                    Text(title)
                        .bold()
                        .font(.headline)
                    .frame(width: 150)
                    
                    Text(subtitle)
                        .bold()
                        .font(.footnote)
                        .frame(width: 150)
                }
                
                Spacer()
                
                ProfileButton(background: .red) {
                    Task {
                        await viewmodel.logout()
                    }
                }
                
            }//H
            .padding(.top)
            .padding(.top)
            .padding(.top)
            .padding()
        }
        .frame(height: 150)
    }
    
   
    
}

#Preview {
    
        Group{
            TopView(title: "Toplantılar", subtitle: "BUGÜN" , background: .blue)
            Spacer()
            TopView(title: "Toplantılar", subtitle: "TÜM" ,background: .blue)
        }
    }
    
