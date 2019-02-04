//
//  DrawingImageView.swift
//  MLNumbers
//
//  Created by Felipe Alarcon on 12/09/2018.
//  Copyright © 2018 Felipe Alarcon. All rights reserved.
//

import UIKit

class DrawingImageView: UIImageView {

    weak var delegate : ViewController?
    var courrentTouchPosition : CGPoint?
    
    
    
/*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        let renderer = UIGraphicsImageRenderer(size: self.bounds.size)
        

    }
 */
    
    func draw(from start: CGPoint, to end: CGPoint){
        let renderer = UIGraphicsImageRenderer(size: self.bounds.size)
        
        self.image = renderer.image{ ctx in
            self.image?.draw(in: self.bounds)
            
//            definir los parametros del trazo
            UIColor.darkGray.setStroke()
            ctx.cgContext.setLineCap(.round)
            ctx.cgContext.setLineWidth(9)
//            se dibuja una recta continua desde el punto de inico al punto final
            ctx.cgContext.move(to: start)
            ctx.cgContext.addLine(to: end)
            ctx.cgContext.strokePath()
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.courrentTouchPosition = touches.first?.location(in: self)
//        cancela cualquier accion de la clase
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        guard let newTouchPoint = touches.first?.location(in: self) else{
            return
        }
        guard let previousTouchPoint = self.courrentTouchPosition else{
            return
        }
        
        draw(from: previousTouchPoint, to: newTouchPoint)
        self.courrentTouchPosition = newTouchPoint
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self.courrentTouchPosition = nil
        
        perform(#selector(numberDrawOnScreen), with: nil, afterDelay: 0.5)
    }
    
    
    
    @objc func numberDrawOnScreen(){
//        notifica al viewcontroller cuando el usuario a dejado de dibujar
        guard let image = self.image else{
            return
        }
       
        let drawRect = CGRect(x: 0, y: 0, width: 28, height: 28)
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1
        
        let renderer = UIGraphicsImageRenderer(bounds: drawRect, format: format)
        
        let imageWithWhiteBackgound = renderer.image { (ctx) in
            UIColor.white.setFill()
            ctx.fill(bounds)
            image.draw(in: drawRect)
            
        }
//        convertimos una UIimage de CG a CI
        let ciImage = CIImage(cgImage: imageWithWhiteBackgound.cgImage!)
        
//        hacer la invercion de color
        if let filter = CIFilter(name: "CIColorInvert"){
//            define la CIImage como imagen a ser filtrada
            filter.setValue(ciImage, forKey: kCIInputImageKey)
            
//            contexto para llevar a cabo el filtro
            let context = CIContext(options: nil)
            if let outputImage = filter.outputImage{
//                intentando hacer la creacion a  CIImage
                if let imageRef = context.createCGImage(outputImage, from: ciImage.extent){
                    let resultImage = UIImage(cgImage: imageRef)
                    
                    self.delegate?.numberDrawn(resultImage)
                }
            }
        }
        
    }

}
