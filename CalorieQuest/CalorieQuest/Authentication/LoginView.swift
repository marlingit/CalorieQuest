//
//  LoginView.swift
//  CalorieQuest
//
//  Created by Vijay Vadi on 4/29/24.
//

import SwiftUI
import AVFoundation
import AVKit

struct TestView: View {
    
    var namespace: Namespace.ID
    
    @State var showAuthView = false
    @Binding var authenticationComplete: Bool
    
    var body: some View {
        VStack {
            ZStack {
                if !showAuthView {
                    Launch()
                } else {
                    Auth(showAuthView: $showAuthView, authenticationComplete: $authenticationComplete)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .mask(BottomRoundedRectangle(cornerRadius: 35))
            .background(
                ZStack {
                    Color.white
                        .mask(BottomRoundedRectangle(cornerRadius: 36))
                    if !showAuthView {
                            ZStack {
                                VideoPlayerView(videoURL: Bundle.main.url(forResource: "backgroundvideo", withExtension: "mp4")!)
                                    .edgesIgnoringSafeArea(.top)
                                    .onDisappear {
                                        (UIApplication.shared.windows.first?.rootViewController as? AVPlayerViewController)?.player?.pause()
                                    }
                            }.frame(maxHeight: .infinity)
                                .mask(BottomRoundedRectangle(cornerRadius: 35))
                    } else {
                        Color.white.edgesIgnoringSafeArea(.top)
                            .frame(height: 100)
                    }
                }.edgesIgnoringSafeArea(.top)
                    .ignoresSafeArea(.keyboard)
                    .matchedGeometryEffect(id: "view", in: namespace)
            )
            
            if !showAuthView {
                Button {
                    withAnimation() {
                        self.showAuthView = true
                    }
                } label: {
                    Text("Continue")
                        .foregroundStyle(.black)
                        .font(.custom("Urbanist", size: 24))
                        .fontWeight(.bold)
                        .frame(width: 255, height: 50)
                        .background(Color.white, in: RoundedRectangle(cornerRadius: 25))
                        .padding(.top, 24)
                        .padding(.bottom, 24)
                }
            }
        }
        .background(Color.black.edgesIgnoringSafeArea(.bottom))
    }
}

private struct Launch: View {
    
    let videoURL: URL
    
    init() {
        guard let path = Bundle.main.url(forResource: "backgroundvideo", withExtension: "mp4") else {            fatalError("Video introvideo.mp4 not found")
        }
        self.videoURL = path
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Text("CalorieQuest")
                    .foregroundStyle(.white)
                    .font(.custom("Urbanist", size: 48))
                    .fontWeight(.bold)
                    .padding(.top, 42)
                    .shadow(radius: 25)
                
                Spacer()
                
                Text("The All in One\nNutrition and Fitness App")
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 20))
                    .fontWeight(.medium)
                    .padding(.bottom, 48)
                    .shadow(radius: 25)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

private struct Auth: View {
    
    @Binding var showAuthView: Bool
    @Binding var authenticationComplete: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            
            CreateAccountView(authenticationComplete: $authenticationComplete)
            
            Spacer()
            
            Image(systemName: "chevron.up")
                .font(.system(size: 36))
                .fontWeight(.bold)
                .frame(width: 50, height: 50)
                .onTapGesture {
                    withAnimation() {
                        showAuthView = false
                    }
                }
        }.ignoresSafeArea(.keyboard)
    }
}

struct VideoPlayerView: UIViewControllerRepresentable {
    var videoURL: URL

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let player = AVPlayer(url: videoURL)
        context.coordinator.player = player
        player.isMuted = true
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        playerViewController.showsPlaybackControls = false
        playerViewController.videoGravity = .resizeAspectFill
        playerViewController.player?.play()
        playerViewController.entersFullScreenWhenPlaybackBegins = false
        playerViewController.modalPresentationCapturesStatusBarAppearance = true

        NotificationCenter.default.addObserver(
            context.coordinator,
            selector: #selector(Coordinator.loopVideo),
            name: .AVPlayerItemDidPlayToEndTime,
            object: player.currentItem
        )
        
        return playerViewController
    }

    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        if uiViewController.player?.timeControlStatus != .playing {
            uiViewController.player?.play()
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject {
        var parent: VideoPlayerView
        var player: AVPlayer?

        init(_ videoPlayerView: VideoPlayerView) {
            self.parent = videoPlayerView
        }

        deinit {
            NotificationCenter.default.removeObserver(self)
        }

        @objc func loopVideo(notification: Notification) {
            if let playerItem = notification.object as? AVPlayerItem {
                playerItem.seek(to: CMTime.zero, completionHandler: { [weak self] _ in
                    self?.player?.play()
                })
            }
        }
    }
}

class CustomAVPlayerViewController: AVPlayerViewController {

    override var prefersStatusBarHidden: Bool {
        return false
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
