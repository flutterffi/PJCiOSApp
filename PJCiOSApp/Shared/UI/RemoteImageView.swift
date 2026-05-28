import Kingfisher
import UIKit

final class RemoteImageView: UIImageView {
    func setImage(url: URL?, placeholder: UIImage? = nil) {
        kf.setImage(with: url, placeholder: placeholder)
    }

    func cancelImageRequest() {
        kf.cancelDownloadTask()
    }
}
