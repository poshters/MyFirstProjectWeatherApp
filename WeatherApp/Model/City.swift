
import Foundation
struct Coord : Codable {
    let lat : Double?
    let lon : Double?
}
struct City : Codable {
	
	let name : String?
	let coord : Coord?
	


}
