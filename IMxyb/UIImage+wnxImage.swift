//
//  UIImage+wnxImage.swift

//

import Foundation

// UIImage的扩展
extension UIImage {
    /// 按尺寸裁剪图片大小
    class func imageClipToNewImage(_ image: UIImage, newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(newSize)
        image.draw(in: CGRect(origin: CGPoint.zero, size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }

    /// 将传入的图片裁剪成带边缘的原型图片
    class func imageWithClipImage(_ image: UIImage, borderWidth: CGFloat, borderColor: UIColor) -> UIImage {
        let imageWH = image.size.width
//        let border = borderWidth
        let ovalWH = imageWH + 2 * borderWidth
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: ovalWH, height: ovalWH), false, 0)
        let path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: ovalWH, height: ovalWH))
        borderColor.set()
        path.fill()
        
        let clipPath = UIBezierPath(ovalIn: CGRect(x: borderWidth, y: borderWidth, width: imageWH, height: imageWH))
        clipPath.addClip()
        image.draw(at: CGPoint(x: borderWidth, y: borderWidth))
        
        let clipImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return clipImage!
    }
    
    /// 将传入的图片裁剪成圆形图片
    func imageClipOvalImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0.0)
        let ctx = UIGraphicsGetCurrentContext()
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        ctx?.addEllipse(in: rect)
        
        ctx?.clip()
        self.draw(in: rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
}
