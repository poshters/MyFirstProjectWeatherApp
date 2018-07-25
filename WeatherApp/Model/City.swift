import Foundation
import RealmSwift

class City: Object, Decodable {
    @objc dynamic var realmId = UUID().uuidString
    @objc dynamic var name: String = ""
    @objc dynamic var coord: Coord?
    
    override static func primaryKey() -> String? {
        return "realmId"
    }
    private enum CodingKeys: String, CodingKey {
        case name
        case coord
    }
    convenience init(name: String, coord: Coord) {
        self.init()
        self.name = name
        self.coord = coord
    }
    
    convenience required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let name = try values.decode(String.self, forKey: .name)
        let coord = try values.decode(Coord.self, forKey: .coord)
        
        self.init(name: name, coord: coord)
    }
}

class Coord: Object, Decodable {
    @objc dynamic var realmId = UUID().uuidString
    @objc dynamic var lat: Double = 0.0
    @objc dynamic var lon: Double = 0.0
    
    private enum CodingKeys: String, CodingKey {
        case lat
        case lon
    }
    convenience init(lat: Double, lon: Double) {
        self.init()
        self.lat = lat
        self.lon = lon
    }
    convenience required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let lat = try values.decode(Double.self, forKey: .lat)
        let lon = try values.decode(Double.self, forKey: .lon)
        
        self.init(lat: lat, lon: lon)
    }
    
    override static func primaryKey() -> String? {
        return "realmId"
    }
    
}
