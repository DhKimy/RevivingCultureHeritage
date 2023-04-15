//
//  SsileumView.swift
//  RevivingCultureHeritage
//
//  Created by 김동현 on 2023/04/13.
//

import SwiftUI
import Foundation

struct DetailView: View {
    @State var title = ""
    @State private var isShowingDetail = false
    @State var y : CGFloat = 100
    @State var addThis: CGFloat = 100
    @State private var bouncing = false
    var body: some View {
        ZStack {
            Image(title)
                .resizable()
            Image("hand")
                .resizable()
                .frame(width: 150, height: 150)
            //                .position(x: UIScreen.main.bounds.size.width / 4, y: UIScreen.main.bounds.size.height / 2)
                .frame(maxHeight: .pi, alignment: bouncing ? .bottom : .center)
                .animation(Animation.easeInOut(duration: 1.0).repeatForever(autoreverses: true), value: bouncing)
                .onAppear {
                    self.bouncing.toggle()
                }
            
        }
        .frame(width: UIScreen.main.bounds.size.width / 1.25, height: UIScreen.main.bounds.size.height / 1.25)
        .background(
            Image("DetailViewBack")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .opacity(0.9)
        )
        .sheet(isPresented: $isShowingDetail) {
            ModalView()
        }
        .gesture(getTapGesture())
    }
    
    
    private func getTapGesture() -> some Gesture {
        TapGesture(count: 1)
            .onEnded { value in
                withAnimation {
                    isShowingDetail = true
                    bouncing = false
                }
            }
    }
}

struct ModalView: View {
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        VStack {
            Text("Detail View")
                .padding()
            Button("Dismiss") {
                withAnimation {
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
    }
}



struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
