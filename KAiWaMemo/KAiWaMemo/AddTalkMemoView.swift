import SwiftUI
import AVFoundation
import Speech

struct AddTalkMemoView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = TalkMemoViewModel()
    @State private var title = ""
    @State private var content = ""
    @State private var date = Date()
    @State private var topics = ""
    @State private var summary = ""
    var clientID: String

    @State private var audioRecorder: AVAudioRecorder?
    @State private var audioPlayer: AVAudioPlayer?
    @State private var isRecording = false
    @State private var recordingTime: TimeInterval = 0
    @State private var timer: Timer?

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

                Section(header: Text("Audio Recording")) {
                    HStack {
                        Button(action: {
                            if isRecording {
                                stopRecording()
                            } else {
                                startRecording()
                            }
                        }) {
                            Text(isRecording ? "Stop Recording" : "Start Recording")
                        }
                        Spacer()
                        Text(String(format: "%.1fs", recordingTime))
                    }
                    Button(action: {
                        playRecording()
                    }) {
                        Text("Play Recording")
                    }
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

    func startRecording() {
        let audioSession = AVAudioSession.sharedInstance()

        do {
            try audioSession.setCategory(.record, mode: .default)
            try audioSession.setActive(true)

            let settings = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 12000,
                AVNumberOfChannelsKey: 1,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]

            let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.m4a")

            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder?.record()

            isRecording = true

            timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                self.recordingTime = self.audioRecorder?.currentTime ?? 0
            }

        } catch {
            print("Failed to start recording")
        }
    }

    func stopRecording() {
        audioRecorder?.stop()
        audioRecorder = nil
        isRecording = false
        timer?.invalidate()
        timer = nil
        recognizeSpeech()
    }

    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    func recognizeSpeech() {
        let audioURL = getDocumentsDirectory().appendingPathComponent("recording.m4a")
        let recognizer = SFSpeechRecognizer()
        let request = SFSpeechURLRecognitionRequest(url: audioURL)

        recognizer?.recognitionTask(with: request, resultHandler: { (result, error) in
            if let result = result {
                self.content = result.bestTranscription.formattedString
            }
        })
    }

    func playRecording() {
        let audioURL = getDocumentsDirectory().appendingPathComponent("recording.m4a")
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioURL)
            audioPlayer?.play()
        } catch {
            print("Failed to play recording")
        }
    }
}

struct AddTalkMemoView_Previews: PreviewProvider {
    static var previews: some View {
        AddTalkMemoView(clientID: "123")
    }
}
