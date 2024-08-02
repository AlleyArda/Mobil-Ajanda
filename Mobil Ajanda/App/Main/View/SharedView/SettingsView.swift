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
                            Image("icon1")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                            .opacity(0.6)
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        Spacer()
                    }
                    .frame(height: 150)
                    .padding(.horizontal , 16)
                    .shadow(radius: 10 , y: 10.4)
                    
                    
                    Color.blue
                        .opacity(0.1)
                        .cornerRadius(12)
                        .shadow(color: .gray.opacity(0.3), radius: 10, x: 0, y: 5)
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
                                
                                VStack(alignment: .leading, spacing: -10) {
                                    // Fullname
                                    SettingText(title: "\(authViewModel.fullname)", foregroundColor: .black)
                                        .font(.headline)
                                        .bold()
                                    
                                        .fontWeight(.heavy)
                                    
                                    Divider()
                                    
                                    
                                    
                                    // Current Role
                                    switch authViewModel.currentRole {
                                    case .manager:
                                        SettingText(title: "Makam", foregroundColor: .black)
                                            .font(.subheadline)
                                            .fontWeight(.thin)
                                            .italic()
                                            .padding(.init(top: 5, leading: 0, bottom: 0, trailing: 0))
                                    case .driver:
                                        SettingText(title: "Sürücü", foregroundColor: .black)
                                            .font(.subheadline)
                                            .fontWeight(.regular)
                                            .italic()
                                            .padding(.init(top: 5, leading: 0, bottom: 0, trailing: 0))
                                    case .securityChief:
                                        SettingText(title: "Güvenlik Şefi", foregroundColor: .black)
                                            .font(.subheadline)
                                            .fontWeight(.regular)
                                            .italic()
                                            .padding(.init(top: 5, leading: 0, bottom: 0, trailing: 0))
                                    case .none:
                                        Text("Error")
                                            .foregroundColor(.red)
                                            .font(.subheadline)
                                            .fontWeight(.heavy)
                                    }
                                }//vstack
                                
                                Spacer()
                            }//stack
                            .padding()
                            .background(Color.white)
                            .cornerRadius(12)
                        }
                        .padding(.init(top: 60, leading: 10, bottom: 50, trailing: 10))
                    
                    
                    
                    
                    
                    
                    
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
                    
                    
                    
                    SettingButton(title: "Çıkış"){
                        Task{await authViewModel.logout()}
                        
                        
                    }
                }//Profil
            }
        }.navigationBarBackButtonHidden(true)
    }
}

struct SeetingsView_Preview: PreviewProvider{
    static var previews: some View{
        let authViewModel = AuthViewModel()
        authViewModel.currentRole = .manager
        authViewModel.fullname = "Ali Arda Kulaksız"
        authViewModel.currentUser = User(id: "1", name: "Ali Arda Kulaksız", email: "arda.kulaksiz@tedas.gov.tr", password: "123456", role: .manager)
        return SettingsView(isOn: true,isOnHaptic: true, authViewModel: authViewModel)
    }
}

