import Setting
import SwiftUI

struct SettingsView: View {
    /// Setting supports `@State`, `@AppStorage`, `@Published`, and more!
    @AppStorage("isOn") var isOn = false

    var body: some View {
        /// Start things off with `SettingStack`.
        SettingStack {
            /// This is the main settings page.
            SettingPage(title: "Ayarlar") {
                /// Use groups to group components together.
                SettingGroup(header: "Main Group") {
                    /// Use any of the pre-made components...
                    SettingToggle(title: "Beni Hatırla!", isOn: $isOn)

                    /// ...or define your own ones!
                    SettingCustomView {
                        Image("tedas-logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 160)
                            .padding(20)
                    }

                    /// Nest `SettingPage` inside other `SettingPage`s!
                    SettingPage(title: "Advanced Settings") {
                        SettingText(title: "I show up on the next page!" , foregroundColor: .blue)
                    }
                }
            }
        }
    }
}

#Preview {
    SettingsView(isOn: false)
}
