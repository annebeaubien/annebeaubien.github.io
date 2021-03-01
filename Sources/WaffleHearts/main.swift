import Foundation
import Publish
import Plot

// This type acts as the configuration for your website.
struct WaffleHearts: Website {
    enum SectionID: String, WebsiteSectionID {
        case about
        case recipes
        case howTo
        #error("populate 'how to' section")
        case posts
        case links
        case siteIndex = "Index"
    }

    struct ItemMetadata: WebsiteItemMetadata {
    }

    // Update these properties to configure your website:
    var url = URL(string: "https://your-website-url.com")!
    var name = "WaffleHearts"
    var description = ""
    var language: Language { .english }
    var imagePath: Path? { nil }
}

// This will generate your website using the built-in Foundation theme:
let wf = WaffleHearts()
try wf.publish(withTheme: .basic)
