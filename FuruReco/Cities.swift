import Foundation

// Codableプロトコルを適用することで、JSON形式などの外部データとの相互変換を容易にする
struct CitiesResponse: Codable {
    let cities: [Cities]
}

// Hashableプロトコルを適用することで、セットやディクショナリなどのデータ構造で使用可能
struct Cities: Codable, Hashable {
    let id: Int                  // 都市の一意の識別子
    let code: String             // 都市の団体コード
    let prefectureName: String   // 都市の所在する都道府県名
    let name: String             // 都市の名前

    enum CodingKeys: String, CodingKey {
        // JSONキーとプロパティ名の対応を指定
        case id
        case code
        case prefectureName
        case name
    }
}

// Codableプロトコルに適合するため、CodingKeysが必要。
// Hashableプロトコルに適合するため、各プロパティはハッシュ可能である必要があります。
