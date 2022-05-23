import UIKit

let jsonString = """
{
  "coupons": [
    {
      "type": "promo",
      "discount": 0.2,
      "code": "AEHD36"
    },
    {
      "type": "giftcard",
      "value": 12.0,
      "code": "GIFT_2816"
    }
  ]
}
"""

struct Checkout: Decodable {
    let coupons: [Coupon]
}

enum Coupon: Decodable {
    case promo(PromoCode)
    case giftcard(Giftcard)

    enum CodingKeys: String, CodingKey {
        case type
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        // Point 1. Decode to enum instead of string, implicitly gives you the error for unhandled types
        let type = try container.decode(Unassociated.self, forKey: .type)

        // Point 2. You can create a SVC so that it just actually becomes a `decode` call later, a little more natural compared to calling the `.init(from:)`.
        let singleValueContainer = try decoder.singleValueContainer()

        // Point 1. Exhausive check, no default anymore
        switch type {
        case .promo:
            // Point 2. The below is a little more natural than `try PromoCode(from: decoder)`
            let promo = try singleValueContainer.decode(PromoCode.self)
            self = .promo(promo)
        case .giftcard:
            let card = try singleValueContainer.decode(Giftcard.self)
            self = .giftcard(card)
        }
    }

    enum Unassociated: String, Decodable {
        case promo, giftcard
    }
}

struct PromoCode: Decodable {
    let discount: Float
    let code: String
}

struct Giftcard: Decodable {
    let value: Float
    let code: String
}

let decoder = JSONDecoder()
// Point 3. No need for force unwrapping, let's get the word out about the UTF-8 view! 🙃
let checkout = try! decoder.decode(Checkout.self, from: Data(jsonString.utf8))
