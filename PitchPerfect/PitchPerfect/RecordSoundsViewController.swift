//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by apple on 25/02/1440 AH.
//  Copyright © 1440 Student@Udacity. All rights reserved.
//
//+++++++++++++++++
import UIKit
import AVFoundation
//+++++++++++++++++

class RecordSoundsViewController: UIViewController , AVAudioRecorderDelegate {
    //
    var audioRecorder : AVAudioRecorder!
    // from label
    @IBOutlet weak var recordingLabel: UILabel!
    // from recording button
    @IBOutlet weak var recordButton: UIButton!
    // from stop recording button
    @IBOutlet weak var stopRecordingButton: UIButton!
    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    override func viewDidLoad() {
        super.viewDidLoad()
        // to disable the stop button
        stopRecordingButton.isEnabled = false
        // Do any additional setup after loading the view, typically from a nib.
    }
    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    @IBAction func recordAudio(_ sender: Any) {
        recordingLabel.text = "Recording in Progress"
        stopRecordingButton.isEnabled = true
        // when it record
        recordButton.isEnabled = false
        //
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        //********************
        print(filePath as Any)
        
        let session = AVAudioSession.sharedInstance()
        //********************************************************************
        // Problem //
        //try! session.setCategory(AVAudioSession.Category.playAndRecord, with: AVAudioSession.CategoryOptions.defaultToSpeaker)
        // Source to fix it //
        // https://stackoverflow.com/questions/51010390/avaudiosession-setcategory-swift-4-2-ios-12-play-sound-on-silent
        try! session.setCategory(.playAndRecord, mode: .default, options: [])
        //********************************************************************
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
  
    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    @IBAction func stopRecording(_ sender: Any) {
        recordButton.isEnabled = false
        stopRecordingButton.isEnabled = true
        recordingLabel.text = "Tap To Record"
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    
    }
    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        }
        else {
            print("Recording was not successfull ☹️")
        }
    }
    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
}

