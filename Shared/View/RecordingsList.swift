//
//  RecordingsList.swift
//  TestMapDemo (iOS)
//
//  Created by Md Tariqul Islam on 14/11/21.
//

import SwiftUI

struct RecordingsList: View {
    
    @ObservedObject var audioRecorder: AudioRecorder
    
    var body: some View {
        VStack{
            
            List {
                ForEach(audioRecorder.recordings, id: \.createdAt) { recording in
                    RecordingRow(audioURL: recording.fileURL, title: recordedTitle(recordingTitle: recording.createdAt.toString(dateFormat: "dd-MM-YY_'at'_HH:mm:ss")))
                }.onDelete(perform: delete)
            }
        }
    }
    
    func delete(at offsets: IndexSet) {
        
        var urlsToDelete = [URL]()
        for index in offsets {
            urlsToDelete.append(audioRecorder.recordings[index].fileURL)
            RecorderDB.removeRecordDetials(createAt: audioRecorder.recordings[index].createdAt.toString(dateFormat: "dd-MM-YY_'at'_HH:mm:ss"), list: RecorderDB.getRecordDetials() ?? [])
        }
        audioRecorder.deleteRecording(urlsToDelete: urlsToDelete)
    }
    
    func recordedTitle(recordingTitle: String) -> String{
        var title : String = ""
        let recordedList = (RecorderDB.getRecordDetials() ?? []) as [RecordDetailsModel]
        if let index = recordedList.firstIndex(where: {$0.createdAt == recordingTitle}){
            title =  recordedList[index].title
            print("title \(title) ")
            return title
        }
        return title
    }
}

struct RecordingRow: View {
    
    var audioURL: URL
    var title : String
    @ObservedObject var audioPlayer = AudioPlayer()
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing:5){
                if !title.isEmpty {
                    Text("Title: \(title)")
                }
                Text("\(audioURL.lastPathComponent)")
            }
            Spacer()
            if audioPlayer.isPlaying == false {
                Button(action: {
                    self.audioPlayer.startPlayback(audio: self.audioURL)
                }) {
                    Image(systemName: "play.circle")
                        .imageScale(.small)
                }
            } else {
                Button(action: {
                    self.audioPlayer.stopPlayback()
                }) {
                    Image(systemName: "stop.fill")
                        .imageScale(.small)
                }
            }
        }
    }
}

struct RecordingsList_Previews: PreviewProvider {
    static var previews: some View {
        RecordingsList(audioRecorder: AudioRecorder())
    }
}
