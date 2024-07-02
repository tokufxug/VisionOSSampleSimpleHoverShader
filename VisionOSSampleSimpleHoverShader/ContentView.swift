//
//  ContentView.swift
//  VisionOSSampleSimpleHoverShader
//
//  Created by Sadao Tokuyama on 7/2/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {

    @State var enlarge = false

    var body: some View {
        VStack {
            RealityView { content in
                // Add the initial RealityKit content
                if let scene = try? await Entity(named: "HoverShaderScene", in: realityKitContentBundle) {
                    
                    if let leftEye = scene.findEntity(named: "Left_Eye") {
                        let hoverEffect = HoverEffectComponent(.shader(.default))
                        leftEye.components.set(hoverEffect)
                    }
                    
                    if let righttEye = scene.findEntity(named: "Right_Eye") {
                        let hoverEffect = HoverEffectComponent(.shader(.default))
                        righttEye.components.set(hoverEffect)
                    }
                    
                    content.add(scene)
                }
            } update: { content in
                // Update the RealityKit content when SwiftUI state changes
                if let scene = content.entities.first {
                    let uniformScale: Float = enlarge ? 1.4 : 1.0
                    scene.transform.scale = [uniformScale, uniformScale, uniformScale]
                }
            }
            .gesture(TapGesture().targetedToAnyEntity().onEnded { _ in
                enlarge.toggle()
            })

            VStack {
                Button {
                    enlarge.toggle()
                } label: {
                    Text(enlarge ? "Reduce RealityView Content" : "Enlarge RealityView Content")
                }
                .animation(.none, value: 0)
                .fontWeight(.semibold)
            }
            .padding()
            .glassBackgroundEffect()
        }
    }
}

#Preview(windowStyle: .volumetric) {
    ContentView()
}
