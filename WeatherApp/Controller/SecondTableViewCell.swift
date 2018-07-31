import UIKit

class SecondTableViewCell: UITableViewCell {

    @IBOutlet private weak var secondDate: UILabel!
    @IBOutlet private weak var secondDesc: UILabel!
    @IBOutlet private weak var secondMax: UILabel!
    @IBOutlet private weak var secondMin: UILabel!
    @IBOutlet private weak var secondImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
extension SecondTableViewCell {
    func setDataWeather(secondImage: String, secondDate: String, secondMax: String,
                        secondMin: String, secondDesc: String) {

        self.secondImage.image = UIImage(named: secondImage)
        self.secondDate.text = secondDate
        self.secondMax.text = secondMax
        self.secondMin.text = secondMin
        self.secondDesc.text = secondDesc
    }
}
