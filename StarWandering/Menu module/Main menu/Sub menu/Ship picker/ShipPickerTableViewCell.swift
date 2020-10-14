
import UIKit

class ShipPickerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var shipImageView: UIImageView!
    @IBOutlet weak var shipNameLabel: UILabel!
    @IBOutlet weak var shipSpeddLabel: UILabel!
    @IBOutlet weak var shipDamageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
