import SwiftUI

struct AddTalkMemoView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = TalkMemoViewModel()
    @State private var title = ""
    @State private var content = ""
    @State private var date = Date()
    @State private var topics = ""
    @State private var summary = ""
    var clientID: String

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
            .navigationTitle("Add Talk Memo")
            .navigationBarItems(leading: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            }, trailing: Button("Save") {
                let memo = TalkMemo(id: UUID().uuidString, title: title, content: content, date: date, topics: topics.components(separatedBy: ","), summary: summary, clientID: clientID)
                viewModel.addTalkMemo(memo: memo)
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct AddTalkMemoView_Previews: PreviewProvider {
    static var previews: some View {
        AddTalkMemoView(clientID: "123")
    }
}
