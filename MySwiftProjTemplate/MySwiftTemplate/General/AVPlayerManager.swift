//
//  AVPlayerManager.swift
//  Guide
//
//  Created by apple on 16/4/30.
//  Copyright © 2016年 dingmc. All rights reserved.
//

import UIKit
import AVFoundation
let __PlayerManager = AVPlayerController()
class AVPlayerController : NSObject {
    
    var player:AVPlayer
    //是否正在播放
    var isPlaying = false
    //资源是否完毕
    var isPrepare = false
    
    func getPlayerLayer() -> AVPlayerLayer {
        //创建AVPlayerLayer，必须把视频添加到AVPlayerLayer层，才能播放
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resizeAspectFill
        return playerLayer
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override init() {
        player = AVPlayer()
        super.init()
        
        NotificationCenter.default.addObserver(self, selector: #selector(AVPlayerController.pause), name:UIApplication.willResignActiveNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(AVPlayerController.play), name:UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    //播放一个网络链接音乐
    func musicPlayerWithURL(playerItemURL:URL){
        //创建要播放的资源
        let playerItem = AVPlayerItem.init(url: playerItemURL)
        //播放当前资源
        if player.currentItem != nil {
            //上一首 下一首的实现方式 1
            NotificationCenter.default.removeObserver(self)
            player.replaceCurrentItem(with: playerItem)
            //实现方式2
            //使用AVQueuePlayer的advanceToNextItem
        }
        //当资源的status发生改变时就会触发观察者事件
        playerItem.addObserver(self, forKeyPath: "status", options: .new, context:nil)
        //加载缓存
        playerItem.addObserver(self, forKeyPath: "loadedTimeRanges", options:.new ,context: nil)
        
        //播放完通知
        NotificationCenter.default.addObserver(self, selector: #selector(AVPlayerController.MovieFinishedCallback(notif:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
        
        //添加定时器，更新当前的播放进度
        //(1）方法传入一个CMTime结构体，每到一定时间都会回调一次，包括开始和结束播放
        //(2）如果block里面的操作耗时太长，下次不一定会收到回调，所以尽量减少block的操作耗时
        //(3）方法会返回一个观察者对象，当播放完毕时需要移除这个观察者
//        let timerObserver =
//            player.addPeriodicTimeObserver(forInterval: CMTimeMake(Int64(1), Int32(1)), queue: DispatchQueue.main) { (cmTime) in
//                let current = CMTimeGetSeconds(cmTime)
//                let total = CMTimeGetSeconds(playerItem.duration)
//        }
        
        //移除观察者
        //        if (timeObserve) {
        //            player.removeTimeObserver(timerObserver)
        //            timeObserve = nil;
        //        }
    }
    
    @objc func MovieFinishedCallback(notif:Notification){
        print(#function)
    }
    
    //播放
    @objc func play(){
        if !isPrepare {
            return
        }
        player.play()
        isPlaying = true
    }
    
    //暂停
    @objc func pause(){
        if !isPlaying {
            return
        }
        player.pause()
        isPlaying = false
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let keyPath1 = keyPath {
            switch keyPath1 {
            case "status":
                //资源观察者
                //                let status = (change![NSKeyValueChangeNewKey] as! NSNumber).integerValue as AVPlayerStatus.RawValue
                //
                //                switch (status) {
                //                case AVPlayerStatus.ReadyToPlay.rawValue:
                //                    isPrepare = true
                //                    startPlay()
                //                    print("ready")
                //                case AVPlayerStatus.Failed.rawValue:
                //                    print("Failed to load video")
                //                default:
                print("status")
            //                }
            case "loadedTimeRanges":
                //缓存处理
                //                let playerItem = object as! AVPlayerItem
                //                let timeRange = playerItem.loadedTimeRanges.first?.CMTimeRangeValue
                //                let startSeconds = CMTimeGetSeconds((timeRange?.start)!)
                //                let durationSeconds = CMTimeGetSeconds((timeRange?.duration)!)
                //                let totalBuffer = startSeconds + durationSeconds
                //                print("共缓冲 %.2f",totalBuffer)
                print("loadedTimeRanges")
            case "rate":
                print("rate")
            default:
                print("defalut")
                super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            }
        }
    }
}

