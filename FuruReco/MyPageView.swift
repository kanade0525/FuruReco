import SwiftUI
import UIKit

struct MyPageView: View {
    @State private var userName: String = ""
    @State private var isClearConfirmationAlertPresented = false
    @State private var isCompletionAlertPresented = false

    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                // selectedCitiesのパーセント表記を表示
                Text("ふるさと納税達成率: \(calculateSelectedCitiesPercentage())%")
                    .font(.headline)
                    .padding()
                Text("\(selectedCitiesCount()) 自治体")
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

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView()
    }
}

// UIImagePickerControllerをラップするシンプルなImagePicker
//struct ImagePicker: UIViewControllerRepresentable {
//    @Binding var selectedImage: Image?
//    @Environment(\.presentationMode) private var presentationMode
//
//    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
//        var parent: ImagePicker
//
//        init(parent: ImagePicker) {
//            self.parent = parent
//        }
//
//        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//            if let uiImage = info[.originalImage] as? UIImage {
//                parent.selectedImage = Image(uiImage: uiImage)
//            }
//            parent.presentationMode.wrappedValue.dismiss()
//        }
//    }
//
//    func makeCoordinator() -> Coordinator {
//        return Coordinator(parent: self)
//    }
//
//    func makeUIViewController(context: Context) -> UIImagePickerController {
//        let picker = UIImagePickerController()
//        picker.delegate = context.coordinator
//        return picker
//    }
//
//    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
//        // No-op
//    }
//}
