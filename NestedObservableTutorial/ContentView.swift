//
//  ContentView.swift
//  NestedObservableTutorial
//
//  Created by Leonardo Maia Pugliese on 23/01/2023.
//

import SwiftUI

// Problem
struct ContentView: View {
    @StateObject var customerData = CustomerData(customerName: "Mike")

    @State var list = ["asd","asdasd"]
    
    var body: some View {
        VStack(alignment: .leading) {
            
            VStack(alignment: .leading) {
                Text("Customer Status: \(customerData.customerStatus.statusCode)")
                    .font(.title)
                    .foregroundColor(.white)
                
                Text("Last Updated Counter: \(customerData.customerStatus.lastUpdateCounter)")
                    .font(.subheadline)
                    .foregroundColor(.white)
                Button("Update Customer Status") {
                    customerData.refreshStatus()
                }
                .buttonStyle(.borderedProminent)
                
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.black)
            )

            VStack(alignment: .leading) {
                Text(customerData.customerName)
                    .font(.title)
                Text("\(customerData.timeStamp)")
                    .font(.subheadline)
                Button("Update Date") {
                    customerData.refreshDate()
                }
                .padding(.bottom)
                .buttonStyle(.borderedProminent)

            }
            
            MyView { event in
                switch event {
                case .image:
                    print("leoooooo")
                case .delete:
                    print("leoooo")
                }
            }
        }
        .padding()
    }
}

enum Event {
    case image
    case delete
}

struct MyView: View {
    
    let onEvent: (Event) -> Void
    
    var body: some View {
        Image(systemName: "trash")
            .onTapGesture {
                onEvent(.image)
            }
        Text("Delete")
            .onTapGesture {
                onEvent(.delete)
            }
    }
}

class CustomerData: ObservableObject {
    let customerId = UUID().uuidString
    let customerName: String
    @Published var customerStatus = CustomerStatus()
    @Published var timeStamp = Date()
    @State var lastUpdateCounter = 0

    init(customerName: String) {
        self.customerName = customerName
    }

    func refreshStatus() {
        customerStatus.refreshStatus()
    }

    func refreshDate() {
        timeStamp = Date()
    }
}

class CustomerStatus: ObservableObject {
    var statusCode = 100
    @Published var lastUpdateCounter = 1

    func refreshStatus() {
        lastUpdateCounter += 1
    }
}

// ---- - -- - - - - -- - - - - -- ----- - -- - - - - -- - - - - -- ----- - -- - - - - -- - - - - -- -

// Extract to some View State
//struct ContentView: View {
//    @StateObject var customerData = CustomerData(customerName: "Mike")
//    @State var counter = 0
//
//    var body: some View {
//        VStack(alignment: .leading) {
//
//            VStack(alignment: .leading) {
//                Text(customerData.customerName)
//                    .font(.title)
//                Text("\(customerData.timeStamp)")
//                    .font(.subheadline)
//                    .padding(.bottom)
//            }
//
//
//            VStack(alignment: .leading) {
//                Text("Customer Status: \(customerData.customerStatus.statusCode)")
//                    .font(.title)
//                    .foregroundColor(.white)
//
//                Text("Last Updated Counter:  \(counter)")
//                    .font(.subheadline)
//                    .foregroundColor(.white)
//                    .onReceive(customerData.customerStatus.$lastUpdateCounter) { counter in
//                        self.counter = counter
//                    }
//                Button("Update Customer Status") {
//                    customerData.refreshStatus()
//                }
//                .buttonStyle(.borderedProminent)
//
//            }
//            .padding()
//            .background(
//                RoundedRectangle(cornerRadius: 20)
//                    .foregroundColor(.black)
//            )
//
//        }
//        .padding()
//    }
//}
//
//class CustomerData: ObservableObject {
//    let customerId = UUID().uuidString
//    let customerName: String
//    @Published var customerStatus = CustomerStatus()
//    @Published var timeStamp = Date()
//
//    init(customerName: String) {
//        self.customerName = customerName
//    }
//
//    func refreshStatus() {
//        customerStatus.refreshStatus()
//    }
//}
//
//class CustomerStatus: ObservableObject {
//    var statusCode = 100
//    @Published var lastUpdateCounter = 1
//
//    func refreshStatus() {
//        lastUpdateCounter += 1
//    }
//}

// ---------------------------------------------------------------------------------------

// use objectWillChange.send() function every time you want to update something
//struct ContentView: View {
//    @StateObject var customerData = CustomerData(customerName: "Mike")
//
//    var body: some View {
//        VStack(alignment: .leading) {
//
//            VStack(alignment: .leading) {
//                Text(customerData.customerName)
//                    .font(.title)
//                Text("\(customerData.timeStamp)")
//                    .font(.subheadline)
//                    .padding(.bottom)
//            }
//
//
//            VStack(alignment: .leading) {
//                Text("Customer Status: \(customerData.customerStatus.statusCode)")
//                    .font(.title)
//                    .foregroundColor(.white)
//
//                Text("Last Updated Counter: \(customerData.customerStatus.lastUpdateCounter)")
//                    .font(.subheadline)
//                    .foregroundColor(.white)
//                Button("Update Customer Status") {
//                    customerData.refreshStatus()
//                }
//                .buttonStyle(.borderedProminent)
//
//            }
//            .padding()
//            .background(
//                RoundedRectangle(cornerRadius: 20)
//                    .foregroundColor(.black)
//            )
//
//        }
//        .padding()
//    }
//}
//
//class CustomerData: ObservableObject {
//    let customerId = UUID().uuidString
//    let customerName: String
//    @Published var customerStatus = CustomerStatus()
//    @Published var timeStamp = Date()
//
//    init(customerName: String) {
//        self.customerName = customerName
//    }
//
//    func refreshStatus() {
//        customerStatus.refreshStatus()
//        objectWillChange.send()
//    }
//}
//
//class CustomerStatus: ObservableObject {
//    var statusCode = 100
//    @Published var lastUpdateCounter = 1
//
//    func refreshStatus() {
//        lastUpdateCounter += 1
//    }
//}

// -------------------- -------------------- ---------------------------- -------------------

// Extract the Nested Observable and use it directly
//struct ContentView: View {
//    @StateObject var customerData = CustomerData(customerName: "Mike")
//    @StateObject var customerStatus = CustomerStatus()
//
//    var body: some View {
//        VStack(alignment: .leading) {
//
//            VStack(alignment: .leading) {
//                Text(customerData.customerName)
//                    .font(.title)
//                Text("\(customerData.timeStamp)")
//                    .font(.subheadline)
//                    .padding(.bottom)
//            }
//
//
//            VStack(alignment: .leading) {
//                Text("Customer Status: \(customerStatus.statusCode)")
//                    .font(.title)
//                    .foregroundColor(.white)
//
//                Text("Last Updated Counter: \(customerStatus.lastUpdateCounter)")
//                    .font(.subheadline)
//                    .foregroundColor(.white)
//                Button("Update Customer Status") {
//                    customerStatus.refreshStatus()
//                }
//                .buttonStyle(.borderedProminent)
//
//            }
//            .padding()
//            .background(
//                RoundedRectangle(cornerRadius: 20)
//                    .foregroundColor(.black)
//            )
//
//        }
//        .padding()
//    }
//}
//
//class CustomerData: ObservableObject {
//    let customerId = UUID().uuidString
//    let customerName: String
//    @Published var timeStamp = Date()
//
//    init(customerName: String) {
//        self.customerName = customerName
//    }
//}
//
//class CustomerStatus: ObservableObject {
//    var statusCode = 100
//    @Published var lastUpdateCounter = 1
//
//    func refreshStatus() {
//        lastUpdateCounter += 1
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
