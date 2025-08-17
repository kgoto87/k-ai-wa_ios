import Foundation
import FirebaseFirestore

struct Client: Identifiable, Codable {
    @DocumentID var id: String?
    var name: String
    var externalId: String
    var userId: String // To associate the client with a user
}
