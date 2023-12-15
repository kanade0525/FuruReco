import SwiftUI

/// チェックボックスを表示するView
struct CheckBoxView: View {
    /// チェックの状態を管理するためのBinding
    @Binding var isSelected: Bool

    var body: some View {
        // チェックボックスをタップしたときに実行されるアクション
        Button(action: {
            // チェックの状態を反転させる
            isSelected.toggle()
        }) {
            // チェックの状態に応じて表示する画像を切り替える
            Image(systemName: isSelected ? "checkmark.square.fill" : "square")
                .resizable()
                .frame(width: 24, height: 24)
                // チェックされている場合は青色、そうでない場合はグレー色にする
                .foregroundColor(isSelected ? .blue : .gray)
        }
    }
}
