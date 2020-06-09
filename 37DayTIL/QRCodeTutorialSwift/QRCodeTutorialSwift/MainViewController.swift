//
//  ViewController.swift
//  QRCodeTutorialSwift
//
//  Created by mac on 2020/06/08.
//  Copyright © 2020 Seokjin. All rights reserved.
//
//webView 쓸 때
//1.Build Phase에서 LinkBinary에서 webkit검색후 추가
//2.InfoPlist에서  App Transport Security Settings 설정후 이거 밑에
//3.Allow Arbitrary Loads 생성한다음 Yes로 변경
import UIKit
import WebKit
import AVFoundation
import QRCodeReader //오픈소스를 받았기 때문에 사용가능

class MainViewController: UIViewController {
    
    let webView = WKWebView()
    let qrcodeBtn = UIButton()
    
    //QR코드 ViewController 만듬
    lazy var readerVC: QRCodeReaderViewController = {
        let builder = QRCodeReaderViewControllerBuilder {
            $0.reader = QRCodeReader(metadataObjectTypes: [.qr], captureDevicePosition: .back)
            
            // Configure the view controller (optional)
            $0.showTorchButton        = false
            $0.showSwitchCameraButton = false
            $0.showCancelButton       = false
            $0.showOverlayView        = true
            $0.rectOfInterest         = CGRect(x: 0.2, y: 0.2, width: 0.6, height: 0.6)
        }
        
        return QRCodeReaderViewController(builder: builder)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://www.naver.com")
        let requestObj = URLRequest(url: url!)
        webView.load(requestObj)
        
        setupUI()
        
    }
    
    func setupUI() {
        webView.frame = view.frame
        view.addSubview(webView)
        
        qrcodeBtn.frame = CGRect(x: view.safeAreaInsets.left + 130, y: view.safeAreaInsets.top + 500, width: 150, height: 100)
        qrcodeBtn.backgroundColor = .white 
        qrcodeBtn.setTitle("QR 코드 인식", for: .normal)
        qrcodeBtn.setTitleColor(.black, for: .normal)
        qrcodeBtn.layer.cornerRadius = 20
        qrcodeBtn.layer.borderColor = UIColor.blue.cgColor
        qrcodeBtn.layer.borderWidth = 3
        qrcodeBtn.addTarget(self, action: #selector(qrcodeReaderLaunch(_:)), for: .touchUpInside)
        view.addSubview(qrcodeBtn)
    }
    
    @objc private func qrcodeReaderLaunch(_ sender: AnyObject) {
        print("qrcodeReaderLaunch 호출")
  
         readerVC.delegate = self
        
        //qrcodeReader가 완료되었을 때 무언가를 설정하고싶을 때
         readerVC.completionBlock = { (result: QRCodeReaderResult?) in
           print(result)
            guard let scannedUrlString = result?.value else { return }
            
            print("scannedUrlString: \(scannedUrlString)")
            let scannedUrl = URL(string: scannedUrlString)
            self.webView.load(URLRequest(url: scannedUrl!))
         }
         readerVC.modalPresentationStyle = .formSheet
        //설정된 qrcodeViewController를 화면에 보여주는역할
         present(readerVC, animated: true, completion: nil)
    }
}

//MARK: - QRCodeReaderViewControllerDelegate
extension MainViewController: QRCodeReaderViewControllerDelegate {
    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
          reader.stopScanning()

        dismiss(animated: true, completion: nil)
    }
    func readerDidCancel(_ reader: QRCodeReaderViewController) {
          reader.stopScanning()

        dismiss(animated: true, completion: nil)
    }
}
