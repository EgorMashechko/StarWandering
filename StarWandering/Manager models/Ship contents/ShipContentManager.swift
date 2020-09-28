
import UIKit

class ShipContentManager {
    
//MARK: Properties
    static var shared: ShipContentManager = ShipContentManager()
    
    var ships: [Ship]?
    
//MARK: Initialization
    private init() {
        loadContent()
    }
    
//MARK: Methods
    private func loadContent() {
        if let fileUrl = Bundle.main.url(forResource: "ShipContent", withExtension: "json") {
            if let data = try? Data(contentsOf: fileUrl, options: .mappedIfSafe) {
                let decoder = JSONDecoder()
                ships = try? decoder.decode([Ship].self, from: data)
            }
        }
    }
    
}
