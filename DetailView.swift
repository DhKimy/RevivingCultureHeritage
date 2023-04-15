//
//  SsileumView.swift
//  RevivingCultureHeritage
//
//  Created by 김동현 on 2023/04/13.
//

import SwiftUI
import Foundation

let detailViewBackgroundScreen: [String] = ["DetailViewBack_BlueW", "DetailViewBack_GreenW", "DetailViewBack_OrangeW", "DetailViewBack_RedW", "DetailViewBack_WhiteB"]

struct DetailView: View {
    @State var title = ""
    @State private var isShowingDetail = false
    @State private var bouncing = false
    @State var isFirstTouch = false
    var backgroundName = detailViewBackgroundScreen[Int.random(in: 0 ..< 4)]
    
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

struct ModalView: View {
    @Binding var isFirstTouch: Bool
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        VStack {
            Text("Detail View")
                .padding()
            Button("Dismiss") {
                withAnimation {
                    isFirstTouch = false // isFirstTouch 변수를 false로 변경
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .frame(width: 200, height: 50)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .cornerRadius(16)
        .padding()
        .shadow(radius: 8)
        .opacity(0.6)
        .onDisappear {
            isFirstTouch = false
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
