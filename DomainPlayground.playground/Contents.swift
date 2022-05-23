import UIKit

var greeting = "Hello, playground"

let components = URLComponents(string: "http://www.example.com/item-1/content.html")!
let domainIncludingSubdomainUnlessItIsWWW = components.host!.replacingOccurrences(of: "www.", with: "")
print(domainIncludingSubdomainUnlessItIsWWW)
