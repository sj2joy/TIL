

import UIKit

/***************************************************
 UIDevice
 - 디바이스 이름 / 모델 / 화면 방향 등
 - OS 이름 / 버전
 - 인터페이스 형식 (phone, pad, tv 등)
 - 배터리 정보
 - 근접 센서 정보
 - 멀티태스킹 지원 여부
 ***************************************************/


final class ViewController: UIViewController {
    
    @IBOutlet private weak var label: UILabel!
    let device = UIDevice.current //변수로 미리 만들어둠 (자주 쓰기 때문에)
    let notiCenter = NotificationCenter.default
    
    @IBAction private func systemVersion() {
        print("\n---------- [ System Version ] ----------\n")
        
        print("System name :", device.systemName) //현재 플랫폼이 무엇인지에 대한 정보
        let systemVersion = device.systemVersion
        print("System Version : ", systemVersion)
        label.text = systemVersion
        
        let splitVersion = systemVersion.split(separator: ".").compactMap { Int($0) }
        print(splitVersion)//좀 더 세부적인 버전 정보로 분류가 필요 할 때 ?
        
    }
    
    @IBAction private func architecture() {
        print("\n---------- [ Architecture ] ----------\n")
        
        #if targetEnvironment(simulator) // 여기서 if는 디버깅 목적의 환경변수를 쓸 ㄸ ㅐ 사용
        print("Simulator")
        label.text = "Simulator"
        
        #else
        print("Device") //핸드폰으로 시뮬레이팅 하면 이거 프린트 됨
        label.text = "Device"
        
        #endif
        
        #if DEBUG
        //시뮬레이터에서 실행하는건 여기에 들어감(run시키는거) , 개발단계에서 사용(print)같은거
        #else
        //나머지는 여기
        #endif
        
        
        //ios 여부 (target_os_ mac,ios, 등등많음)// target - 세부적인 기기환경을 볼수잇게
        print("TARGET_OS_IOS :" , TARGET_OS_IOS) //1이면 true , 0이면 false
        
        print("TARGET_OS_SIMULATOR :" , TARGET_OS_SIMULATOR) //시뮬레이터이기 때문에 true = 1
        print("TARGET_CPU_X86 :" , TARGET_CPU_X86)//64비트이므로 false = 0
        print("TARGET_CPU_X86_64 :" , TARGET_CPU_X86_64)//기기의 cpu 체크 , but 지금은 전부 64비트라 잘안씀
        
        print("TARGET_CPU_ARM :" , TARGET_CPU_ARM) //시뮬레이터라 0
        print("TARGET_CPU_ARM64 :" , TARGET_CPU_ARM64)//시뮬레이터라 0
        
    }
    
    @IBAction private func deviceModel() {
        print("\n---------- [ Device Model ] ----------\n")
        print("name : ", device.name) //내 핸드폰에 설정한 이름, 시뮬레이터일 경우 기기 이름
        print("model : ", device.model)
        print("localizedModel : ", device.localizedModel) //다른나라에서 모델명이 별도로 주어지거나 할 때
        print("userInterfaceIdiom : ", device.userInterfaceIdiom) //폰인지,tv인지 carplay인지 등등
        print("orientation : ", device.orientation) // 방향
        print("isMultitaskingSupported : ", device.isMultitaskingSupported)//멀티태스킹 지원 여부
        
        //extension
        print("----extension---- ")
        print("modelIdentifier : ", device.identifier)
        print("modelName : ", device.modelName)
        label.text = "\(device.identifier): \(device.modelName)"
        
        print("simulatorModelName: ", device.simulatorModelName)
    }
    
    
    // MARK: - Battery
    //
    //    public enum UIDeviceBatteryState : Int {
    //        case unknown
    //        case unplugged //on battery, discharging
    //        case charging //plugged in , less than 100%
    //        case full // plugged in , at 100%
    //    }
    
    @IBAction private func battery() {
        print("\n-------------------- [ Battery Info ] --------------------\n")
        
        //아래 두줄만 쓰면 제대로 안나옴 , 여기선 다 써도 시뮬레이터라 제대로 프린트 안됨
        print("batteryState : ", device.batteryState) 
        print("batteryLevel : ", device.batteryLevel) //배터리 잔량
        
        print("isBatteryMonitoringEnabled : ", device.isBatteryMonitoringEnabled)//<-- 이걸 써줘야함 + 아래확인
        label.text = "\(device.batteryState) : \(device.batteryLevel)"
        
    }
    
    @IBAction private func batteryMonitoring(_ sender: UIButton) {
        print("\n---------- [ batteryMonitoring ] ----------\n")
        sender.isSelected.toggle()
        device.isBatteryMonitoringEnabled.toggle()//여기까지 써줘야 제대로 다 나옴(다른 버튼에서)
        
        if device.isBatteryMonitoringEnabled { // 모니터링이 활성화 되엇을때
            notiCenter.addObserver(self,//batterystate가 변경되면 실행되는
                selector: #selector(didChangeBatteryState(_:)),
                name: UIDevice.batteryStateDidChangeNotification,
                object: nil
            )
        } else {
            notiCenter.removeObserver(self,
                                      name: UIDevice.batteryStateDidChangeNotification,
                                      object: nil
            )
        }
    }
    
    @objc func didChangeBatteryState(_ noti: Notification) {
        guard let device = noti.object as? UIDevice else { return }
        print("batteryState :" , device.batteryState)
        print("batteryLevel :" , device.batteryLevel)
    }
    
    
    // MARK: - Proximity State 근접센서
    
    @IBAction private func proximityMonitoring(_ sender: UIButton) {
        print("\n-------------------- [ Proximity Sensor ] --------------------\n")
        sender.isSelected.toggle()
        device.isProximityMonitoringEnabled.toggle()
        print("ProximityMonitoring :" , device.isProximityMonitoringEnabled) //카메라 쪽에 가리면 모니터가 꺼짐
        
        
        //켜져있거나 꺼져있을 때 true false값 반환하게
        if device.isProximityMonitoringEnabled {
            notiCenter.addObserver(self, //isProximityMonitoringEnabled(모니터링)가 활성화 됐을 때
                selector: #selector(didChangeProximityState(_:)),
                name: UIDevice.proximityStateDidChangeNotification,
                object: nil
            )
        } else {
            notiCenter.removeObserver(self, //모니터링을 비활성화 했을 때
                name: UIDevice.proximityStateDidChangeNotification,
                object: nil)
        }
    }
    
    @objc func didChangeProximityState(_ noti: Notification) {
        print(UIDevice.current.proximityState)
        label.text = "\(UIDevice.current.proximityState)"
    }
    
    
    // MARK: - Orientation Notification 핸드폰의 방향, 방향에 따라서 작업을 하고 싶을 때
    
    @IBAction private func beginOrientationNotification() {//기본값 true, add옵저버만 등록해놓으면 됨
        print(device.isGeneratingDeviceOrientationNotifications)//현재 디바이스 방향에 관한 확인
        device.beginGeneratingDeviceOrientationNotifications()//endOrientation을 풀어주는?
        label.text = "\(device.isGeneratingDeviceOrientationNotifications)"
        
        notiCenter.addObserver(self,//한번 클릭하고 방향 돌리면 프린트찍힘
                               selector: #selector(orientationDidChange(_:)),
                               name: UIDevice.orientationDidChangeNotification,
                               object: nil
        )
    }
    
    @objc func orientationDidChange(_ noti: Notification) {//방향 바뀔때마다 호출됨
        print("\n----------------- [ oriental didChange ] ------------------ \n")
        if let device = noti.object as? UIDevice {
            print("Device Orientation :" , device.orientation)
            //faceup, facedown 은 화면을 바닥으로 하거나 천장쪽으로 할 때 호출됨
        }
        if #available(iOS 13, *) {//interfaceOrientation
            let scene = UIApplication.shared.connectedScenes.first//SceneDelegate을 사용할 때
            let orientation = (scene as! UIWindowScene).interfaceOrientation
            print(orientation)
        } else {//SceneDelegate 사용하지 않을 때
            let orientation = UIApplication.shared.statusBarOrientation
            print("StatusBar Orientation :", orientation)
            print(orientation.isPortrait)
            print(orientation.isLandscape)
            //            statusbar orientation의 값 중 upsidedown은 노치 있는 기기에서는 미지원 (iphone 8 이하에서는 지원)
//            NotificationCenter.default.addObserver(self,
//                                                   selector: #selector(keyboardWillShowNotification(_:)),
//                                                   name: UIResponder.keyboardWillShowNotification,
//                                                   object: nil)
//            NotificationCenter.default.addObserver(self,
//                                                   selector: #selector(keyboardWillShowNotification(_:)),
//                                                   name: UIResponder.keyboardWillHideNotification,
//                                                   object: nil
//            @objc func keyboardWillShowNotification(_ noti: Notification) { //키보드가 나타나거나 없어질 때 실행될 메서드 지정하는곳
//                guard let userInfo = noti.userInfo,
//                    let frame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
//                    let duration = userInfo[UIResponder.keyboardAnimationUserInfoKey] as? TimeInterval
//                    else { return }
//
//                if frame.origin.y >= UIScreen.main.bounds.hegith {
//
//                }
//                UIView.animate(withDuration: duration)
//
//            }
        }
    }
    
    @IBAction private func endOrientationNotification() {//orientation 끌 때, 화면전환을 해도 안바뀜
        while device.isGeneratingDeviceOrientationNotifications { //true값이 아닐때까지 반복하도록
            //while을 쓰는 이유는endOrientationNotification을 3번 클릭하면 beginOrientationNotification도 3번 클릭을 해야 하기 때문에 한번만 클릭해도 변경이 되도록 , 즉 while문이 true값이 한번에 되도록?
            device.endGeneratingDeviceOrientationNotifications()
            print("isGeneratingDeviceOrientationNoti :" , device.isGeneratingDeviceOrientationNotifications)
        }
        notiCenter.removeObserver(self,
                                  name: UIDevice.orientationDidChangeNotification,
                                  object: nil)
        label.text = "\(device.isGeneratingDeviceOrientationNotifications)"
        print("endOrientation")
    }
}





