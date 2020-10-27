//
//  ContentView.swift
//  QuazyCupcake
//
//  Created by PRABALJIT WALIA     on 23/10/20.
//

import SwiftUI


struct ContentView: View {
    //this object of Order class will be shared by all the screens in the app so that all work with the same data
    @ObservedObject var order = Order()
    
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    Picker("Select your cupcake type",selection:$order.type){
                        ForEach(0..<Order.types.count){
                            Text(Order.types[$0])
                            
                        }
                    }
                }
                Section{
                    Stepper(value: $order.quantity, in: 3...20){
                        Text("number of cakes: \(order.quantity)")
                    }
                }
                Section{
                    Toggle(isOn: $order.specialRequestEnabled.animation()){
                        Text("Any special requests?")
                    }
                    if order.specialRequestEnabled{
                        Toggle(isOn:$order.extraFrosting){
                            Text("Add extra frosting")
                        }
                        Toggle(isOn: $order.addSprinkles) {
                                  Text("Add extra sprinkles")
                              }
                    }
                }
                Section{
                    NavigationLink(destination:AddressView(order: order)){
                        Text("delivery details")
                    }
                }
            }.navigationBarTitle("Cupcake Corner")
    }
}

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
