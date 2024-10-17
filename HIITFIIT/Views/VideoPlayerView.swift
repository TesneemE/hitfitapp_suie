//
//  VideoPlayerView.swift
//  HIITFIIT
//
//  Created by Tes Essa on 9/23/24.
//

import SwiftUI
import AVKit
struct VideoPlayerView: View {
    let videoName: String //declare string videoname // that's what youre passing it was that simplex
    var body: some View {
        if let url = Bundle.main.url(
            forResource: videoName,
           withExtension: "mp4") {
           VideoPlayer(player: AVPlayer(url: url))
       } else {
           Text("Couldn't find \(videoName).mp4")
             .foregroundColor(.red)
       }  //if found, load video, else don't
    }
}

struct VideoPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayerView(videoName: "squat")
    }
}
