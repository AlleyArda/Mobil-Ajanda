import SwiftUI

struct ExitButton: View {
    
    let background: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text("Çıkış")
                .foregroundColor(.white)
                .font(.headline)
                .frame(maxWidth: .infinity, minHeight: 50) // Yatayda maksimum genişlik ve sabit yükseklik
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).foregroundStyle(background))
                .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
        }
        .padding(.horizontal) // Butonun kenar boşlukları
    }
}

#Preview {
    ExitButton(background: .red) {
        print("Çıkış yapıldı")
    }
}
