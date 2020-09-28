

import UIKit

//MARK: Delegate
protocol ShipPickerViewControllerDelegate: AnyObject {
    func didUserTapDone(_ vc: ShipPickerViewController)
    func shipPicker(_ vc: ShipPickerViewController, didUserChangeShip ship: Ship?)
}

class ShipPickerViewController: UIViewController {
    
    weak var delegate: ShipPickerViewControllerDelegate?
    
//MARK: LifeCycle methods
    override func loadView() {
        if let contentView = Bundle.main.loadNibNamed("ShipPickerView", owner: self, options: nil)?.first as? ShipPickerView {
            self.view = contentView
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        (self.view as? ShipPickerView)?.delegate = self
    }
}

//MARK: ShipPickerViewDelegate
extension ShipPickerViewController: ShipPickerViewDelegate {
    func didUserTapDone(_ view: ShipPickerView) {
        delegate?.didUserTapDone(self)
    }
    
    func shipPickerView(_ view: ShipPickerView, didUserSelectShip ship: Ship?) {
        if let ship = ship {
            let userDefaults = UserDefaults.standard
            userDefaults.set(ship.gameImage, forKey: "ship_image_game")
            userDefaults.set(ship.menuImage, forKey: "ship_image_menu")
            userDefaults.set(ship.speed, forKey: "ship_speed")
            userDefaults.set(ship.damage, forKey: "ship_damage")
            delegate?.shipPicker(self, didUserChangeShip: ship)
        }
    }
    
}
