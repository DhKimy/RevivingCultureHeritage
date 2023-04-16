//
//  File 4.swift
//  
//
//  Created by 김동현 on 2023/04/16.
//

import SwiftUI
import Foundation

struct DanoView: View {
    @State var title = ""
    @State var backgroundName = ""
    @State private var isShowingDetail = false
    @State private var bouncing = false
    @State var isFirstTouch = false
   
    var body: some View {
        
        ZStack {
            Image(title)
                .resizable()
            if isFirstTouch {
                Image("jeki")
                    .resizable()
                    .position(x: UIScreen.main.bounds.size.width / 10.8, y: UIScreen.main.bounds.size.height / 9.8)
                    .frame(width: 50, height: 90)
                    .frame(maxHeight: .greatestFiniteMagnitude, alignment: bouncing ? .bottom : .top)
                    .animation(Animation.easeInOut(duration: 0.7).repeatCount(10), value: bouncing)
                    .onAppear {
                        self.bouncing.toggle()
                    }

            } else {
                Image("hand")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .frame(maxHeight: .pi, alignment: bouncing ? .bottom : .center)
                    .animation(Animation.easeInOut(duration: 1.0).repeatForever(autoreverses: true), value: bouncing)
                    .onAppear {
                        self.bouncing.toggle()
                    }
            }
            
            
        }
        .frame(width: UIScreen.main.bounds.size.width / 1.25, height: UIScreen.main.bounds.size.height / 1.25)
        .background(
            Image(backgroundName)
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .opacity(0.9)
        )
        .sheet(isPresented: $isShowingDetail) {
            ModalView(isFirstTouch: $isFirstTouch)
        }
        .gesture(getTapGesture())
         
    }
    
    
    private func getTapGesture() -> some Gesture {
        TapGesture(count: 1)
            .onEnded { value in
                isFirstTouch = !isFirstTouch
                UIApplication.shared.beginIgnoringInteractionEvents()
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 10) {
                    //                   1초 후 실행될 부분
                    withAnimation {
                        isShowingDetail = true
                        bouncing = false
                    }
                    UIApplication.shared.endIgnoringInteractionEvents()
                }
                
            }
    }
}

struct DanoView_Previews: PreviewProvider {
    static var previews: some View {
        DanoView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
