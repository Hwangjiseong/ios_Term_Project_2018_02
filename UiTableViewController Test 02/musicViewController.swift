//
//  musicViewController.swift
//  UiTableViewController Test 02
//
//  Created by L703 on 2018. 6. 28..
//  Copyright © 2018년 lse. All rights reserved.
//

import UIKit
import AVFoundation

class musicViewController: UIViewController, AVAudioPlayerDelegate {
    
    var audioPlayer : AVAudioPlayer!
    
    var audioFile : URL!
    
    let MAX_VOLUME : Float = 10.0
    
    var progeressTimer : Timer!
    
    let timePlayerSelector:Selector = #selector(musicViewController.updatePlaytime)

    @IBOutlet weak var lblEnd: UILabel!
    @IBOutlet weak var lblC: UILabel!
    @IBOutlet weak var pvProgress: UIProgressView!
    
    @IBOutlet weak var btPlay: UIButton!
    @IBOutlet weak var btPause: UIButton!
    @IBOutlet weak var btStop: UIButton!
    @IBOutlet weak var sVol: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        audioFile = Bundle.main.url(forResource: "Loving U (러빙유)",withExtension: "mp3")
        initPlay()
    }
    func initPlay(){
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: audioFile)
        } catch let error as NSError {
            print("error-initPlay : \(error)")
        }
        sVol.maximumValue = MAX_VOLUME
        sVol.value = 1.0
        pvProgress.progress = 0
        
        audioPlayer.delegate = self
        audioPlayer.prepareToPlay()
        audioPlayer.volume = sVol.value
        
        lblEnd.text = convertNSTimeInterval2String(audioPlayer.duration)
        lblC.text = convertNSTimeInterval2String(0)
        setPlayButtons(true, pause: false, stop: false)
        
    }
    func setPlayButtons(_ play:Bool, pause:Bool, stop:Bool) -> Void {
        btPlay.isEnabled = play
        btPause.isEnabled = pause
        btStop.isEnabled = stop
    }
    func convertNSTimeInterval2String(_ time: TimeInterval) -> String {
        let min = Int(time/60)
        let sec = Int(time.truncatingRemainder(dividingBy: 60))
        let strTime = String(format: "%02d:%02d", min, sec)
        
        return strTime
    }
    
    @IBAction func btPlayAudio(_ sender: UIButton) {
        audioPlayer.play()
        setPlayButtons(false, pause: true, stop: true)
        progeressTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: timePlayerSelector, userInfo: nil, repeats: true)
        
    }
    @objc func updatePlaytime() {
        lblC.text = convertNSTimeInterval2String(audioPlayer.currentTime)
        pvProgress.progress = Float(audioPlayer.currentTime/audioPlayer.duration)
    }
    
    
    @IBAction func btPauseAudio(_ sender: UIButton) {
        audioPlayer.pause()
        setPlayButtons(true, pause: false, stop: true)
    }
    
    @IBAction func btStopAudio(_ sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.currentTime = 0
        lblC.text = convertNSTimeInterval2String(0)
        setPlayButtons(true, pause: false, stop: false)
        progeressTimer.invalidate()
    }
    @IBAction func sVolume(_ sender: UISlider) {
        audioPlayer.volume = sVol.value
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        progeressTimer.invalidate()
        setPlayButtons(true, pause: false, stop: false)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
