//
//  RecordsoundViewController.swift
//  PitchPerfectUiKit
//
//  Created by Nestor Diazgranados on 5/2/20.
//  Copyright © 2020 NesDupier. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundViewController: UIViewController, AVAudioRecorderDelegate {
    private let segueToPlayAudioId = "stopRecording"
    private let labelStop = "Stop recording."
    private let labelRecording = "Recording in progress."
    private let labelStartRecord = "Tap to Record"
    private let audioFileName = "recordedVoice.wav"
    
    private var audioRecorder: AVAudioRecorder!
    
    private enum RecordingState { case recording, stopRecording }
    
    @IBOutlet weak var stopRecording: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordAudio: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopRecording.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func recordAudio(_ sender: Any) {
        configureUI(for: .recording)
        prepareAudio()
    }
    
    //MARK: configure UI
    private func configureUI(for recording: RecordingState){
        switch recording {
        case .recording:
            recordAudio.isEnabled = false
            stopRecording.isEnabled = true
            recordingLabel.text = labelRecording
        default:
            recordAudio.isEnabled = true
            stopRecording.isEnabled = false
            recordingLabel.text = labelStartRecord
        }
    }
    
    //MARK: Prepare Audio Logic.
    func prepareAudio() {
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]  as String
        let recordingName = audioFileName
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        print(filePath!)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord,
                                 mode: AVAudioSession.Mode.default,
                                 options: AVAudioSession.CategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        configureUI(for: .stopRecording)
        audioRecorder.stop()
        try! AVAudioSession.sharedInstance().setActive(false)
    }
    
    // Audio Recorder delegate
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool){
        print("Stopping recording.")
        if flag {
            performSegue(withIdentifier: segueToPlayAudioId, sender: audioRecorder.url)
        } else {
            print ("Recording was not successfull")
        }
    }
    
    // Prepare next View controller for receive data.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueToPlayAudioId {
            let playSoundsVC = segue.destination as! PlaySoundViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
}

