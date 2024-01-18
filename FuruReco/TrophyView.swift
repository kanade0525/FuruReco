import SwiftUI

// 実績のデータ構造
struct Trophy {
    let title: String
    let subtitle: String
    let target: Int
    let currentCalculator: () -> Int

    // current を計算する関数を呼ぶプロパティ
    var current: Int {
        currentCalculator()
    }
}

struct TrophyView: View {
    // 動的な実績データ
    let trophies: [Trophy] = [
        Trophy(title: "ふるさと納税ビギナー", subtitle: "1自治体に寄附する", target: 1, currentCalculator: { selectedCitiesCount() }),
        Trophy(title: "ふるさと納税ノービス", subtitle: "3自治体に寄附する", target: 3, currentCalculator: { selectedCitiesCount() }),
        Trophy(title: "ふるさと納税アマチュア", subtitle: "5自治体に寄附する", target: 5, currentCalculator: { selectedCitiesCount() }),
        Trophy(title: "ふるさと納税ベテラン", subtitle: "10自治体に寄附する", target: 10, currentCalculator: { selectedCitiesCount() }),
        Trophy(title: "ふるさと納税エキスパート", subtitle: "15自治体に寄附する", target: 15, currentCalculator: { selectedCitiesCount() }),
        Trophy(title: "ふるさと納税プロフェッショナル", subtitle: "30自治体に寄附する", target: 30, currentCalculator: { selectedCitiesCount() }),
        Trophy(title: "ふるさと納税マスター", subtitle: "50自治体に寄附する", target: 50, currentCalculator: { selectedCitiesCount() }),
        Trophy(title: "ふるさと黒帯", subtitle: "100自治体に寄附する", target: 100, currentCalculator: { selectedCitiesCount() }),
        Trophy(title: "ふるさと免許皆伝", subtitle: "250自治体に寄附する", target: 250, currentCalculator: { selectedCitiesCount() }),
        Trophy(title: "ふるさと師範代", subtitle: "500自治体に寄附する", target: 500, currentCalculator: { selectedCitiesCount() }),
        Trophy(title: "ふるさと納税仙人", subtitle: "1000自治体に寄附する", target: 1000, currentCalculator: { selectedCitiesCount() }),
        Trophy(title: "ふるさと納税神", subtitle: "全自治体に寄附する", target: 1747, currentCalculator: { selectedCitiesCount() })

    ]

    var body: some View {
        NavigationView {
            // トロフィーの一覧を表示
            List {
                ForEach(trophies, id: \.title) { trophy in
                    TrophyRow(trophy: trophy)
                }
            }
            .navigationTitle("実績一覧")
        }
    }
}

func selectedCitiesCount() -> Int {
    return UserDefaults.standard.array(forKey: "selectedCities")?.count ?? 0
}

struct TrophyRow: View {
    let trophy: Trophy

    var body: some View {
        HStack {
            Image(systemName: "trophy.fill")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(trophy.current >= trophy.target ? .yellow : .gray)

            VStack(alignment: .leading, spacing: 4) {
                Text(trophy.title)
                    .font(.system(size: 18, weight: .bold))
                Spacer().frame(height: 4)
                Text(trophy.subtitle)
                    .foregroundColor(.gray.opacity(0.8))
                    .font(.system(size: 12, weight: .light))
                // Cityの都道府県名を表示
                Text("達成率: \(trophy.currentCalculator())/\(trophy.target)")
                    .foregroundColor(.gray.opacity(0.8))
                    .font(.system(size: 12, weight: .light))

                CustomProgressBar(percentage: Double(trophy.current) / Double(trophy.target) * 100)
                    .frame(height: 10)
            }

            Spacer()
        }
        .padding(.vertical, 8)
    }
}

struct CustomProgressBar: View {
    let percentage: Double

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(Color.gray)

                Rectangle()
                    .frame(width: min(CGFloat(percentage) / 100 * geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(Color.blue)
            }
            .cornerRadius(5.0)
        }
    }
}

struct TrophyView_Previews: PreviewProvider {
    static var previews: some View {
        TrophyView()
    }
}
