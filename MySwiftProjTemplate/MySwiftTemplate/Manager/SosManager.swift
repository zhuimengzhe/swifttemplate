
//
//  SosManager.swift
//  MySwiftTemplate
//
//  Created by apple on 25/10/2017.
//  Copyright © 2017 apple. All rights reserved.
//

import UIKit
import AudioToolbox
import AVFoundation

final class SosController {
    static let sharedInstance = SosController()
    private init() {
        self.soundId = kSystemSoundID_Vibrate
        do {
            let deviceInput = try AVCaptureDeviceInput.init(device: self.captureDevice)
            if(self.captureSession.canAddInput(deviceInput)) {
                self.captureSession.addInput(deviceInput)
            }
        }
        catch {
            
        }
    }
    
    var sosTimer:Timer?
    
    func startSos(_ intervale:TimeInterval) {
        if sosTimer == nil {
            sosTimer = Timer.scheduledTimer(timeInterval: intervale, target: self, selector: #selector(SosController.openFlashAndTorch), userInfo: nil, repeats: true)
        }
        sosTimer?.fire()
    }
    
    func stopSos() {
        sosTimer?.invalidate()
        sosTimer = nil
        closeFlashAndTorch()
    }
    
    var soundId = kSystemSoundID_Vibrate
    
    lazy var captureDevice : AVCaptureDevice = {
        let capture = AVCaptureDevice.default(for: AVMediaType.video)
        return capture!
    }()
    
    lazy var captureSession : AVCaptureSession = {
        let session = AVCaptureSession.init()
        return session
    }()
    
    public func play() {
        AudioServicesPlaySystemSound(self.soundId)
    }
    
    deinit {
        AudioServicesDisposeSystemSoundID(self.soundId)
    }
    
    //打开闪光灯
    @objc public func openFlashAndTorch() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);//震动
        if self.captureDevice.hasTorch && self.captureDevice.hasFlash {
            self.captureSession.beginConfiguration()
            if self.captureDevice.torchMode == .off {
                do {
                    try self.captureDevice.lockForConfiguration()
                    self.captureDevice.torchMode = .on
                    self.captureDevice.flashMode = .on
                    self.captureDevice.unlockForConfiguration()
                }
                catch {
                    
                }
            }
            self.captureSession.commitConfiguration()
        }
    }
    
    public func closeFlashAndTorch() {
        self.captureSession.beginConfiguration()
        if self.captureDevice.torchMode == .on {
            do {
                try self.captureDevice.lockForConfiguration()
                self.captureDevice.torchMode = .off
                self.captureDevice.flashMode = .off
                self.captureDevice.unlockForConfiguration()
            }
            catch {
                
            }
        }
        self.captureSession.commitConfiguration()
    }
}

