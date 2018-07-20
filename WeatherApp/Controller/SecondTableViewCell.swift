import UIKit

class SecondTableViewCell: UITableViewCell {

    @IBOutlet weak var secondDate: UILabel!
    @IBOutlet weak var secondDesc: UILabel!
    @IBOutlet weak var secondMax: UILabel!
    @IBOutlet weak var secondMin: UILabel!
    @IBOutlet weak var secondImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

