import SwiftUI



struct ContentView: View {
    
    @StateObject var store = Store()
    @State private var snappedItem = 0.0
    @State private var draggingItem = 0.0
    @State var activeIndex: Int = 0
    @GestureState private var isDetectingPress = false
    @State var openViewName : String = ""
    @State var isNavigationActive = false
    
    var body: some View {
        NavigationView {
            ZStack {
                ForEach(store.items) { item in
                    ZStack {
                        Image(item.title)
                            .resizable()
                        //                            .scaleEffect(isDetectingPress ? 1.5 : 1)
                        //                            .animation(Animation.easeInOut(duration: 1.0))
                        //                            .gesture(LongPressGesture(minimumDuration: 0.5).sequenced(before:DragGesture(minimumDistance: 0))
                        //                                .updating($isDetectingPress) { value, state, _ in
                        //                                    switch value {
                        //                                    case .second(true, nil):
                        //                                        state = true
                        //                                    default:
                        //                                        break
                        //                                    }
                        //                                })
                            .shadow(radius: 10, y: 30)
                            .gesture(getTapGesture(item.title))
                        Text(item.title)
                            .fontWeight(.bold)
                            .font(.system(size: 72, weight: .heavy, design: .serif))
                            .padding()
                            .foregroundColor(item.color)
                        
                        //                        Button(action: {
                        //                            self.isNavigationActive = true
                        //                            openViewName = item.title
                        //
                        //                        }) {
                        //                            ZStack {
                        //                                Image(item.title)
                        //                                    .resizable()
                        //                                Text(item.title)
                        //                                    .fontWeight(.bold)
                        //                                    .font(.system(size: 72, weight: .heavy, design: .serif))
                        //                                    .padding()
                        //                                    .foregroundColor(item.color)
                        //
                        //                            }
                    }
                    //                        .gesture(getDragGesture())
                    //
                    .frame(width: UIScreen.main.bounds.size.width / 1.9, height: UIScreen.main.bounds.size.height / 1.7)
                    
                    .scaleEffect(1.0 - abs(distance(item.id)) * 0.4 )
                    .opacity(1.0 - abs(distance(item.id)) * 0.5 )
                    .offset(x: myXOffset(item.id), y: 0)
                    .zIndex(1.0 - abs(distance(item.id)) * 0.1)
                    
                    //                .onTapGesture {
                    //
                    //                    // withAnimation is necessary
                    //                    withAnimation {
                    //                        draggingItem = Double(item.id)
                    //                    }
                    //                }
                }
                .tint(Color.black)
                NavigationLink(destination: DetailView(title: openViewName), isActive: $isNavigationActive) {
                    
                }
                
                
                
            }
            
            
            //        .gesture(
            //            TapGesture()
            //                .onEnded { _ in
            //                    print("Image was tapped")
            //                })
            
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
    }
    
    @State private var tapped = false
    
    var tap: some Gesture {
        TapGesture(count: 1)
            .onEnded{ _ in
                
            }
    }
    
    private func getTapGesture(_ title: String) -> some Gesture {
        TapGesture(count: 1)
            .onEnded { value in
                print(tapped)
                self.isNavigationActive = true
                openViewName = title
            }
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
