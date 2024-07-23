import Setting
import SwiftUI

struct SettingsView: View {
    /// Setting supports `@State`, `@AppStorage`, `@Published`, and more!
    @AppStorage("isOn") var isOn = false
    @AppStorage("isOnHaptic") var isOnHaptic = true
    @State var authViewModel: AuthViewModel
    @State private var cookie = UserDefaults.standard.integer(forKey: "cookie")
    var body: some View {
        /// Start things off with `SettingStack`.
        SettingStack {
            /// This is the main settings page.
            SettingPage(title: "Ayarlar") {
                SettingCustomView {
                    HStack{
                        Spacer()
                        Image("tedas-logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Spacer()
                    }
                    .frame(height: 150)
                    .padding(.horizontal , 16)
                    .shadow(radius: 10 , y: 10.4)
                    
                    Color.blue.opacity(0.5)
                        .opacity(1)
                        .cornerRadius(12)
                        .padding(6)
                        .overlay {
                            Color.blue
                                .opacity(0.1)
                                .cornerRadius(12)
                                .overlay {
                                    HStack {
                                        Group {
                                            if authViewModel.currentRole == .manager {
                                                Image(systemName: "person.badge.shield.checkmark")
                                                    .foregroundColor(.blue)
                                                    .font(.largeTitle)
                                            } else if authViewModel.currentRole == .securityChief {
                                                Image(systemName: "eye.trianglebadge.exclamationmark")
                                                    .foregroundColor(.blue)
                                                    .font(.largeTitle)
                                            } else if authViewModel.currentRole == .driver {
                                                Image(systemName: "steeringwheel")
                                                    .foregroundColor(.blue)
                                                    .font(.largeTitle)
                                            }
                                        }
                                        .padding(.trailing, 8)
                                        
                                        VStack(alignment: .leading) {
                                            // Fullname
                                            SettingText(title: "\(authViewModel.fullname)", foregroundColor: .black)
                                                .font(.headline)
                                                .bold()
                                                .fontWeight(.medium)
                                            
                                            // Current Role
                                            switch authViewModel.currentRole {
                                            case .manager:
                                                SettingText(title: "Makam", foregroundColor: .black)
                                            case .driver:
                                                SettingText(title: "Sürücü", foregroundColor: .black)
                                            case .securityChief:
                                                SettingText(title: "Güvenlik Şefi", foregroundColor: .black)
                                            case .none:
                                                Text("Error")
                                                    .foregroundColor(.red)
                                            }
                                        }
                                        
                                        Spacer()
                                    }
                                    .padding()
                                    
                                    .cornerRadius(12)
                                    
                                }//asdasdas
                        }
                        .frame(height: 150)
                        .padding(.horizontal , 16)
                    
                    
                    
                    
                    
                    
                }//TEDAS LOGO
                
                
                
                /// Use groups to group components together.
                SettingGroup(header: "Profil") {
                    /// Use any of the pre-made components...
                    SettingToggle(title: "Beni Hatırla!", isOn: $isOn)
                    SettingToggle(title: "Titreşim", isOn: $isOnHaptic)
            
                    //UserDefaults.standard.setValue(cookie, forKey: "cookie")
                    
                    /// ...or define your own ones!
                    
                    
                    /// Nest `SettingPage` inside other `SettingPage`s!
                    SettingPage(title: "Gelişmiş Ayarlar") {
                        SettingText(title: "I show up on the next page!" , foregroundColor: .blue)
                    }.previewIcon("gearshape")//gelişmiş ayarlar
                    
                    SettingPage(title: "Kişisel Bilgiler") {
                        SettingGroup {
                            SettingText(title: "Tam Ad: \(authViewModel.fullname)" , foregroundColor: .blue)
                        }
                        SettingGroup{
                            SettingText(title: "E-posta: \(authViewModel.email)" , foregroundColor: .blue)
                            SettingText(title: "Şifre: \(authViewModel.password)" , foregroundColor: .red.opacity(0.2) )
                        }
                        SettingGroup{
                            SettingText(title: "Yetki Kodu: \(String(describing: authViewModel.currentRole))" , foregroundColor: .black)
                        }
                    }.previewIcon("person.bust")//kişisel bilgiler
                    
                    
                    
                    SettingButton(title: "çıkış"){
                        Task{await authViewModel.logout()}
                        
                        
                    }
                }//Profil
            }
        }.navigationBarBackButtonHidden(true)
    }
}

#Preview {
    SettingsView(isOn: false, authViewModel: AuthViewModel())
}
