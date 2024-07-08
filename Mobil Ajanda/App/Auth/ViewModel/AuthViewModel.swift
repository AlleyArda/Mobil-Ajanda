import Foundation
import Observation

@Observable
class AuthViewModel {
    
    var email: String = ""
    var password : String = ""
    var errorMessage: String = ""
    var showError: Bool = false
    
    func login() {
        guard validate() else {
            return
        }
        
        
        // Buraya Login işlemi için gerekli kodları yazacaksın.
    }
    
    private func validate() -> Bool{
        errorMessage = ""
        showError = false
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Tüm alanları doldurunuz."
            showError = true
            return false
        }
        
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Geçerli bir email adresi giriniz."
            showError = true
            return false
        }
        return true
    }
    
    private func logout(){
        
        // Buraya Logout işlemi için gerekli kodları yazacaksın.
        
    }
    
}
