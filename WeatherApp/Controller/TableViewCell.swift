import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var dateWeather: UILabel!
    @IBOutlet private weak var maxTemp: UILabel!
    @IBOutlet private weak var minTemp: UILabel!
    @IBOutlet private weak var imageWeather: UIImageView!
    @IBOutlet private weak var desc: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
extension TableViewCell {

    func setDataWeather(city: String, dateWeather: String,
                        maxTemp: String, minTemp: String, desc: String) {

        self.cityLabel.text = city
        self.dateWeather.text = dateWeather
        self.maxTemp.text = maxTemp
        self.minTemp.text = minTemp
        self.desc.text = desc
    }

    func seImageWeather(imageWeather: String ) {
        self.imageWeather.image = UIImage(named: imageWeather)
    }
}
