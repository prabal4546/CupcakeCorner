//
//  CheckoutView.swift
//  QuazyCupcake
//
//  Created by PRABALJIT WALIA     on 28/10/20.
//

import SwiftUI


struct CheckoutView: View {
    @ObservedObject var order:Order
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
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
                        placeOrder()
                    }
                    .padding()
                }
                
            }
        }
        .navigationBarTitle("Check Out", displayMode: .inline)
        .alert(isPresented: $showingConfirmation){
            Alert(title: Text("Thank You"), message:Text(confirmationMessage), dismissButton: .default(Text("OK")))
        }
    }
    func placeOrder(){
        //step 1
        guard let encoded = try? JSONEncoder().encode(order)
        else{
            print("failed to encode order")
            return
        }
        //step
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/JSON", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        //step
        URLSession.shared.dataTask(with: request){data,response,error in
            //handle the result here
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
                return
            }
            if let decodedOrder = try? JSONDecoder().decode(Order.self, from: data){
                self.confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
                self.showingConfirmation = true
                
            }
                else {
                    print("Invalid response from server")
                }

            

        }.resume()
    }

    
    
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
