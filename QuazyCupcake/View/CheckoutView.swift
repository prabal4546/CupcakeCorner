//
//  CheckoutView.swift
//  QuazyCupcake
//
//  Created by PRABALJIT WALIA     on 28/10/20.
//

import SwiftUI


struct CheckoutView: View {
    @ObservedObject var order:Order
    
    var body: some View {
        GeometryReader{geo in
            ScrollView{
                VStack{
                    Image("cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width:geo.size.width)
                    Text("Your total is $\(self.order.cost, specifier: "%.2f")")
                        .font(.title)
                    
                    Button("Place Order") {
                        // place the order
                    }
                    .padding()
                }
                
            }
        }
        .navigationBarTitle("Check Out", displayMode: .inline)
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
