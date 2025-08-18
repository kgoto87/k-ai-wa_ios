import Foundation

struct TalkMemo: Identifiable, Codable {
    var id: String
    var title: String
    var content: String
    var date: Date
    var topics: [String]
    var summary: String
    var clientID: String
}
