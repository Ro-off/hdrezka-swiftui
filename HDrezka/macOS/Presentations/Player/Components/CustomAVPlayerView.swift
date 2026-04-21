import AVKit
import SwiftUI

final class AmbientBackgroundPlayerContainerView: NSView {
    let playerLayer = AVPlayerLayer()

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)

        wantsLayer = true
        playerLayer.frame = bounds
        playerLayer.autoresizingMask = [.layerWidthSizable, .layerHeightSizable]
        playerLayer.videoGravity = .resize

        layer?.addSublayer(playerLayer)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct CustomAVPlayerView: NSViewRepresentable {
    var playerLayer: AVPlayerLayer

    func makeNSView(context _: Context) -> NSView {
        let view = NSView()
        view.wantsLayer = true

        playerLayer.frame = view.bounds
        playerLayer.autoresizingMask = [.layerWidthSizable, .layerHeightSizable]

        view.layer?.addSublayer(playerLayer)

        return view
    }

    func updateNSView(_ nsView: NSView, context _: Context) {
        playerLayer.frame = nsView.bounds
    }
}

struct AmbientBackgroundPlayerView: NSViewRepresentable {
    let player: AVPlayer

    func makeNSView(context _: Context) -> AmbientBackgroundPlayerContainerView {
        let view = AmbientBackgroundPlayerContainerView()
        view.playerLayer.player = player
        return view
    }

    func updateNSView(_ nsView: AmbientBackgroundPlayerContainerView, context _: Context) {
        nsView.playerLayer.player = player
        nsView.playerLayer.frame = nsView.bounds
    }
}
