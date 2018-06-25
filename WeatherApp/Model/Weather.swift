

import Foundation
import Realm
import RealmSwift


class Weather : Object, Decodable {
    @objc dynamic var id : Int = 0
    @objc dynamic var ID = UUID().uuidString
    @objc dynamic var desc : String = ""
    @objc dynamic var icon : String  = ""
	@objc dynamic var dt : Int = 0
	@objc dynamic var pressure : Double = 0.0
    @objc dynamic var humidity : Int = 0
	@objc dynamic var speed : Double = 0.0
	@objc dynamic var deg : Double = 0.0
    @objc dynamic var min : Double = 0.0
    @objc dynamic var max : Double = 0.0
    
    override static func primaryKey()-> String? {
        return "ID"
    }
    
    private enum CodingKeys: String, CodingKey {
        
        case dt = "dt"
        case temp = "temp"
        case pressure = "pressure"
        case humidity = "humidity"
        case weather = "weather"
        case speed = "speed"
        case deg = "deg"
        case clouds = "clouds"
        case desc = "description"
        
    }
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    convenience init (id: Int, desc: String, icon: String, dt:Int, pressure: Double,
                      humidity: Int, speed: Double, deg: Double, min: Double, max: Double) {
        self.init()
        self.id = id
        self.desc = desc
        self.icon = icon
        self.dt = dt
        self.pressure = pressure
        self.humidity = humidity
        self.speed = speed
        self.deg = deg
        self.min = min
        self.max = max
    }
    
    convenience required init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    let dt = try values.decode(Int.self, forKey: .dt)
    let temp = try values.decode(Temp.self, forKey: .temp)
    let min = temp.min
    let max = temp.max
    let pressure = try values.decode(Double.self, forKey: .pressure)
    let humidity = try values.decode(Int.self, forKey: .humidity)
    let temporary = try values.decode([Temporary].self, forKey: .weather)
    let id = temporary[0].id
    let desc = temporary[0].desc
    let icon = temporary[0].icon
    let speed = try values.decode(Double.self, forKey: .speed)
    let deg = try values.decode(Double.self, forKey: .deg)
        

        self.init(id:id, desc: desc, icon: icon, dt: dt, pressure: pressure, humidity: humidity, speed: speed, deg: deg, min: min, max: max)
    }
    required init() {
        super.init()
    }

   
}


class Temporary :  Decodable {
    @objc dynamic var id : Int = 0
    @objc dynamic var desc : String = ""
    @objc dynamic var icon : String = ""
    
    enum CodingKeys : String, CodingKey  {
        case id = "id"
        case desc = "description"
        case icon = "icon"
    }
//
//    convenience required init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        let desc = try values.decode(String.self, forKey: .desc)
//        self.init()
//
//    }
    
    
}
class Temp : Decodable {
    @objc dynamic var min : Double = 0.0
    @objc dynamic var max : Double = 0.0
}
