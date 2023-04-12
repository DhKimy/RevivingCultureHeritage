import SwiftUI

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
            Heritage(id: 1, title: "Yuchnoli", author: "HongdoKim", image: "2", backgroundSound: "YuchnoliBGM", effectSound: "YuchnoliSFX", fragment: "YuchnoliFrag", color: Color.white),
            Heritage(id: 2, title: "Jegichagi", author: "JunkeunKim", image: "3", backgroundSound: "JegichagiBGM", effectSound: "JegichagiSFX", fragment: "JegichagiFrag", color: Color.white),
            Heritage(id: 3, title: "Sulyeobdo", author: "unknown", image: "4", backgroundSound: "SulyeobdoBGM", effectSound: "SulyeobdoSFX", fragment: "SulyeobdodoFrag", color: Color.white),
            Heritage(id: 4, title: "Dano", author: "YoonbokSin", image: "5", backgroundSound: "DanoBGM", effectSound: "DanoSFX", fragment: "DanoFrag", color: Color.white),
            Heritage(id: 5, title: "Tuho", author: "YoonbokSin", image: "6", backgroundSound: "TuhoBGM", effectSound: "TuhoSFX", fragment: "TuhoFrag", color: Color.white),
            Heritage(id: 6, title: "Baenoli", author: "YoonbokSin", image: "7", backgroundSound: "BaenoliBGM", effectSound: "BaenoliSFX", fragment: "BaenoliFrag", color: Color.white)
        ]
    }
}

struct ContentView: View {
    
    @StateObject var store = Store()
    @State private var snappedItem = 0.0
    @State private var draggingItem = 0.0
    @State var activeIndex: Int = 0
    
    var body: some View {
        
        ZStack {
            ForEach(store.items) { item in
                
                // article view
                ZStack {
                    RoundedRectangle(cornerRadius: 18)
                        .fill(item.color)
                        .shadow(radius: 10, y: 30)
                        
                    Image(item.title)
                        .resizable()
                        .overlay(
                            Button("b", action: {
                          print("hello")
                        })
                        )
                    Text(item.title)
                        .fontWeight(.bold)
                        .font(.system(size: 72, weight: .heavy, design: .serif))
                        .padding()
                        .foregroundColor(item.color)
                }
                .frame(width: UIScreen.main.bounds.size.width / 1.9, height: UIScreen.main.bounds.size.height / 1.7)
                
                .scaleEffect(1.0 - abs(distance(item.id)) * 0.4 )
                .opacity(1.0 - abs(distance(item.id)) * 0.5 )
                .offset(x: myXOffset(item.id), y: 0)
                .zIndex(1.0 - abs(distance(item.id)) * 0.1)
                
                .onTapGesture {
                    
                    // withAnimation is necessary
                    withAnimation {
                        
                        draggingItem = Double(item.id)
                    }
                }
            }
        }
        .gesture(getDragGesture())
        .background(
            Image("background")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .opacity(0.3)
        )
                    
}
    
    
    private func getDragGesture() -> some Gesture {
        
        DragGesture()
            .onChanged { value in
                draggingItem = snappedItem + value.translation.width / 100
            }
            .onEnded { value in
                withAnimation {
                    draggingItem = snappedItem + value.predictedEndTranslation.width / 100
                    draggingItem = round(draggingItem).remainder(dividingBy: Double(store.items.count))
                    snappedItem = draggingItem
                    
                    //Get the active Item index
                    self.activeIndex = store.items.count + Int(draggingItem)
                    if self.activeIndex > store.items.count || Int(draggingItem) >= 0 {
                        self.activeIndex = Int(draggingItem)
                    }
                }
            }
    }
    
    func distance(_ item: Int) -> Double {
        return (draggingItem - Double(item)).remainder(dividingBy: Double(store.items.count))
    }
    
    func myXOffset(_ item: Int) -> Double {
        let angle = Double.pi * 3 / Double(store.items.count) * distance(item)
        return sin(angle) * 280
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}

