import UIKit

extension String {
    func renderToImage(usingFont font: UIFont) -> UIImage? {
        let string = (self as NSString)
        let attributes = [NSAttributedString.Key.font: font]

        // Measure how big the frame should be to not clip the text, no matter how big
        let requiredSize = string.size(withAttributes: attributes)

        // Create an image of the required size, rendering the text on a transparent background
        return UIGraphicsImageRenderer(size: requiredSize).image { _ in
            string.draw(at: .zero, withAttributes: attributes)
        }
    }
}

let frozenImage = "🥶".renderToImage(usingFont: .preferredFont(forTextStyle: .largeTitle))
let thumbsUpImage = "👍".renderToImage(usingFont: .preferredFont(forTextStyle: .body))
let screamImage = "😱".renderToImage(usingFont: .preferredFont(forTextStyle: .caption1))
let boomImage = "💥".renderToImage(usingFont: .systemFont(ofSize: 108))
let textImage = "Hello, World! 👋".renderToImage(usingFont: .preferredFont(forTextStyle: .callout))
