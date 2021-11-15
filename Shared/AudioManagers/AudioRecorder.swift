//
//  AudioRecorder.swift
//  TestMapDemo (iOS)
//
//  Created by Md Tariqul Islam on 14/11/21.
//

import Foundation
import SwiftUI
import AVFoundation
import Combine

class AudioRecorder: NSObject,ObservableObject {
    
    override init() {
        super.init()
        fetchRecordings()
    }
    
    let objectWillChange = PassthroughSubject<AudioRecorder, Never>()
    
    var audioRecorder: AVAudioRecorder!
    
    var recordings = [Recording]()
    
    var recording = false {
        didSet {
            objectWillChange.send(self)
        }
    }
    
    func startRecording(title: String, audioFileName: String, lat: String, lang: String) {
        let recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
        } catch {
            print("Failed to set up recording session")
        }
       // let fileManager = FileManager.default
        let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        //let directoryContents = try! fileManager.contentsOfDirectory(at: documentPath, includingPropertiesForKeys: nil)

        let audioFilename = documentPath.appendingPathComponent("\(audioFileName).m4a")
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.record()
            recording = true
            
            saveAudio(documentPath: audioFilename, audioFilename: audioFileName, title: title, lat: lat, lang: lang)

        } catch {
            print("Could not start recording")
        }
    }
    
    func saveAudio(documentPath: URL, audioFilename: String, title : String, lat: String, lang: String){
        print("calling \(lat), \(lang)")
        let record = RecordDetailsModel(fileURL: documentPath, createdAt: audioFilename, title: title, latitude: lat, longitude: lang)
        print(record)
        var recordedList = RecorderDB.getRecordDetials()
        recordedList?.append(record)
        RecorderDB.save(value: recordedList ?? [])
    }
    func stopRecording(title: String, audioFileName: String) {
        audioRecorder.stop()
        recording = false
        RecorderDB.editRecordDetials(createAt: audioFileName, title: title, list: RecorderDB.getRecordDetials() ?? [])
        fetchRecordings()
    }
    
    func fetchRecordings() {
        recordings.removeAll()
        
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let directoryContents = try! fileManager.contentsOfDirectory(at: documentDirectory, includingPropertiesForKeys: nil)
        for audio in directoryContents {
            
            let recording = Recording(fileURL: audio, createdAt: getCreationDate(for: audio))
            recordings.append(recording)
        }
        
        recordings.sort(by: { $0.createdAt.compare($1.createdAt) == .orderedAscending})
        
        objectWillChange.send(self)
    }
    
    func deleteRecording(urlsToDelete: [URL]) {
        
        for url in urlsToDelete {
            print(url)
            do {
                try FileManager.default.removeItem(at: url)
                
            } catch {
                print("File could not be deleted!")
            }
        }
        
        fetchRecordings()
    }
    
}
