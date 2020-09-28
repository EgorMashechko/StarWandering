

import UIKit

//MARK: Delegate
protocol ShipPickerViewDelegate: AnyObject {
    func didUserTapDone(_ view: ShipPickerView)
    func shipPickerView(_ view: ShipPickerView, didUserSelectShip ship: Ship?)
}

class ShipPickerView: UIView {

//MARK: Properties
    private var cellID = "id"
    weak var delegate: ShipPickerViewDelegate?
    @IBOutlet weak var shipPickerTableView: UITableView!

//MARK: Initialization
    override func awakeFromNib() {
        setupTableView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
//MARK: Methods
    private func setupTableView() {
        shipPickerTableView.backgroundColor = .clear
        shipPickerTableView.delegate = self
        shipPickerTableView.dataSource = self
        shipPickerTableView.tableFooterView = UIView()
        shipPickerTableView.register(UINib(nibName: "ShipPickerTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: cellID)
    }
    
    @IBAction func onDoneButton(_ sender: UIButton) {
        delegate?.didUserTapDone(self)
    }
    
}

//MARK: TableView delegate
extension ShipPickerView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ShipContentManager.shared.ships?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        guard let shipPickerCell = cell as? ShipPickerTableViewCell else {return cell}
        if let shipModel = ShipContentManager.shared.ships?[indexPath.row] {
            shipPickerCell.shipImageView.image = UIImage(named: shipModel.menuImage)
            shipPickerCell.shipNameLabel.text = shipModel.name
            shipPickerCell.shipSpeddLabel.text = String(shipModel.speed)
            shipPickerCell.shipDamageLabel.text = String(shipModel.damage)
        }
        return shipPickerCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ship = ShipContentManager.shared.ships?[indexPath.row]
        delegate?.shipPickerView(self, didUserSelectShip: ship)
    }
    
}
