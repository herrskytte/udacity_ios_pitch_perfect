//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Frederik Skytte on 17/11/2018.
//  Copyright © 2018 Frederik Skytte. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var recordingLabel: UILabel!
    
    @IBOutlet weak var recordButton: UIButton!
    
    @IBOutlet weak var stopButton: UIButton!
    
    var audioRecorder: AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI(recording: false)
    }
    
    @IBAction func recordAudio(_ sender: Any) {
        updateUI(recording: true)
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options:AVAudioSession.CategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        updateUI(recording: false)
        
        audioRecorder.stop()
        let session = AVAudioSession.sharedInstance()
        try! session.setActive(false)
    }
    
    fileprivate func updateUI(recording: Bool) {
        recordingLabel.text = recording ? "Recording in progress" : "Tap to record"
        stopButton.isEnabled = recording
        recordButton.isEnabled = !recording
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        print("Recording done. Success? \(flag)")
        if flag {
            performSegue(withIdentifier: "stopRecordingSegue", sender: audioRecorder.url)
        }
        else{
            AlertUtil.showAlert(self,
                                title: AlertUtil.RecordingFailedTitle,
                                message: AlertUtil.RecordingFailedMessage)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecordingSegue" {
            let targetVC = segue.destination as! PlaySoundsViewController
            targetVC.recordedAudioURL = (sender as! URL)
        }
    }
}

