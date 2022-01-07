//
//  test.swift
//  ProjectIMT
//
//  Created by Maël Trouillet on 07/01/2022.
//

import SwiftUI

struct Check {
  var date: String = "Date"
  var name: String = "Name"
  var amount: Double = 0.0
}

struct ContentView: View {
  @State var checks = [Check]()
  var body: some View {
    VStack {
      Text("Check count is \(checks.count)")
      Divider()
      ChecksView(checks: $checks)
    }
  }
}

struct ChecksView: View {
  @Binding var checks: [Check]
  var body: some View {
    HStack(alignment: .top, spacing: 0) {
      Button("add prereq", action: {
        self.checks.append(Check())
      })
      VStack {
          ForEach(self.checks.indices) { i in
          CheckView(check: self.$checks[i])
        }
      }
    }
  }
}

struct CheckView: View {
  @Binding var check: Check
  var body: some View {
    HStack {
      Text(check.date)
      Text(check.name)
      Text(String(check.amount))
        Button("hello") {
            self.check.amount += 1
        }
     }
  }
}
struct test_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
