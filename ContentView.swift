import SwiftUI



struct ContentView: View {
    
    @StateObject var store = Store()
    @State private var snappedItem = 0.0
    @State private var draggingItem = 0.0
    @State var activeIndex: Int = 0
    @GestureState private var isDetectingPress = false
    @State var openViewName : String = ""
    @State var isNavigationActive = false
    @State private var tapped = false
    @State var backgroundName = detailViewBackgroundScreen[Int.random(in: 0 ..< 4)]
    
    var body: some View {
        NavigationView {
            ZStack {
                ForEach(store.items) { item in
                    
                    ZStack {
                        Image(item.title)
                            .resizable()
                            .shadow(radius: 10, y: 30)
                            .gesture(getTapGesture(item.title))
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
                }
                
                NavigationLink(destination: DetailView(title: openViewName, backgroundName: backgroundName), isActive: $isNavigationActive) {
                    
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
        .navigationViewStyle(StackNavigationViewStyle())
        
        .accentColor(backgroundName.last == "B" ? .black : .white)
    }
    
    private func changeDetailBack() {
        backgroundName = detailViewBackgroundScreen[Int.random(in: 0 ..< 4)]
    }
    
    private func getTapGesture(_ title: String) -> some Gesture {
        TapGesture(count: 1)
            .onEnded { value in
                self.isNavigationActive = true
                openViewName = title
            }
        
    }
    
    private func getDragGesture() -> some Gesture {
        DragGesture()
            .onChanged { value in
                draggingItem = snappedItem + value.translation.width / 100
                changeDetailBack()
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
