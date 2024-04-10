//Created by Halbus Development

import Foundation

struct DBImages: Codable {
    let imagePath: String?
    let imagePathUrl: String?
    
    init(imagePath: String? = nil, imagePathUrl: String? = nil) {
        self.imagePath = imagePath
        self.imagePathUrl = imagePathUrl
    }
    
    enum CodingKeys: String, CodingKey {
        case imagePath = "image_path"
        case imagePathUrl = "image_path_url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.imagePath = try container.decodeIfPresent(String.self, forKey: .imagePath)
        self.imagePathUrl = try container.decodeIfPresent(String.self, forKey: .imagePathUrl)
    }
}
