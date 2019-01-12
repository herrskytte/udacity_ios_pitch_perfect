//
//  AlertUtil.swift
//  PitchPerfect
//
//  Created by Frederik Skytte on 20/11/2018.
//  Copyright © 2018 Frederik Skytte. All rights reserved.
//

import UIKit

struct AlertUtil {
    static let DismissAlert = "Dismiss"
    static let RecordingDisabledTitle = "Recording Disabled"
    static let RecordingDisabledMessage = "You've disabled this app from recording your microphone. Check Settings."
    static let RecordingFailedTitle = "Recording Failed"
    static let RecordingFailedMessage = "Something went wrong with your recording."
    static let AudioRecorderError = "Audio Recorder Error"
    static let AudioSessionError = "Audio Session Error"
    static let AudioRecordingError = "Audio Recording Error"
    static let AudioFileError = "Audio File Error"
    static let AudioEngineError = "Audio Engine Error"
    
    static func showAlert(_ controller: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: DismissAlert, style: .default, handler: nil))
        controller.present(alert, animated: true, completion: nil)
    }
}
