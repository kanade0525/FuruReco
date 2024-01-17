import SwiftUI
import UIKit

struct MyPageView: View {
    @State private var userName: String = ""
    @State private var isClearConfirmationAlertPresented = false
    @State private var isCompletionAlertPresented = false
    @State private var userData: UserData?

    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                // selectedCitiesのパーセント表記を表示
                Text("ふるさと納税達成率: \(userData?.selectedCitiesPercentage ?? "")%")
                    .font(.headline)
                    .padding()
                Text("\(userData?.selectedCitiesCount ?? "") 自治体")
                HStack(alignment: .center) {
                    Image(systemName: "person.circle")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                }
                .padding()

                TextField("ユーザー名", text: $userName)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle()) // テキストフィールドに枠を追加
                    .multilineTextAlignment(.center)
                Button("保存") {
                    saveUserInfo()
                }
                .buttonStyle(MyButtonStyle())
                .padding()
                Button("ふるさと納税記録の初期化") {
                    clearSelectedCities()
                }
                .padding()
                Spacer()
            }
            .padding()
            .alert(isPresented: $isClearConfirmationAlertPresented, content: {
                isClearConfirmationAlert
            })
//            .alert(isPresented: $isCompletionAlertPresented, content: {
//                completionAlert
//            })
            .onAppear {
                // ビューが表示されたときにユーザーデータをロード
                loadUserInfo()
                updateUserData()
            }
            .navigationTitle("マイページ")
        }
    }
    
    //  UserDefault系
    private func loadUserInfo() {
        if let savedUserName = UserDefaults.standard.string(forKey: "userName") {
            userName = savedUserName
        }
    }
    
    // ユーザーデータを更新するメソッド
    private func updateUserData() {
        userData = UserData(selectedCitiesCount: selectedCitiesCount(), selectedCitiesPercentage: calculateSelectedCitiesPercentage())
    }

    private func saveUserInfo() {
        UserDefaults.standard.set(userName, forKey: "userName")

        isCompletionAlertPresented = true
    }
    
    private func clearSelectedCities() {
        UserDefaults.standard.removeObject(forKey: "selectedCities")
        
        isClearConfirmationAlertPresented = true
    }
    
    //  アラート系
    private var isClearConfirmationAlert: Alert {
        Alert(
            title: Text("本当によろしいですか？"),
            message: Text("この操作は元に戻すことができません"),
            primaryButton: .destructive(Text("はい"), action: {
                clearSelectedCities()
                isCompletionAlertPresented = true
            }),
            secondaryButton: .cancel(Text("いいえ"))
        )
    }

//    private var completionAlert: Alert {
//        Alert(
//            title: Text("完了しました"),
//            dismissButton: .default(Text("OK"))
//        )
//    }
    
    //    ふるさと納税達成率の計算ロジック
    private func calculateSelectedCitiesPercentage() -> String {
        let selectedCitiesCount = UserDefaults.standard.array(forKey: "selectedCities")?.count ?? 0
        let totalCitiesCount = 1747
        let percentage = Double(selectedCitiesCount) / Double(totalCitiesCount) * 100.0
        return String(format: "%.1f", percentage)
    }
    
    private func selectedCitiesCount() -> String {
        let selectedCitiesCount = UserDefaults.standard.array(forKey: "selectedCities")?.count ?? 0
        return String(selectedCitiesCount)
    }
}

struct MyButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding()
            .foregroundColor(.white)
            .background(configuration.isPressed ? Color.gray : Color.blue)
            .cornerRadius(10)
    }
}

struct UserData {
    var selectedCitiesCount: String = "0"
    var selectedCitiesPercentage: String = "0.0"
}

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView()
    }
}
