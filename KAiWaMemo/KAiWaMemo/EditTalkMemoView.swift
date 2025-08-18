import SwiftUI

struct EditTalkMemoView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = TalkMemoViewModel()
    @State private var title: String
    @State private var content: String
    @State private var date: Date
    @State private var topics: String
    @State private var summary: String
    var memo: TalkMemo

    init(memo: TalkMemo) {
        self.memo = memo
        _title = State(initialValue: memo.title)
        _content = State(initialValue: memo.content)
        _date = State(initialValue: memo.date)
        _topics = State(initialValue: memo.topics.joined(separator: ","))
        _summary = State(initialValue: memo.summary)
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Talk Memo Details")) {
                    TextField("Title", text: $title)
                    TextField("Content", text: $content)
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                    TextField("Topics", text: $topics)
                    TextField("Summary", text: $summary)
                }
            }
            .navigationTitle("Edit Talk Memo")
            .navigationBarItems(leading: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            }, trailing: Button("Save") {
                let updatedMemo = TalkMemo(id: memo.id, title: title, content: content, date: date, topics: topics.components(separatedBy: ","), summary: summary, clientID: memo.clientID)
                viewModel.updateTalkMemo(memo: updatedMemo)
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct EditTalkMemoView_Previews: PreviewProvider {
    static var previews: some View {
        EditTalkMemoView(memo: TalkMemo(id: "1", title: "Test Memo", content: "This is a test memo", date: Date(), topics: ["test", "swiftui"], summary: "This is a test summary", clientID: "123"))
    }
}
