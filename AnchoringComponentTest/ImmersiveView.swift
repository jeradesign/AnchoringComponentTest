//
//  ImmersiveView.swift
//  AnchoringComponentTest
//
//  Created by John Brewer on 10/4/25.
//

import SwiftUI
import RealityKit
import GLTFKit2

struct ImmersiveView: View {
    @State var anchorEntity: AnchorEntity?

    var body: some View {
        RealityView { content in
            // Add the initial RealityKit content
            let urlResource = URLResource(name: "ShinySphere.glb")
            guard let url = URL(resource: urlResource),
                  let ball = try? await GLTFRealityKitLoader.load(from: url) else {
                fatalError("Couldn't load ShinySphere.glb")
            }
            ball.position = SIMD3<Float>(0, 0.1, 0)
            anchorEntity = AnchorEntity(.plane(.horizontal, classification: .table, minimumBounds: [0.25, 0.25]))
            anchorEntity?.addChild(ball)
            content.add(anchorEntity!)

            // Put skybox here.  See example in World project available at
            // https://developer.apple.com/
        }
    }
}

#Preview(immersionStyle: .mixed) {
    ImmersiveView()
        .environment(AppModel())
}
