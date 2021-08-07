import Foundation

let json = Data("""
{
  "prefix": "Hello",
  "nested": {
    "postfix": "World"
  }
}
""".utf8)

struct Output: Codable {
    private enum CodingKeys: String, CodingKey {
        case prefix, nested
    }

    private enum NestedCodingKeys: String, CodingKey {
        case postfix
    }

    let prefix: String
    var postfix: String

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        prefix = try container.decode(String.self, forKey: .prefix)
        let nestedContainer = try container.nestedContainer(keyedBy: NestedCodingKeys.self, forKey: .nested)
        postfix = try nestedContainer.decode(String.self, forKey: .postfix)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(prefix, forKey: .prefix)
        var nestedContainer = container.nestedContainer(keyedBy: NestedCodingKeys.self, forKey: .nested)
        try nestedContainer.encode(postfix, forKey: .postfix)
    }
}

var output = try! JSONDecoder().decode(Output.self, from: json)

print("\(output.prefix), \(output.postfix)")

output.postfix = "Goodbye"

let encoder = JSONEncoder()
encoder.outputFormatting = [.prettyPrinted]
let encoded = try! encoder.encode(output)

print("### Before")
print(String(data: json, encoding: .utf8)!)
print("### After ")
print(String(data: encoded, encoding: .utf8)!)
