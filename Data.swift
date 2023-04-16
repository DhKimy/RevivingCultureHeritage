//
//  Data.swift
//  RevivingCultureHeritage
//
//  Created by 김동현 on 2023/04/15.
//

import Foundation
import SwiftUI

let detailViewBackgroundScreen: [String] = ["DetailViewBack_BlueW",  "DetailViewBack_OrangeW", "DetailViewBack_RedW", "DetailViewBack_WhiteB"]


struct DetailView: View {
    let openViewName: String
    let backgroundName: String
    
    @ViewBuilder var body: some View {
        switch openViewName {
        case "Dano":
            DanoView(title: openViewName, backgroundName: backgroundName)
        case "Hwalssogi":
            HwalssogiView(title: openViewName, backgroundName: backgroundName)
        case "Jekinori":
            JekinoriView(title: openViewName, backgroundName: backgroundName)
        case "Ssireum":
            SsireumView(title: openViewName, backgroundName: backgroundName)
        default:
            TuhoView(title: openViewName, backgroundName: backgroundName)
        
        }
    }
}


struct Heritage: Identifiable {
    var id: Int
    var title: String
    let author: String
    let image: String // Image 변경 필요
    let backgroundSound: String
    let effectSound: String
    let fragment: String // Image 변경 필요
    let color: Color
}

class Store: ObservableObject {
    @Published var items: [Heritage]
    
    // data
    init() {
        items = [
            Heritage(id: 0, title: "Ssileum", author: "HongdoKim", image: "Ssileum", backgroundSound: "SsileumBGM", effectSound: "SsileumSFX", fragment: "SsileumFrag", color: Color.white),
            Heritage(id: 1, title: "Jegichagi", author: "JunkeunKim", image: "3", backgroundSound: "JegichagiBGM", effectSound: "JegichagiSFX", fragment: "JegichagiFrag", color: Color.white),
            Heritage(id: 2, title: "Sulyeobdo", author: "unknown", image: "4", backgroundSound: "SulyeobdoBGM", effectSound: "SulyeobdoSFX", fragment: "SulyeobdodoFrag", color: Color.white),
            Heritage(id: 3, title: "Dano", author: "YoonbokSin", image: "5", backgroundSound: "DanoBGM", effectSound: "DanoSFX", fragment: "DanoFrag", color: Color.white),
            Heritage(id: 4, title: "Tuho", author: "YoonbokSin", image: "6", backgroundSound: "TuhoBGM", effectSound: "TuhoSFX", fragment: "TuhoFrag", color: Color.white),
        ]
    }
}
