import Foundation
import FirebaseFirestore

class TalkMemoViewModel: ObservableObject {
    @Published var talkMemos = [TalkMemo]()

    private var db = Firestore.firestore()

    func addTalkMemo(memo: TalkMemo) {
        // Add a new document with a generated ID
        do {
            _ = try db.collection("talkMemos").addDocument(from: memo)
        } catch {
            print("Error adding talk memo: \(error)")
        }
    }

    func updateTalkMemo(memo: TalkMemo) {
        do {
            try db.collection("talkMemos").document(memo.id).setData(from: memo)
        } catch {
            print("Error updating talk memo: \(error)")
        }
    }

    func deleteTalkMemo(memo: TalkMemo) {
        db.collection("talkMemos").document(memo.id).delete() { err in
            if let err = err {
                print("Error removing talk memo: \(err)")
            } else {
                print("Talk memo successfully removed!")
            }
        }
    }

    func fetchTalkMemos(clientID: String) {
        db.collection("talkMemos").whereField("clientID", isEqualTo: clientID)
            .addSnapshotListener { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }

                self.talkMemos = documents.map { queryDocumentSnapshot -> TalkMemo in
                    let data = queryDocumentSnapshot.data()
                    let id = queryDocumentSnapshot.documentID
                    let title = data["title"] as? String ?? ""
                    let content = data["content"] as? String ?? ""
                    let date = (data["date"] as? Timestamp)?.dateValue() ?? Date()
                    let topics = data["topics"] as? [String] ?? []
                    let summary = data["summary"] as? String ?? ""
                    let clientID = data["clientID"] as? String ?? ""
                    return TalkMemo(id: id, title: title, content: content, date: date, topics: topics, summary: summary, clientID: clientID)
                }
            }
    }
}
